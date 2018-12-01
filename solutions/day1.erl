-module(day1).
-export([solve/0]).

solve() -> solve("./inputFiles/day1.txt").

solve(FileName) -> 
    {ok, Device} = file:open(FileName, [read]),
    process_lines(Device, 0).

process_lines(Device, Acc) -> 
    case io:get_line(Device, "") of
        eof  -> Acc;
        Line ->
            process_lines(Device, Acc + pase_line(Line))
    end.

pase_line(Line) ->  
    StringNumber = lists:droplast(Line),
    {Number, _} = string:to_integer(StringNumber),
    Number.
