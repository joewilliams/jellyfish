-module(jellyfish).
-export([start/1, stop/0]).

%% External API

start(Port) ->
    dets:open_file(clients, [{type, bag}]),
    misultin:start_link([{port, Port},
                         {loop, fun(Req) -> route_rest(Req) end},
                         {ws_loop, fun(Ws) -> handle_websocket(Ws) end}]).

stop() -> dets:close(clients),
          misultin:stop().

%% Internal API

route_rest(Req) ->
    handle_r(Req:get(method), Req:resource([lowercase, urldecode]), Req).

handle_r('GET', [], Req) -> Req:file("index.html");
handle_r('POST', ["deploy"], Req) ->
    Req:ok([{"Content-Type", "text/plain"}], util:rand_hex(16));
handle_r('POST', ["deploy", Id], Req) ->
    signal(Id),
    Req:ok([{"Content-Type", "text/plain"}], "OK");
handle_r('GET', ["deploy", Id], Req) ->
    signal(Id),
    Req:ok([{"Content-Type", "text/plain"}], "OK");
handle_r(_, _, Req) ->
    Req:ok([{"Content-Type", "text/plain"}], "Page not found.").

handle_websocket(Ws) ->
    receive
        {browser, _} ->
            dets:insert(clients, {util:last_token(Ws:get(path)),
                                  self()}),
            handle_websocket(Ws);
        {event} ->
            Ws:send("event"),
            handle_websocket(Ws);
        _ ->
            handle_websocket(Ws)
    end.

signal(Id) ->
    [ Pid ! {event} || {_, Pid} <-
                           dets:lookup(clients, Id)].
