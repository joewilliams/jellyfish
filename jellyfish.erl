-module(jellyfish).
-export([start/1, stop/0]).

start(Port) ->
    misultin:start_link([{port, Port},
                         {loop, fun(Req) -> route_rest(Req) end},
                         {ws_loop, fun(Ws) -> handle_websocket(Ws) end}]).

stop() -> misultin:stop().

route_rest(Req) ->
    handle_r(Req:get(method), Req:resource([lowercase, urldecode]), Req).

handle_r('GET', [], Req) -> Req:file("index.html");
handle_r('POST', ["deploy"], Req) ->
    Req:ok([{"Content-Type", "text/plain"}], util:rand_hex(16));
handle_r('GET', ["deploy", Id], Req) ->
    Req:ok([{"Content-Type", "text/plain"}], "~s", [Id]);
handle_r(_, _, Req) ->
    Req:ok([{"Content-Type", "text/plain"}], "Page not found.").

handle_websocket(Ws) ->
    receive
        _Ignore ->
            handle_websocket(Ws)
    after 5000 ->
            Ws:send(pid_to_list(self())),
            handle_websocket(Ws)
    end.
