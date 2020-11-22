-module(p12).
-export([decode_modified/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%% Interface
decode_modified(L) ->
    decode_modified(L,{},[]).
decode_modified([],_,[]) -> [];

decode_modified([H|T],{},List) ->
    decode_modified(T,H,List);

decode_modified([H|T],{Num,Str},List) ->
    decode_modified(T,H,[replicate(Str,Num)|List]);

decode_modified([H|T],_Element = Str,List) ->
    decode_modified(T,H,[Str|List]);


decode_modified([],{Num,Str},List) ->
    p07:flatten(p05:reverse([replicate(Str,Num)|List]));
decode_modified([],Str,List) ->
    p07:flatten(p05:reverse([Str|List])).

%%private fun
replicate(Element,Num) ->
    replicate(Element,Num,[]).
replicate(_,0,L) ->
    L;
replicate(Element,Num,Acc) ->
   [Element|replicate(Element,Num-1,Acc)].
%test

-ifdef(TEST).
decode_modified_test() ->
    ?assertEqual([a,a,a,a,b,c,c,a,a,d,e,e,e,e], decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}])),
    ?assertEqual([], decode_modified([])),
    ok.
-endif.