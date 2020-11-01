-module(p06).
-export([is_palindrome/1]).

is_palindrome(List) -> is_palindrome(List, List, []).
is_palindrome([H1|T1], [], [H1|T2]) -> is_palindrome(T1, [], T2);
is_palindrome(List, [H | T], ReversList) -> is_palindrome(List, T, [H | ReversList]);
is_palindrome([], [], []) -> true;
is_palindrome(_, [], _) -> false.