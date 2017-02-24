-module(second).
-export[area/2,maxThree/3,howManyEqual/3,fib/1,tailfib/1,pieces/1,perfect/1,divisors/1].

area(A,B) ->
    C = math:sqrt(A*A + B*B),
    S = (A+B+C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C)).

maxThree(X,Y,Z) ->
    max(max(X,Y), max(Y,Z)).

howManyEqual(X,X,X) ->
    3;
howManyEqual(X,X,_) ->
    2;
howManyEqual(_,X,X) ->
    2;
howManyEqual(X,_,X) ->
    2;
howManyEqual(_X,_,_) ->
    0.

fib(0) ->
    0;
fib(1) ->
    1;
fib(N) ->
    fib(N-1) + fib(N-2).

tailfib(N) ->    
    fib(0,1,N).
fib(A,_B,0)  ->
    A; 
fib(A,B,N) when N > 0 ->
    fib(B,A+B,N-1).

pieces(0) ->
    1;
pieces(N) ->
    N + pieces(N-1).

perfect(N) ->
    perfect(N,1,0).

perfect(N,N,S) ->
    N==S;
perfect(N,D,S) when N rem D == 0 ->
    perfect(N,D+1,S+D);
perfect(N,D,S) ->
    perfect(N,D+1,S).

divisors(N) ->
    divisors(N,1,[]).

divisors(_N,_N,L) ->
    L;
divisors(N,D,L) when N rem D == 0 ->
    divisors(N,D+1, L++[D]);
divisors(N,D,L) -> 
    divisors(N,D+1,L).
