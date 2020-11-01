-module(p13).
-export([decode/1]).

decode([]) -> [];
decode([{0,K} | T]) -> decode(T);
decode([{Num, K} | T]) -> [K | decode([{Num-1, K} | T])].