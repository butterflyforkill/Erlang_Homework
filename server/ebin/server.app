{application, server, [
	{description, ""},
	{vsn, "0.1.0"},
	{id, "228ca58"},
	{modules, ['api','data','server_application','server_supervisor']},
	{registered, [server_supervisor]},
	{applications, [
		kernel,
		stdlib,
		cowboy,
		jsx
	]},
	{mod, {server_application, []}},
	{env, []}
]}.