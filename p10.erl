-module(p10).
-export([encode/1]).

encode(List) -> encode(List, 1).
encode([], _) -> [];
encode([H, H | T], Num) -> encode([H | T], Num + 1);
encode([H | T], Num) -> [{Num, H} | encode(T, 1)].