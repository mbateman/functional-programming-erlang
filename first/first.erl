-module(first).
-export [double/1,multi/2, area/3, square/1, treble/1].

multi(X,Y) ->
    X*Y.

double(X) ->
    multi(X,2).

area(A,B,C) ->
    S = (A+B+C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C)).

square(X) ->
    X*X.

treble(X) ->
    X*X*X.
