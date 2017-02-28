%%% Calculating the properties of shapes.
%%%
%%% I will consider only rectangles, circles
%%% and triangles for the sake of simplicity.
%%% (Triangles are explicitly required by the assignment.)
%%%
%%% I use the following representations for shapes already mentioned in lectures
%%% (for the sake of compatibility):
%%% - {rectangle, Center, Width, Height} where Center is a point;
%%% - {circle, Center, Radius} where Center is a point;
%%% where point is a tuple of two coordinates - {X, Y}.
%%%
%%% In the real world rectangles may also be rotated,
%%% but let's not complicate things too much. :)
%%%
%%% For triangle I use the following representation:
%%% - {triangle, A, B, C} - where A, B, C are points ({X, Y}).
-module(shapes).
-export([perimeter/1,area/1,enclose/1]).

perimeter({rectangle, _, Width, Height}) ->
    2 * (Width + Height);
perimeter({circle, _, Radius}) ->
    2 * math:pi() * Radius;
perimeter(Triangle = {triangle, _, _, _}) ->
    {AB, BC, AC} = triangle_side_lengths(Triangle),
    AB + BC + AC.

area({rectangle, _, Width, Height}) ->
    Width * Height;
area({circle, _, Radius}) ->
    math:pi() * Radius * Radius;
area(Triangle = {triangle, _, _, _}) ->
    {AB, BC, AC} = triangle_side_lengths(Triangle),
    S = (AB + BC + AC) / 2,
    math:sqrt(S * (S - AB) * (S - BC) * (S - AC)).  % Heron's formula

enclose(Rectangle = {rectangle, _, _, _}) ->
    Rectangle;
enclose({circle, Center, Radius}) ->
    {rectangle, Center, 2 * Radius, 2 * Radius};
enclose({triangle, {X1, Y1}, {X2, Y2}, {X3, Y3}}) ->
    XS = [X1, X2, X3],
    YS = [Y1, Y2, Y3],
    XMin = lists:min(XS),
    XMax = lists:max(XS),
    YMin = lists:min(YS),
    YMax = lists:max(YS),
    {rectangle, {(XMin + XMax) / 2, (YMin + YMax) / 2}, XMax - XMin, YMax - YMin}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Motivation for the last case of enclose: %
%                                          %
%  +---------------------* <-- YMax        %
%  |                 ****|                 %
%  |            ***** ** |                 %
%  |       *****    **   |                 %
%  |  *****       **     |                 %
%  ***        C **       | C = Center      %
%  |*         **         |                 %
%  | *      **           |                 %
%  |  *   **             |                 %
%  |   ***               |                 %
%  +----*----------------+ <-- YMin        %
%  ^                     ^                 %
%  |                     |                 %
%  XMin               XMax                 %
%                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Auxiliary functions

triangle_side_lengths({triangle, A, B, C}) ->
    {distance(A, B), distance(B, C), distance(A, C)}.

distance({X1, Y1}, {X2, Y2}) ->
    DX = X2 - X1,
    DY = Y2 - Y1,
    math:sqrt(DX * DX + DY * DY).
