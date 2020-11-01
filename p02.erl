-module(p02).
-export([but_last/1]).

but_last([_A,_B]=X)->X;
but_last([_H|T])->but_last(T).

