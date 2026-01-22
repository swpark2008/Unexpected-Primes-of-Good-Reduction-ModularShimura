// Library of sign patterns and levels such that dim S_2^epsilon(N) = 0.
lib_S2 := [[[1],[2,3,5,7,11,13,17,19,23,29,31,41,47,59,71]],[[-1],[2,3,5,7,13]],[[1,1],[6, 10, 14, 22, 26, 34, 38, 46, 62, 74, 86, 94, 134, 146, 194, 206, 15, 21, 33, 39, 51, 69, 87, 111, 159, 35, 55, 95]],[[1,-1],[6, 10, 22, 34, 58, 82, 21, 57, 93]],[[-1,1],[6, 10, 14, 22, 46, 15, 33]],[[-1,-1],[6, 10, 14, 22, 26, 34, 38, 46, 58, 62, 74, 82, 86, 94, 106, 118, 122, 134, 146, 166, 178, 194, 202, 206, 314, 15, 21, 33, 39, 51, 57, 69, 87, 93, 111, 129, 159, 183, 237, 35, 55, 65, 85, 95, 115, 215, 77, 119, 161, 143]],[[1,1,1],[30, 42, 66, 78, 114, 174, 186, 222, 366, 654, 70, 110, 130, 170, 230, 530, 182, 266, 105, 195, 255, 231]],[[1,1,-1],[30, 42, 66, 102, 138, 282, 498, 70, 130, 190, 310, 322, 418, 165, 273]],[[1,-1,1],[42, 78, 114, 258, 70, 130, 154, 105, 165]],[[1,-1,-1],[30, 42, 66, 78, 102, 114, 138, 174, 186, 222, 246, 282, 318, 354, 426, 534, 70, 110, 190, 230, 290, 310, 154, 182, 238, 266, 434, 518, 602, 286, 374, 494, 105, 165, 195, 255, 285, 435, 615, 231, 455]],[[-1,1,1],[30, 78, 102, 190, 105]],[[-1,1,-1],[30, 42, 66, 78, 102, 114, 138, 174, 186, 222, 246, 258, 402, 426, 474, 70, 110, 130, 170, 230, 290, 370, 154, 182, 238, 266, 434, 374, 494, 105, 165, 195, 255, 231, 273, 399]],[[-1,-1,1],[30, 42, 66, 78, 102, 114, 138, 174, 186, 222, 246, 258, 282, 318, 354, 366, 402, 426, 438, 474, 498, 534, 582, 642, 654, 678, 822, 70, 110, 130, 170, 190, 230, 290, 310, 370, 410, 530, 610, 154, 182, 266, 322, 406, 518, 602, 286, 374, 418, 442, 105, 165, 195, 255, 285, 435, 615, 231, 273, 399, 455]],[[-1,-1,-1],[30, 42, 78, 70]],[[1,1,1,1],[330, 510, 870, 1230, 546, 770]],[[1,1,1,-1],[210, 390, 1110, 1290, 858]],[[1,1,-1,1],[210, 330, 570, 462]],[[1,1,-1,-1],[210, 390, 510, 690, 1590, 546, 798, 770]],[[1,-1,1,1],[210, 330, 510, 690, 870, 1122]],[[1,-1,1,-1],[210, 330, 390, 510, 570, 930, 462, 714, 910]],[[1,-1,-1,1],[210, 330, 390, 510, 690, 1110, 462, 546, 714, 966, 1218, 858, 1326, 1190]],[[1,-1,-1,-1],[330]],[[-1,1,1,1],[210, 462, 798, 910]],[[-1,1,1,-1],[210, 330, 390, 570, 1770, 462, 546, 966, 770]],[[-1,1,-1,1],[210, 330, 390, 510, 570, 690, 930, 1410, 546, 714, 798, 1302, 1190]],[[-1,1,-1,-1],[462]],[[-1,-1,1,1],[210, 330, 390, 510, 570, 690, 870, 930, 1410, 462, 546, 714, 966, 1218, 858, 770]],[[-1,-1,1,-1],[330]],[[-1,-1,-1,-1],[210, 330, 390, 510, 570, 690, 870, 930, 1110, 1230, 1290, 1410, 1590, 1770, 2010, 2130, 462, 546, 714, 798, 966, 1218, 1302, 1722, 1974, 858, 1122, 1254, 1914, 1326, 1794, 1938, 770, 910, 1190]],[[1,1,-1,1,-1],[2310]],[[1,-1,1,1,-1],[2730]],[[1,-1,-1,-1,-1],[2310, 2730, 3990]],[[-1,1,1,1,-1],[3570]],[[-1,1,1,-1,1],[2310]],[[-1,1,-1,-1,-1],[2310, 4290]],[[-1,-1,1,-1,-1],[2310, 2730]],[[-1,-1,-1,1,-1],[2310, 2730, 3570, 3990]],[[-1,-1,-1,-1,1],[2310, 2730, 3570, 3990, 4290]]];
lib_res := [[[1,1],[74,86,134,146,194,206,111,159]],[[1,1,1],[114,174,186,222,130,170,230,182,266,195,255,231]],[[1,-1,-1],[246,282,354,426,534,290,310,182,266,434,518,602,374,494,435,615,455]],[[-1,1,-1],[426,474]],[[1,1,1,1],[330,546]],[[1,1,-1,-1],[390,510,690,546,798,770]],[[1,-1,1,-1],[570,930,714]],[[1,-1,-1,1],[690,1110,714,966,1218,858,1326,1190]],[[-1,1,1,-1],[570,966]],[[-1,1,-1,1],[1410,714,1302,1190]],[[1,-1,-1,-1,-1],[2310,2730,3990]],[[-1,1,-1,-1,-1],[4290]]];

// Prime factorization
factor_list := function(n)
    n_factor_list := PrimeDivisors(n);
    return n_factor_list;
end function;

// Check whether dim S_2^epsilon(N) = 0.
check_dim := function(epsilon,n)
    index := 0;
    for m in lib_S2 do
        if m[1] eq epsilon and n in m[2] then
            index := 1;
            break;
        end if;
    end for;
    if index eq 0 then
        return false;
    else
        return true;
    end if;
end function;

// Compute the restriction of the sign pattern from level n to level n' (written as nprime).
reduction_sign := function(epsilon,n,nprime)
    index_list := [];
    sign_pattern_restriction := [];
    n_fact := factor_list(n);
    nprime_fact := factor_list(nprime);
    for m in n_fact do
        if m in nprime_fact then
            index_list := Append(index_list, true);
        else
            index_list := Append(index_list, false);
        end if;
    end for;
    for i in [1..#index_list] do
        if index_list[i] then
            sign_pattern_restriction := Append(sign_pattern_restriction,epsilon[i]);
        end if;
    end for;
    return sign_pattern_restriction;
end function;

// Check whether the given prime number is a gained prime of good reduction with respect to Atkin-Lehner quotient of X0^d(n). Hence, the level is in fact n*d instead of n or d.
// John Voight's algorithm: Let p, d satisfy the condition that p | n' and d | n' | n. For such n', compute S_2^{epsilon'}(n') = 0, where epsilon' is the restriction of epsilon to n'.
gain_prime_specific := function(epsilon,n,d,prime)
    n_divisor_list := Divisors(n);
    indicator := 0;
    for nprime in Divisors(n*d) do
        // Here nprime is n' originating from John Voight's algorithm.
        if IsDivisibleBy(nprime,prime) then
            if IsDivisibleBy(nprime,d) then
                if check_dim(reduction_sign(epsilon,n*d,nprime), nprime) eq false then
                    indicator := indicator + 1;
                end if;
            end if;
        end if;
    end for;
    if indicator eq 0 then
        return true;
    else
        return false;
    end if;
end function;

//Given a level N and a sign pattern epsilon, find suitable levels n and d for the associated Shimura curve.
find_n_d := function(epsilon,n)
    new_n := 1;
    new_d := 1;
    n_fact := factor_list(n);
    for i in [1..#n_fact] do
        if epsilon[i] eq 1 then
            new_n := new_n * n_fact[i];
        else
            new_d := new_d * n_fact[i];
        end if;
    end for;
    return [new_n,new_d];
end function;

//Find a list of primes that are gained primes of good reduction with respect to Atkin-Lehner quotient of X0^d(n).
gain_prime := function(epsilon,n)
    new_n := find_n_d(epsilon,n)[1];
    d := find_n_d(epsilon,n)[2];
    n_fact := factor_list(n);
    gain_prime_list := [];
    for p in n_fact do
        if gain_prime_specific(epsilon,new_n,d,p) then
            gain_prime_list := Append(gain_prime_list,p);
        end if;
    end for;
    return gain_prime_list;
end function;

//Check whether a given sign pattern has even number of -1.
negative_even := function(epsilon)
    index := 0;
    for m in epsilon do
        if m eq -1 then
            index := index + 1;
        end if;
    end for;
    if index mod 2 eq 0 then
        return true;
    else
        return false;
    end if;
end function;
