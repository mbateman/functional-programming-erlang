%%% Counting set bits of a binary representation of numbers.
%%%
%%% This is known as "Hamming Weight"
%%% (see https://en.wikipedia.org/wiki/Hamming_weight).
%%%
%%% I will use an efficient algorithm known as "SWAR algorithm"
%%% (see http://www.playingwithpointers.com/swar.html,
%%% https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel).
%%%
%%% Since Erlang numbers are of arbitrary precision,
%%% I will split them in 32 bit chunks and count set bits of each chunk
%%% and sum the results.
-module(bits).
-export([bits/1,bits_dr_swar/1,bits_tr_swar/1,bits_dr_simple/1,bits_tr_simple/1]).

%% Function `bits` required to complete the assignment,
%% set up to be most efficient of all implementations (see below).
%% You may set it to be a call to another implementation if you like.
%% All implementations are exported as well.
bits(N) ->
    bits_tr_swar(N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Efficient implementations using SWAR algorithm %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Direct recursive
bits_dr_swar(0) ->
    0;
bits_dr_swar(N) ->
    {First32Bits, WhatIsLeft} = split(N),
    swar32(First32Bits) + bits_dr_swar(WhatIsLeft).

%% Tail recursive
bits_tr_swar(N) ->
    bits_tr_swar(N, 0).
bits_tr_swar(0, Acc) ->
    Acc;
bits_tr_swar(N, Acc) ->
    {First32Bits, WhatIsLeft} = split(N),
    NewAcc = Acc + swar32(First32Bits),
    bits_tr_swar(WhatIsLeft, NewAcc).

%% One iteration of SWAR (see URLs in module intro),
%% N must be 32 bit number
swar32(N) when N >= 0, N =< 16#FFFFFFFF ->
    Step1 = N - ((N bsr 1) band 16#55555555),
    Step2 = (Step1 band 16#33333333) + ((Step1 bsr 2) band 16#33333333),
    Step3 = (Step2 + (Step2 bsr 4)) band 16#0F0F0F0F,
    Step4 = Step3 + (Step3 bsr 8),
    Step5 = Step4 + (Step4 bsr 16),
    Step5 band 16#0000003F.

%% Split number into its first 32 bits and what is left
split(N) ->
    First32Bits = N band 16#FFFFFFFF,
    WhatIsLeft = N bsr 32,
    {First32Bits, WhatIsLeft}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simple (and inefficient) implementations %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Direct recursive
bits_dr_simple(0) ->
    0;
bits_dr_simple(N) ->
    (N band 1) + bits_dr_simple(N bsr 1).

%% Tail recursive
bits_tr_simple(N) ->
    bits_tr_simple(N, 0).
bits_tr_simple(0, Acc) ->
    Acc;
bits_tr_simple(N, Acc) ->
    bits_tr_simple(N bsr 1, Acc + (N band 1)).
