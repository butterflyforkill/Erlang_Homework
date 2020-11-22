%%1> BinText = <<"Some text">>.
%%<<"Some Text">>
%%2> bs01:first_word(BinText).
%%<<”Some”>>


-module(bs01).
-export([first_word/1]).
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.

first_word(B)->
    first_word(B,<<>>).

first_word(<<" ",_Rest/binary>>,Acc)->
        Acc;
first_word(<<X/utf8, Rest/binary>>,Acc)->
    first_word(Rest,<<Acc/binary,X/utf8>>);

first_word(<<>>, Acc)->Acc.

%test
-ifdef(TEST).
first_word_test() ->
    ?assertEqual(<<"Some">>, first_word(<<"Some text">>)),
    ?assertEqual(<<"Some">>, first_word(<<"  Some text">>)),
    ?assertEqual(<<"Some_text">>, first_word(<<" Some_text">>)),
    ?assertEqual(<<"Other_test_without_spaces">>, first_word(<<"Other_test_without_spaces">>)),
    ?assertEqual(<<>>, first_word(<<>>)),
    ok.
-endif.

