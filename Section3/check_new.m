/*
  Checks the tables of intermediate quotients X_0(D;N)/H with gained primes
  of good reduction (D = 1 for modular curves) directly from newforms.

  Jac(X_0(D;N)/H) is isogenous to a product of factors A_f, f a newform of
  level M = D*A with A | N, and A_f is retained iff the Atkin--Lehner
  character of f (with the Jacquet--Langlands sign flip at primes dividing D)
  is trivial on H meet W_M.  So p is a prime of good reduction iff for every
  such M with p | M, the subspace of S_2^new(M) fixed by
  (-1)^{omega(gcd(d,D))} w_d for all d in H meet W_M is zero.
*/

CheckNew := procedure(table)
  newspaces := AssociativeArray();
  failures := 0;
  for row in table do
    D, N, H, pJ := Explode(row);

    K := {SquarefreeFactorization(&*[Integers() | g : g in S]) : S in Subsets(Set(H))};

    for p in pJ do
      for A in Divisors(N) do
        M := D*A;
        if M mod p ne 0 then continue; end if;
        if not IsDefined(newspaces, M) then
          newspaces[M] := NewSubspace(CuspidalSubspace(ModularSymbols(M, 2, 1)));
        end if;
        S := newspaces[M];
        V := RSpace(Rationals(), Dimension(S));
        for d in K do
          if d ne 1 and M mod d eq 0 and Dimension(V) gt 0 then
            eps := (-1)^#PrimeDivisors(GCD(D, d));
            V meet:= Kernel(eps*AtkinLehnerOperator(S, d) - 1);
          end if;
        end for;
        if Dimension(V) gt 0 then
          failures +:= 1;
          printf "FAIL: D=%o N=%o H=%o p=%o: " cat
               "retained newspace of level %o has dimension %o\n",
               D, N, H, p, M, Dimension(V);
        end if;
      end for;
    end for;
  end for;
  printf "%o rows checked, %o failures\n", #table, failures;
end procedure;

load "modular_table.m";
load "shimura_table.m";
CheckNew(modular);
CheckNew(shimura);
