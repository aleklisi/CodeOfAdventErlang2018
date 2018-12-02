-module(day2part2).
-export([solve/0]).

solve() -> solve("./inputFiles/day2part2.txt").

solve(FileName) -> 
    Lines = get_input(FileName),
    CompartedLines = [compare_two_lines(L1, L2) || L1 <- Lines, L2 <- Lines],
    [{W1,W2},{W2,W1}] = lists:filter(fun(X) -> is_tuple(X) end, CompartedLines),
    FilteredCharsTuples = lists:filter(
        fun({A,A}) -> true;
        (_) -> false end,
     lists:zip(W1, W2)),
     {Result, _} = lists:unzip(FilteredCharsTuples),
     Result.

get_input(FileName) -> 
    {ok, Binary} = file:read_file(FileName),
    Lines = binary_to_list(Binary),
    string:split(Lines, "\r\n", all).

compare_two_lines(Line1, Line2) ->
    LineLength = string:length(Line1),
    CompareLinesResult = 
        [
            string:slice(Line1, Pos, 1) == string:slice(Line2, Pos, 1) || Pos <- lists:seq(0, LineLength-1)
        ],
    CountedDiffs = lists:foldl(
        fun(false, Acc) -> Acc + 1;
            (true, Acc) -> Acc
        end,
        0, 
        CompareLinesResult),
    case CountedDiffs of
        X when X == 1 -> {Line1, Line2};
        _ -> no_match
    end.
