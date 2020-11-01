-module(p15).
-export([replicate/2]).

replicate(List, Num) -> replicate(List, Num, Num).
replicate([_H | T], Num, 0) -> replicate(T, Num, Num);
replicate([H | T], Num, F) -> [H | replicate([H | T], Num, F-1)];
replicate([],_,_) -> [].
