-module(util).
-export([rand_hex/1, last_token/1]).

rand_hex(N) -> to_hex(crypto:rand_bytes(N)).

to_hex([]) ->
    [];
to_hex(Bin) when is_binary(Bin) ->
    to_hex(binary_to_list(Bin));
to_hex([H|T]) ->
    [to_digit(H div 16), to_digit(H rem 16) | to_hex(T)].

to_digit(N) when N < 10 -> $0 + N;
to_digit(N) -> $a + N - 10.

last_token(S) ->
    lists:last(string:tokens(S, "/")).
