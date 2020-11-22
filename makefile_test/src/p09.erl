-module(p09).
-export([pack/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

pack(List) -> pack(List, [], []).
pack([], [], []) -> 
    [];
pack([H|T],[],Acc) ->
    pack(T,[H],Acc);
pack([H|T],[H|Rest],Acc) ->
    pack(T,[H,H|Rest],Acc);
pack([H|T], List, Acc) ->
    pack(T,[H],[List|Acc]);
pack([],List,Acc) ->
    p05:reverse([List|Acc]).

%test
-ifdef(TEST).
pack_test() ->
    ?assertEqual([[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]], pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e])),
    ?assertEqual([],pack([])),
    ok.
-endif.
