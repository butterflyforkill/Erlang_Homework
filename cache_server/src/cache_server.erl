%1. Написать кеширующий сервер.
%1.1. Стартуем сервер с опциями
%{ok, Pid} = cache_server:start_link(TableName, [{drop_interval, 3600}]).
%1.2. Создаем таблицу
%ok = cache_server:new(TableName).
%1.3. Добавляем запись
%ok = cache_server:insert(TableName, Key, Value, 600). %% Ключ, Значение, Время
%жизни записи
%1.4. Достаем запись
%{ok, Value} = cache_server:lookup(TableName, Key).
%1.5. Достаем записи добавленые в определенный интервал времени
%DateFrom = {{2015,1,1},{00,00,00}}.
%DateTo = {{2015,1,10},{23,59,59}}.
%{ok, Values} = cache_server:lookup_by_date(TableName, DateFrom, DateTo).
%Сервер должен хранить данные то количество времени которе было указано при записи.
%Интервал очистки устаревших данных указывается при старте (drop_interval). Время
%задается в секундах.

-module(cache_server).
-behaviour(gen_server).
-include_lib("stdlib/include/ms_transform.hrl").
-record(mycache,{key, value, lt=calendar:local_time()}).
-export([start_link/1, insert/2, lookup/1, lookup_by_date/2]).
-export([init/1, handle_call/3, handle_cast/2]).
-export([handle_info/2, terminate/2, code_change/3]).


%%              api         %%

start_link(Options) ->
	gen_server:start_link({global, ?MODULE}, ?MODULE, [], Options).

insert(Key, Value)->
	gen_server:call({global, ?MODULE}, {insert, Key, Value}).

lookup(Key)->
	gen_server:call({global, ?MODULE}, {lookup, Key}).

lookup_by_date(DateFrom, DateTo)->
	gen_server:call({global, ?MODULE}, {lookup_by_date, DateFrom, DateTo}).

%%              gen server          &&

init([]) ->
	State = ets:new(mycache, [public, named_table, {keypos, #mycache.key}]),
	{ok, State}.

handle_call({insert, Key, Value}, _From, State) ->
	Data = #mycache{key=Key, value=Value},
	case ets:info(mycache) of
		undefined -> {reply, error, State};
		_else ->
			NewState = ets:insert(mycache, Data),		
			{reply, ok, NewState}
	end;

handle_call({lookup, Key}, _From, State) ->
	
	case ets:lookup(mycache, Key) of
		[]->{reply, error, State};
		[{_, _, R, {{_, _, _},{_, _, _}}}] -> R,
		Response = {ok, R},
		{reply, Response, State}

end;
	

handle_call({lookup_by_date, DateFrom, DateTo}, _From, State) ->
	case ets:select(mycache, ets:fun2ms(fun(N=#mycache{lt=C})
		       when C >= DateFrom, C =< DateTo->
		                N
		   end))of
	[]->{reply, error, State};
	[{_, _, Value, {{_, _, _},{_, _, _}}}] ->Value,
	{reply, {ok, Value}, State}
end;



handle_call(_Message, _From, State) ->
	{reply, invalid_command, State}.	

handle_cast(_Message, State) -> {noreply, State}.

handle_info({expire, Key}, State) ->
	ets:delete(mycache, Key),	
	{noreply, State};

handle_info(_Message, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVersion, State, _Extra) -> {ok, State}.