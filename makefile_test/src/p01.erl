-module(p01).
-export([last/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

%%function
last([H|[]])-> H;
last([_|T])-> last(T).

%%test
-ifdef(TEST).
last_test() ->
    ?assertEqual(f, last([a,b,c,d,e,f])),
    ?assertEqual(empty_list, last([])),
    ?assertEqual(1, last([a,e,1])),
    ok.
-endif.
