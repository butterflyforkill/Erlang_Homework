-module(p06).
-export([is_palindrome/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

is_palindrome(L) ->
    L == p05:reverse(L).


%test

-ifdef(TEST).
is_palindrome_test() ->
    ?assertEqual(true, is_palindrome([x,a,m,a,x])),
    ?assertEqual(true, is_palindrome([1,2,3,2,1])),
    ?assertEqual(true, is_palindrome([])),
    ?assertEqual(false, is_palindrome([1,3,3,2,1])),
    ok.
-endif.