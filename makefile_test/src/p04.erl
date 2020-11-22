-module(p04).
-export([len/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

len(List) -> len(List, 0).
len([_| T], Num) -> len(T, Num+1);
len([],Num) -> Num.

%test

-ifdef(TEST).
len_test() ->
    ?assertEqual(0, len([])),
    ?assertEqual(4, len([a,b,c,d])),
    ok.
-endif.