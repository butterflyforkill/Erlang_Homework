-module(p15).
-export([replicate/2]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
%%sometimes i think that erlang is dark magic)

%% Interface 
replicate(List,Num) ->
    replicate(List,Num,Num,[]).

replicate([_H|T],Num,0,Acc) ->
    replicate(T,Num,Num,Acc);

replicate([H|T],Num,Count,Acc) ->
   [H|replicate([H|T],Num,Count-1,Acc)];

replicate([],_,_,List) ->
    p05:reverse(List).

%test

-ifdef(TEST).
replicate_test() ->
    ?assertEqual([a,a,a,b,b,b,c,c,c], replicate([a,b,c], 3)),
    ?assertEqual([a,a,a,a,a,b,b,b,b,b,c,c,c,c,c], replicate([a,b,c], 5)),
    ?assertEqual([], replicate([], 3)),
    ?assertEqual([], replicate([a,b,c], 0)),
    ok.
-endif.
