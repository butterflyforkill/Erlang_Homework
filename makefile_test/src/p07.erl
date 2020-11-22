-module(p07).
-export([flatten/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

flatten(List) -> flatten(List, []).
flatten([], List) -> List;
flatten([H | T], List) ->  flatten(H, flatten(T,List));
flatten(H, List) ->  [H | List].

%test

-ifdef(TEST).
flatten_test() ->
    ?assertEqual([a,b,c,d,e], flatten([a,[],[b,[c,d],e]])),
    ?assertEqual([a,b,c,e,b,d,e], flatten([a,[],[b,[c,[e,[[[b]]]],d],e]])),
    ?assertEqual([a,b,c,d,e], flatten([a,b,c,d,e])),
    ?assertEqual([], flatten([])),
    ok.
-endif.
