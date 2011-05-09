-module(jellyfish).
-export([start/1, stop/0]).

start(Port) ->
	misultin:start_link([{port, Port}, {loop, fun(Req) -> handle_http(Req) end}, {ws_loop, fun(Ws) -> handle_websocket(Ws) end}]).

stop() ->
	misultin:stop().

handle_http(Req) ->
	handle(Req:get(method), Req:resource([lowercase, urldecode]), Req).

handle('GET', [], Req) ->
    	Req:file("index.html");
handle('POST', ["deploy"], Req) ->
	Req:ok([{"Content-Type", "text/plain"}], util:rand_hex(16));
handle('GET', ["deploy", Id], Req) ->
	Req:ok([{"Content-Type", "text/plain"}], "~s", [Id]);
handle(_, _, Req) ->
	Req:ok([{"Content-Type", "text/plain"}], "Page not found.").

handle_websocket(Ws) ->
	receive
		{browser, Data} ->
			Ws:send(["received '", Data, "'"]),
			handle_websocket(Ws);
		_Ignore ->
			handle_websocket(Ws)
	after 5000 ->
		Ws:send("pushing!"),
		handle_websocket(Ws)
	end.
