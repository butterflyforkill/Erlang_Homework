-module(p04).
-export([len/1]).

len(List) -> len(List, 0).
len([H | T], Num) -> len(T, Num+1);
len([],Num) -> Num.