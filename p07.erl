-module(p07).
-export([flatten/1]).

flatten(List) -> flatten(List, []).
flatten([], List) -> List;
flatten([H | T], List) ->  flatten(H, flatten(T,List));
flatten(H, List) ->  [H | List].