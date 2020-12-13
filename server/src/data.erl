-module(data).

-include_lib("stdlib/include/ms_transform.hrl").

-record(cache,{key, value, dt=calendar:local_time()}).

-export([insert/2, lookup/1, lookup_by_date/2]).

%insert%
insert(Key, Value)->
	State = ets:new(mycache, [public, named_table, {keypos, #cache.key}]),
	
	Data = #cache{key=Key, value=Value},
	case ets:info(mycache) of
		undefined -> {error, State};
		_else ->
			NewState = ets:insert(mycache, Data),		
			{ok, NewState}
	end.
%look up%
lookup(Key)->
	case ets:lookup(mycache, Key) of
		[]->{error, Key};
		[{_, _, R, {{_, _, _},{_, _, _}}}] -> R,
		{ok, R}
		

end.	

%look up by date
lookup_by_date(DateFrom, DateTo)->
	case ets:select(mycache, ets:fun2ms(fun(N=#cache{dt=C})
		       when C >= DateFrom, C =< DateTo->
		                N
		   end))of
	[]->{error, "No Data"};
	[{_, _, Value, {{_, _, _},{_, _, _}}}] ->Value,
	{ok, Value}
end.