-module(p05).
-export([reverse/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

reverse(List) -> reverse(List, []).
reverse([], Reverse_List) -> Reverse_List;
reverse([H | T], Reverse_List) -> reverse(T, [H | Reverse_List]).

%test

-ifdef(TEST).
reverse_test() ->
    ?assertEqual([3,2,1]), reverse([1,2,3]),
    ?assertEqual([4,2.2,a], reverse([a,2.2, 4])),
    ok.
-endif.