-module(reports).

-include_lib("nitrogen_core/include/wf.hrl").

-export([main/0, layout/0, title/0, event/1]).

-define(delimiter, #literal{text=" "}).
-define(def_rec_on_page, 30).

title() ->
   "qinfo:logs".

main() ->
   #template{file="./www/reports.html"}.

layout() ->
   TopPanel = #panel{
      body =
      [
         #link{ class=a, text = "main", url = "index"},
         #literal{ text = " | "},
         #link{ class=a, text = "settings", url = "settings"},
         #literal{ text = " | " },
         #link{ class=a, text = "scheduler", url = "scheduler"},
         #literal{ text = " | " },
         #link{ class=a, text = "instruments", url = "instruments"},
         %#literal{ text = " | "},
         %#link{ class=a, text = "statistics", url = "statistics"}
         #literal{ text = " | "},
         #literal{ text = "logs"}
      ]
   },
   RescanFilter = #p{body = [#literal{text = "Max records"}, #dropdown{id = max_reports, value = "100", options=
      [
         #option{text = "100",  value = "100"},
         #option{text = "500",  value = "500"},
         #option{text = "1000", value = "1000"},
         #option{text = "all",  value = "all"}
      ]}, #button{id = apply_button, text = "Rescan", postback = click_rescan}]},
   RecordFilter = #p{body = [#literal{text = "Grep"}, #textbox{id = reg_exp},
      ?delimiter,
      #literal{text = "Records on page"},
      #dropdown{id = max_reports, value = erlang:integer_to_list(?def_rec_on_page), options=
      [
         #option{text = "30",  value = "30"},
         #option{text = "50",  value = "50"},
         #option{text = "100", value = "100"}
      ]}, #button{text = "Apply"}]},
   Types = build_types(),
   {Records, Pages} = build_records([], all, 1, ?def_rec_on_page),
   [
      TopPanel,
      #p{},
      RescanFilter,
      RecordFilter,
      Types,
      Pages,
      Records
   ].

build_records(RegExp, Types, _Page, _RecOnPage) ->
   Records = log_viewer:list(RegExp, Types),
   Header = #tablerow{ cells = [
      #tableheader{text = "Date",         style = "width: 150px;"},
      #tableheader{text = "NN",           style = "width: 70px;" },
      #tableheader{text = "Type",         style = "width: 70px;" },
      #tableheader{text = "Process",      style = "width: 150px;"}
   ], style = "background-color: #999797;"},
   {#table{id = records, rows = [Header|build_records(Records)]}, []}.
build_records([]) ->
   [];
build_records([{No, Type,  ShortDescr, Date}|T]) ->
   [
      #tablerow{cells = [
         #tablecell{text = Date},
         #tablecell{body = [#link{text = No, postback = {details, No}}]},
         #tablecell{text = Type},
         #tablecell{text = ShortDescr}], style=make_back_color(Type)} | build_records(T)
   ].

build_types() ->
   Types = log_viewer:get_types(),
   #panel{body = [#literal{text = "Types"}, build_types(Types)]}.
build_types([]) ->
   [];
build_types([Type|Tail]) ->
   [#checkbox{id = checkbox_type, text = Type, value = Type, checked = true} | build_types(Tail)].

event(click_rescan) ->
   Types = lists:foldr(fun(Type, Acc) -> [common_utils:list_to_atom(Type)|Acc] end, [], wf:qs(checkbox_type)),
   RegExp = wf:q(reg_exp),
   Records = build_records(RegExp, Types, 1, ?def_rec_on_page),
   wf:replace(records, Records);
event(M = {details, _No}) ->
   Pid = wf:session(rdetails),
   Pid ! M.

make_back_color(Type) when Type == error orelse Type == error_report orelse Type == crash_report ->
   "background-color: #FFDDDD;";
make_back_color(Type) when Type == warning ->
   "background-color: #F9F8D0";
make_back_color(progress) ->
   "background-color: #E6F1F6;";
make_back_color(_) ->
   "background-color: #DDFFDD;".