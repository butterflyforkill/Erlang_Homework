-module(p02).
-export([but_last/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

but_last([_A,_B]=X)->X;
but_last([_H|T])->but_last(T).


% test
-ifdef(TEST).
but_last_test() ->
    ?assertEqual([e,f], but_last([a,b,c,d,e,f])),
    ?assertEqual([1.2,12], but_last([a,3,5,1.2,12])),
    ?assertEqual(empty_list, but_last([])),
    ok.
-endif.