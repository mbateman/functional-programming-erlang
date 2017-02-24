-module(recursion).
-export [fac/1,tailfac/1,fib/1,tailfib/1,pieces/1,divisors/1,perfect/1].

fac(0) ->
    1;
fac(N) when N > 0 ->
    fac(N-1) * N.

tailfac(N) ->
    fac(N,1).

fac(0,P) ->
    P;
fac(N,P) when N > 0 ->
    fac(N-1, P*N).


fib(0) ->
    0;
fib(1) ->
    1;
fib(N) ->
    fib(N-1) + fib(N-2).

tailfib(N) ->
    fib(1,0,N).
fib(_A,B,0) ->
    B;
fib(A,B,N) ->
    fib(A+B, A, N-1).

pieces(0) ->
    1;
pieces(N) when N > 0 ->
    N + pieces(N-1).

divisors(N) ->
    divisors(N, N-1, []).

divisors(_N, 0, L) ->
    L;
divisors(N,V,L) ->
    if 
        N rem V == 0 ->
            divisors(N, V-1, L++[V]);
        true ->
            divisors(N, V-1, L)
    end.

perfect(N) ->
    perfect(N,1,0).

perfect(N,N,S) ->
    N==S;
perfect(N,M,S) when N rem M == 0 ->
    perfect(N,M+1,S+M);
perfect(N,M,S) ->
    perfect(N,M+1,S).


