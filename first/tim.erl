-module(tim). 
-export([perimeter/1, area/1, enclose/1, bitsDirect/1, bitsTail/1]). 

% Shapes 
% 
% Define a function perimeter/1 which takes a shape and returns the 
% perimeter of the shape. 
% 
% Choose a suitable representation of triangles, and augment area/1 
% and perimeter/1 to handle this case too. 
% 
% Define a function enclose/1 that takes a shape an returns the 
% smallest enclosing rectangle of the shape.

perimeter({triangle, A, B, C}) -> 
distance(A, B) + distance(B, C) + distance(C, A).

distance({X0,Y0}, {X1,Y1}) -> 
math:sqrt(math:pow(X1-X0, 2) + math:pow(Y1-Y0, 2)).

area({triangle, {X1,Y1}, {X2,Y2}, {X3,Y3}}) -> 
abs(((X1*(Y2-Y3)) + (X2*(Y3-Y1)) + (X3*(Y1-Y2)))/2).

enclose({triangle, {X1,Y1}, {X2,Y2}, {X3,Y3}}) -> 
LowerLeft = {minThree(X1,X2,X3), minThree(Y1,Y2,Y3)}, 
UpperRight = {maxThree(X1,X2,X3), maxThree(Y1,Y2,Y3)}, 
{rectangle, LowerLeft, UpperRight}. 

minThree(X,Y,Z) -> 
min(X, min(Y,Z)).

maxThree(X,Y,Z) -> 
max(X, max(Y,Z)).

% I don't understand; is there a paragraph missing from the 
% assignment? It says augment area/1 to handle this case too, but we 
% don't have an area/1. 
% 
% 1> c(assignment). 
% {ok,assignment} 
% 2> T = {triangle, {55, 25}, {10, 35}, {45, 5}}. 
% {triangle,{55,25},{10,35},{45,5}} 
% 3> assignment:perimeter(T). 
% 114.55612434792678 
% 4> assignment:area(T). 
% 500.0 
% 5> assignment:enclose(T). 
% {rectangle,{10,5},{55,35}}

% Summing the bits 
% 
% Define a function bits/1 that takes a positive integer N and returns 
% the sum of the bits in the binary representation. For example 
% bits(7) is 3 and bits(8) is 1. 
% 
% See whether you can make both a direct recursive and a tail 
% recursive definition.

bitsDirect(0) -> 
    0; 
bitsDirect(1) -> 
    1; 
bitsDirect(N) -> 
    (N rem 2) + bitsDirect(N div 2). 

bitsTail(N) -> 
bitsTail(N, 0). 

bitsTail(0, Acc) -> 
    Acc; 
bitsTail(1, Acc) -> 
    Acc + 1; 
bitsTail(N, Acc) -> 
bitsTail(N div 2, Acc + (N rem 2)).

% Which do you think is better? Why? 
% 
% I like the direct version better, I think. Having a separate 
% bitsTail/1 and bitsTail/2 clutters things up.

% 1> c(assignment). 
% {ok,assignment} 
% 2> bitsDirect(7). 
% ** exception error: undefined shell command bitsDirect/1 
% 3> assignment:bitsDirect(7). 
% 3 
% 4> assignment:bitsDirect(8). 
% 1 
% 5> assignment:bitsTail(7). 
% 3 
% 6> assignment:bitsTail(8). 
% 1 
% 7>
