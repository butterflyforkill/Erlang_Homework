%%BS03: Разделить строку на части, с явным указанием разделителя:

%%1> BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
%%<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>
%%2> bs03:split(BinText, “-:-”).
%%[<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]

-module (bs03).
-export ([split/2]).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.


%% Interface of the function 
split(Bin,Separator) ->
    split(delspace(Bin),list_to_binary(Separator),<<>>,[]).

%% First                        

split(<<>>,_,Acc,List) ->
    List++[<<Acc/binary>>];

%%Second
split(Bin,Separator,Acc,List) ->
    DelSize = (byte_size(Separator)),
    case Bin of

	<<Separator:DelSize/binary, Rest/binary>> ->
	    split(Rest,Separator,<<>>,List++[<<Acc/binary>>]);

	<<X, Rest/binary>> ->
	    split(Rest,Separator,<<Acc/binary, X>>,List);	

	_ ->
	    split(Bin,Separator,Acc,List)
	end.


%% Private function.                

delspace(<<$\s, Rest/binary>>) ->
    delspace(Rest);
delspace(Rest) -> Rest.

%%Test

-ifdef(TEST).
split_test() ->
    ?assertEqual([<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>] ,split(<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>, "-:-")),
    ?assertEqual([<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>] ,split(<<"Col1-Col2-Col3-Col4-Col5">>, "-")),
    ?assertEqual([<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>] ,split(<<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>, "-:-")),
    ?assertEqual([<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>] ,split(<<"Col1Test TestCol2Test TestCol3Test TestCol4Test TestCol5">>, "Test Test")),
    ?assertEqual([<<>>] ,split(<<>>, "-:-")),
	ok.
-endif.