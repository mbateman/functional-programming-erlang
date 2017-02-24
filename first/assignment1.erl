-module(assignment1).
-export[perimeter/1,area/1,enclose/1,bits/1,recursive_bits/1,test_perimeter/0,test_area/0,test_enclose/0,test_bits/0].

perimeter({square, Side}) ->
    4*Side;
perimeter({rectangle, A, B}) ->
    2*(A+B);
perimeter({circle, Radius}) ->
    2*math:pi()*Radius;
perimeter({triangle, A, B, C}) ->
    A + B + C;
perimeter(_) ->
     0.

test_perimeter() ->
    40 = perimeter({square, 10}),
    50 = perimeter({rectangle, 10, 15}),
    62.83185307179586 = perimeter({circle, 10}),
    85 = perimeter({triangle, 15, 30, 40}),
    success.

area({square, Side}) ->
    Side*Side;
area({rectangle, A, B}) ->
    A*B;
area({circle, Radius}) ->
    math:pi()*(Radius*Radius);
area({triangle, A, B, C}) ->
    S = (A+B+C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C));
area(_) ->
    0.

test_area() ->
    100 = area({square, 10}),
    150 = area({rectangle, 10, 15}),
    314.1592653589793 = area({circle, 10}),
    191.1110606427582 = area({triangle, 15, 30, 40}),
    success.

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
    {rectangle,2*R,2*R};
enclose({triangle, A, B, C}) ->
    {rectangle, triplemax(A,B,C), triangle_height({triangle,A,B,C})};
enclose(_) ->
    0.

test_enclose() ->
    {rectangle,20,20} = enclose({circle, 10}),
    {rectangle,40,9.55555303213791} = enclose({triangle, 15, 30, 40}),
    success.

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

test_bits() ->
    3 = bits(7),
    1 = bits(8),
    3 = recursive_bits(7),
    1 = recursive_bits(8),
    success.
