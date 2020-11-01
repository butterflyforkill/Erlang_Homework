-module(p12).
-export([decode_modified/1]).

decode_modified(List) -> decode_modified(List, 1).
decode_modified([], 1) -> [];
decode_modified([{Num, Str} | T], 1) -> decode_modified([Str | T], Num);
decode_modified([H | T], 1) -> [H | decode_modified(T, 1)];
decode_modified([Str | T], Num) -> [Str | decode_modified([Str | T], Num-1)].
