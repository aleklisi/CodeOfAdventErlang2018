-module(day1part2).
-export([solve/0]).

solve() -> solve("./inputFiles/day1part2.txt").

solve(FileName) -> 
    Numbers = get_input(FileName),
    search_freqs(Numbers, {sets:new(), 0}).

search_freqs(_Numbers, Result) when is_integer(Result) -> Result;
search_freqs(Numbers, {AlreadyApeared, CurrFreq}) -> 
    R = search_sing_loop(Numbers, CurrFreq, AlreadyApeared),
    search_freqs(Numbers, R).

search_sing_loop(Numbers, StartFreq, AlreadyApearedFreqs) -> 
    lists:foldr(
        fun(Elem, {AlreadyApeared, CurrFreq}) ->
                NewFreq = Elem + CurrFreq,
                case sets:is_element(NewFreq, AlreadyApeared) of
                    true -> NewFreq;
                    false -> {sets:add_element(NewFreq, AlreadyApeared), NewFreq}
                end;
            (_, Acc) when is_integer(Acc) -> Acc
        end, 
        {AlreadyApearedFreqs, StartFreq}, 
        Numbers
    ).

get_input(FileName) -> 
    {ok, Binary} = file:read_file(FileName),
    Lines = binary_to_list(Binary),
    SplitLines = string:split(Lines, "\n", all),
    lists:foldl(
        fun([], Acc) -> Acc;
            (Line, Acc) -> 
                {Number, _} = string:to_integer(Line),
                [Number | Acc]
        end, 
        [], 
        SplitLines
    ).
