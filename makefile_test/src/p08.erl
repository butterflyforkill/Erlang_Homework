-module(p08).
-export([compress/1]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

compress(List) ->
    compress(List,[]). %% Interface %%

compress([H|T],Acc=[H|_]) ->
    compress(T,Acc); 

compress([H|T],Acc) ->
    compress(T,[H|Acc]); 

compress([],Acc) ->
    p05:reverse(Acc).

%test
-ifdef(TEST).
compress_test() ->
    ?assertEqual([a,b,c,a,d,e], compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e])),
    ?assertEqual([], compress([])),
    ok.
-endif.
    



