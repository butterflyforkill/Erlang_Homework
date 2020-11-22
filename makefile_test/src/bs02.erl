
%% BS02: Разделить строку на слова:                

%% 1> BinText = <<"Text with four words">>.          
%% <<"Text with four words">>                        
%% 2> bs02:words(BinText).                           
%% [<<"Text">>, <<"with">>, <<"four">>, <<"words">>] 


-module(bs02).
-export([words/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.


%% Interface of the function%%
words(Bin) ->
    words(delspace(Bin),<<>>,[]).

%% First                  

words(<<>>,Acc, List) ->
    reverse([Acc|List]);

%% Second                     

words(<<$\s, Rest/binary>>, Acc, List) ->
    words(Rest, <<>> ,[Acc|List]);

%% Third                   

words(<<X, Rest/binary>>,Acc,List) ->
    words(Rest, <<Acc/binary, X>>,List).
    

%% Private functions %%

delspace(<<$\s, Rest/binary>>) ->
    delspace(Rest);
delspace(Rest) -> Rest.

reverse( List ) ->
	reverse( List, [] ).
reverse( [], List ) ->	
	List;
reverse( [H|T], List ) ->
    reverse(T, [H|List] ).
%% __________________%%

%%Test
-ifdef(TEST).
words_test() ->
    ?assertEqual([<<"Text">>, <<"with">>, <<"four">>, <<"words">>], words(<<"Text with four words">>)),
    ?assertEqual([<<>>], words(<<>>)),
    ?assertEqual([<<"Text_with_four_words">>], words(<<"Text_with_four_words">>)),
    ok.
%%     Test for words() function    %%
-endif.