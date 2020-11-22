-module(fib).
-export([fib/3]).
 
fib(1,_,Res) -> 
    io:format("~B, ",[Res]);
fib(N,Prev,Res) when N > 1 -> 
    io:format("~B, ",[Res]),
    fib(N-1, Res, Res+Prev).

