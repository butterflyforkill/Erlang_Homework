-module(p14).
-export([duplicate/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

duplicate(List) ->
    duplicate(List,[]).

duplicate([H|T],Acc) ->
    duplicate(T,[H,H|Acc]);

duplicate([],List) ->
    p05:reverse(List).

%test

-ifdef(TEST).
duplicate_test() ->
    ?assertEqual([a,a,b,b,c,c,c,c,d,d], duplicate([a,b,c,c,d])),
    ?assertEqual([], duplicate([])),
    ok.
-endif.