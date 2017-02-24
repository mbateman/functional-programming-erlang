-module(assignment1).
-export[perimeter/1,area/1,enclose/1,bits/1,recursive_bits/1].

perimeter({square, Side}) ->
    io:format("perimeter for square is ~p~n", [4*Side]);
perimeter({rectangle, A, B}) ->
    io:format("perimeter for rectangle is ~p~n", [2*(A+B)]);
perimeter({circle, Radius}) ->
    io:format("perimeter for circle is ~p~n", [2*math:pi()*Radius]);
perimeter({triangle, A, B, C}) ->
    io:format("perimeter for triangle ~p~n", [A + B + C]);
perimeter(_) ->
    io:format("unrecognised shape ~n", []).

area({square, Side}) ->
    io:format("area for square is ~p~n", [Side*Side]);
area({rectangle, A, B}) ->
    io:format("area for rectangle is ~p~n", [A*B]);
area({circle, Radius}) ->
    io:format("area for circle is ~p~n", [math:pi()*(Radius*Radius)]);
area({triangle, A, B, C}) ->
    S = (A+B+C)/2,
    io:format("area for triangle ~p~n", [math:sqrt(S*(S-A)*(S-B)*(S-C))]);
area(_) ->
    io:format("unrecognised shape ~n", []).

triplemax(A,B,C) ->
    max(max(A,B),max(B,C)).

triangle_perimeter({triangle, A, B, C}) ->
    A + B + C.

triangle_area({triangle, A, B, C}) ->
    S = triangle_perimeter({triangle, A, B, C})/2,
    math:sqrt(S*(S - A)*(S - B)*(S - C)).

triangle_height({triangle, A, B, C}) ->
    2*triangle_area({triangle, A, B, C})/triplemax(A,B,C).

enclose({circle, R}) ->
    io:format("enclosing rectangle for circle is ~p~n", [{rectangle,2*R,2*R}]);
enclose({triangle, A, B, C}) ->
    io:format("enclosing rectangle for triangle is ~p~n", [{rectangle, triplemax(A,B,C), triangle_height({triangle,A,B,C})}]);
enclose(_) ->
    io:format("unrecognised shape ~n", []).

bits(N) when N < 10 ->
    <<B4:1,B3:1,B2:1,B1:1>> = <<N:4>>,
    B4 + B3 + B2 + B1;
bits(N) ->
    bits(N div 10) + bits(N rem 10).

recursive_bits(N) ->
    recursive_bits(N, 0).

recursive_bits(0, A) -> 
    A;
recursive_bits(N, A) ->
    recursive_bits(N div 10, A + bits(N rem 10)).

