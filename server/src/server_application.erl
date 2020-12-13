-module(server_application).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/api/server", api, []}]}
    ]),
    {ok, _} = cowboy:start_http(http, 100, [{port, 8080}],
        [{env, [{dispatch, Dispatch}]}]
    ),
	server_supervisor:start_link().

stop(_State) ->
	ok.