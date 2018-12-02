-module(day2).
-export([solve/0]).

solve() -> solve("./inputFiles/day2.txt").

solve(FileName) -> 
    {ok, Device} = file:open(FileName, [read]),
    process_lines(Device, {0,0}).

process_lines(Device, {Twos, Threes}) -> 
    case io:get_line(Device, "") of
        eof  -> Twos * Threes;
        Line ->
            {Two, Three} = process_line(Line),
            process_lines(Device, {Twos + Two, Threes + Three})
    end.

process_line(Line) ->  
    Line0 = lists:droplast(Line),
    CountedChars = lists:foldr(
        fun(Elem, Acc) ->  
            NumOfLetters = maps:get(Elem, Acc, 0),
            maps:put(Elem, NumOfLetters + 1, Acc)
        end, 
        #{}, 
        Line0
    ),
    Values = maps:values(CountedChars),
    {is_in_values(Values, 2), is_in_values(Values, 3)}.

is_in_values(Values, SearchedValue) -> 
    IsInValues = lists:any(
        fun(Elem) -> Elem == SearchedValue end,
        Values
    ),
    case IsInValues of
        true -> 1;
        false -> 0
    end.
