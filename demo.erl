-module(demo).
-export([double_num/1]).

double_num(X)->
    times(X,2).

times(X,N)->
    X*N.