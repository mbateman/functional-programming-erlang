-module(mariusz). 
-export([sum_bit/1, sum_bit_simple/1, perimeter/1]).

% 
% Shapes 
% 
perimeter({circle, R}) -> 
    2 * math:pi() * R; 
perimeter({rectangle, A, B}) -> 
    (2 * A) + (2 * B); 
perimeter({triangle, A, B, C}) -> 
    A + B + C.

% 
% Summing the bits 
% 
sum_bit_simple(INT) when is_integer(INT) and INT > 0 -> % Sum of bits using list comprehensions and list:sum 
    lists:sum([X-48 || X <- integer_to_list(INT, 2)]); 
sum_bit_simple(_) -> 
    io:format("Invalid argument~n").

sum_bit(X) when is_integer(X) and X > 0 -> % Sum of bits usig tail recursion 
    sum_bit(integer_to_list(X, 2), 0); 
sum_bit(_) -> 
    io:format("Invalid argument~n").

sum_bit([], ACC) -> 
    ACC; 
sum_bit(X, ACC) -> 
    [H|T] = X, 
    {INT, _} = string:to_integer([H]), 
    sum_bit(T, ACC+INT).

