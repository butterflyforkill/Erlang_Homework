-module(p13).
-export([decode/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

decode([]) -> [];

decode([{2,Num}|[]])->
    [Num,Num];

decode([{1,Num}|[]])->
    [Num];

decode([{Count,Num}|[]])->
    [Num|decode([{Count-1,Num}])];

decode([{2,Num}|T])->
    [Num|[Num|decode(T)]];

decode([{1,Num}|T])->
    [Num|decode(T)];

decode([{Count,Num}|T])->
    [Num|decode([{Count-1,Num}|T])];

decode([H|[{Count,Num}|T]])->
    [H|decode([{Count,Num}|T])];

decode([H|[]])->
    [H].

%test

-ifdef(TEST).
decode_test() ->
    ?assertEqual([a,a,a,a,b,c,c,a,a,d,e,e,e,e], decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}])),
    ?assertEqual([], decode([])),
    ok.
-endif.