-module(p09).
-export([pack/1]).

pack(List) -> pack(List, []).
pack([], _) -> [];
pack([H, H | T], M) -> pack([H | T], [H | M]);
pack([H | T], M) -> [[H | M] |  pack(T,[] )].
