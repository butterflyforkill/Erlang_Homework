-module(p11).
-export([encode_modified/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.


%% private fun
len([_H|T]) -> 1+len(T);
len([]) ->
    0.

%% Interface
encode_modified(L) ->
    encode_modified(L,[],[],0).

encode_modified([],[],[],_) -> [];

encode_modified([H|T], [], Acc,0) ->
    encode_modified(T,[H],Acc,0);

encode_modified([H|T], [H|Rest], Acc,_) ->
    encode_modified(T, [H,H|Rest], Acc,len([H,H|Rest]));

encode_modified([H|T], [Head|_],Acc,1) ->
    encode_modified(T,[H],[Head|Acc],1);

encode_modified([H|T], [Head|Rest],Acc,_) ->
    encode_modified(T,[H],[{len([Head|Rest]),Head}|Acc],1);

encode_modified([],[H|_T],Acc,1) ->
    p05:reverse([H|Acc]);

encode_modified([],[H|T],Acc,_) ->
    p05:reverse([{len([H|T]),H}|Acc]).

%test

-ifdef(TEST).
encode_modified_test() ->
    ?assertEqual([{4,a},b,{2,c},{2,a},d,{4,e}], encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e])),
    ?assertEqual([], encode_modified([])),
    ok.
-endif.