{application,rts_plaza2,
             [{description,"RTS Plaza2 line handler"},
              {vsn,"0.1"},
              {registered,[rts_plaza2_sup,rts_plaza2_srv]},
              {applications,[kernel,stdlib]},
              {mod,{rts_plaza2_app,[]}},
              {start_phases,[]},
              {modules,[rts_plaza2_app,rts_plaza2_srv,rts_plaza2_sup]}]}.