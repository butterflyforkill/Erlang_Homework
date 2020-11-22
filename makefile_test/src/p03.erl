-module(p03).
-export([element_at/2]).
-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").
-endif.

element_at([], _) -> undefined;
element_at([H | _T], 1) -> H;
element_at([_H | T], Num) -> element_at(T, Num - 1).

%test

-ifdef(TEST).
element_at_test()->
    ?assertEqual(d, element_at([a,b,c,d,e],4)),
    ?assertEqual(undefined, element_at([a,b,c,d,e],10)),
    ?assertEqual(undefined,element_at([],4)),
    ok.
-endif.
