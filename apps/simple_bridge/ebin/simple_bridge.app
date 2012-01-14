{application,simple_bridge,
             [{description,"Common Interface to Erlang HTTP Servers"},
              {vsn,"1.2.0"},
              {applications,[kernel,stdlib,sasl]},
              {registered,[]},
              {modules,[inets_request_bridge,inets_response_bridge,
                        simple_bridge,simple_bridge_multipart,
                        simple_bridge_request,simple_bridge_request_wrapper,
                        simple_bridge_response,
                        simple_bridge_response_wrapper]}]}.