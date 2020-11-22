-module(p10).
-export([encode/1]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%%private fun
len([_H|T]) -> 1+len(T);
len([]) ->
    0.

%% Interface
encode(L) ->
    encode(L,[],[]).

encode([],[],[]) -> [];
 
encode([H|T], [], Acc) ->
    encode(T,[H],Acc);

encode([H|T], [H|Rest], Acc) ->
    encode(T, [H,H|Rest], Acc);

encode([H|T], [Head|Rest],Acc) ->
    encode(T,[H],[{len([Head|Rest]),Head}|Acc]);

encode([],[H|T],Acc) ->
    p05:reverse([{len([H|T]),H}|Acc]).



%test
-ifdef(TEST).
encode_test() ->
    ?assertEqual([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}], encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e])),
    ?assertEqual([],encode([])),
    ok.
-endif.
