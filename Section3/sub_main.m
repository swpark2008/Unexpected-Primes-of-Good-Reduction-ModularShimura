load "reduction.m";
load "ribet_isog.m";
load "quot_genus.m";

print("Test");
print(gain_prime_specific([-1,-1],1,6,2));
print(gain_prime_specific([-1,-1],1,6,3));

print("Gain Primes of Good Reduction: Look only the entries where the number of -1 in the sign pattern is even and the number of such primes is positive but strictly less than the number of prime factors of w(n*d).");
for k in [1..#lib_S2] do
    epsilon := lib_S2[k][1];
    if negative_even(epsilon) then
        print("Sign_Pattern");
        print(epsilon);
        print("[N, N^+ (or n), N^- (or D), List of Gained Primes]");
    end if;
    for n in lib_S2[k][2] do
        n_gain := gain_prime(epsilon,n);
        if negative_even(epsilon) then
            if #n_gain gt 0 and #n_gain lt #factor_list(n) then
                new_list := find_n_d(epsilon,n);
                print([[n], new_list, gain_prime(epsilon,n)]);
            end if;
        end if;
    end for;
end for;

// Compute genera of such Atkin Lehner quotients using IsogClassALQuotient function from Freddie and Oana's code.
print("Compute Genus of Shimura Curves");
for k in [1..#lib_res] do
    epsilon := lib_res[k][1];
    print("Sign_Pattern");
    print(epsilon);
    print("[N, N^+ (or n), N^- (or D), Dimension of original, Dimension of Full Quotient]");
    for n in lib_res[k][2] do
        new_list := find_n_d(epsilon,n);
        N := new_list[1];
        D := new_list[2];
        div_ND := Divisors(N*D);
        print([N*D, N, D, quot_genus(D,N,[1]), quot_genus(D,N,div_ND)]);
    end for;
end for;
