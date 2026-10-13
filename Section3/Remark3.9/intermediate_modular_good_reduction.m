/*
  intermediate_atkin_lehner_good_reduction.m

  Intermediate Atkin--Lehner quotients of squarefree modular curves with
  unexpected primes of good reduction.

  For squarefree N and H <= W_N, this enumerates quotients X_0(N)/H and
  reports primes p | N at which the quotient Jacobian has good reduction.
  For positive-genus quotients it also reports the primes at which the curve
  itself has good reduction.

  Mathematical input:

    O. Padurariu, S. W. Park, J. Voight,
    "Unexpected primes of good reduction in quotients of modular and
    Shimura curves", arXiv:2607.11248.

    Published computation and Magma data:
    https://github.com/swpark2008/Unexpected-Primes-of-Good-Reduction-ModularShimura

  In particular, this uses the complete list of lacking pairs in Tables 2--5.
  The convention for a sign vector is the increasing ordering of the prime
  divisors of its level.

  Run with:

      magma intermediate_atkin_lehner_good_reduction.m

  Output:

      intermediate_atkin_lehner_good_reduction.tsv

  A row with generators [d_1,...,d_s] denotes

      X_0(N) / <w_{d_1},...,w_{d_s}>.

  The script is standalone: it does not require the Section 2 class-number
  files from the accompanying PPV repository.
*/


// ---------------------------------------------------------------------------
// User options
// ---------------------------------------------------------------------------

OUTPUT_FILE := "intermediate_atkin_lehner_good_reduction.tsv";

// The requested intermediate quotients have 0 < dim(H) < omega(N).
// Keeping the full quotient in the output is useful for checking Table 6.
INCLUDE_FULL_QUOTIENT := true;
INCLUDE_TRIVIAL_COVER := false;

// The paper omits genus-zero quotients, and this default does the same.
POSITIVE_GENUS_ONLY := true;

// If true, include cases where only the Jacobian is good.  The last two
// output columns always distinguish Jacobian-good from curve-good primes.
INCLUDE_JACOBIAN_ONLY_CASES := true;

// Exact genera are obtained as dimensions of H-invariant rational homology
// in J_0(N), using Magma's Atkin--Lehner operators.
COMPUTE_EXACT_GENUS := true;

RUN_SELF_TEST := true;


// ---------------------------------------------------------------------------
// Complete library of lacking pairs (level, Atkin--Lehner sign pattern)
// from Tables 2--5 of arXiv:2607.11248.
// ---------------------------------------------------------------------------

lacking_data := [
    <[1],
      [2,3,5,7,11,13,17,19,23,29,31,41,47,59,71]>,
    <[-1],
      [2,3,5,7,13]>,
    <[1,1],
      [6,10,14,22,26,34,38,46,62,74,86,94,134,146,194,206,
       15,21,33,39,51,69,87,111,159,35,55,95,119]>,
    <[1,-1],
      [6,10,22,34,58,82,21,57,93]>,
    <[-1,1],
      [6,10,14,22,46,15,33]>,
    <[-1,-1],
      [6,10,14,22,26,34,38,46,58,62,74,82,86,94,106,118,122,
       134,146,166,178,194,202,206,314,15,21,33,39,51,57,69,87,
       93,111,129,159,183,237,35,55,65,85,95,115,215,77,119,161,143]>,
    <[1,1,1],
      [30,42,66,78,114,174,186,222,366,654,70,110,130,170,230,
       530,182,266,105,195,255,231]>,
    <[1,1,-1],
      [30,42,66,102,138,282,498,70,130,190,310,322,418,165,273]>,
    <[1,-1,1],
      [42,78,114,258,70,130,154,105,165]>,
    <[1,-1,-1],
      [30,42,66,78,102,114,138,174,186,222,246,282,318,354,426,
       534,70,110,190,230,290,310,154,182,238,266,434,518,602,286,
       374,494,105,165,195,255,285,435,615,231,455]>,
    <[-1,1,1],
      [30,78,102,190,105]>,
    <[-1,1,-1],
      [30,42,66,78,102,114,138,174,186,222,246,258,402,426,474,
       70,110,130,170,230,290,370,154,182,238,266,434,374,494,105,
       165,195,255,231,273,399]>,
    <[-1,-1,1],
      [30,42,66,78,102,114,138,174,186,222,246,258,282,318,354,
       366,402,426,438,474,498,534,582,642,654,678,822,70,110,130,
       170,190,230,290,310,370,410,530,610,154,182,266,322,406,518,
       602,286,374,418,442,105,165,195,255,285,435,615,231,273,399,455]>,
    <[-1,-1,-1],
      [30,42,78,70]>,
    <[1,1,1,1],
      [330,510,870,1230,546,770]>,
    <[1,1,1,-1],
      [210,390,1110,1290,858]>,
    <[1,1,-1,1],
      [210,330,570,462]>,
    <[1,1,-1,-1],
      [210,390,510,690,1590,546,798,770]>,
    <[1,-1,1,1],
      [210,330,510,690,870,1122]>,
    <[1,-1,1,-1],
      [210,330,390,510,570,930,462,714,910]>,
    <[1,-1,-1,1],
      [210,330,390,510,690,1110,462,546,714,966,1218,858,1326,1190]>,
    <[1,-1,-1,-1],
      [330]>,
    <[-1,1,1,1],
      [210,462,798,910]>,
    <[-1,1,1,-1],
      [210,330,390,570,1770,462,546,966,770]>,
    <[-1,1,-1,1],
      [210,330,390,510,570,690,930,1410,546,714,798,1302,1190]>,
    <[-1,1,-1,-1],
      [462]>,
    <[-1,-1,1,1],
      [210,330,390,510,570,690,870,930,1410,462,546,714,966,1218,
       858,770]>,
    <[-1,-1,1,-1],
      [330]>,
    <[-1,-1,-1,-1],
      [210,330,390,510,570,690,870,930,1110,1230,1290,1410,1590,
       1770,2010,2130,462,546,714,798,966,1218,1302,1722,1974,858,
       1122,1254,1914,1326,1794,1938,770,910,1190]>,
    <[1,1,-1,1,-1],
      [2310]>,
    <[1,-1,1,1,-1],
      [2730]>,
    <[1,-1,-1,-1,-1],
      [2310,2730,3990]>,
    <[-1,1,1,1,-1],
      [3570]>,
    <[-1,1,1,-1,1],
      [2310]>,
    <[-1,1,-1,-1,-1],
      [2310,4290]>,
    <[-1,-1,1,-1,-1],
      [2310,2730]>,
    <[-1,-1,-1,1,-1],
      [2310,2730,3570,3990]>,
    <[-1,-1,-1,-1,1],
      [2310,2730,3570,3990,4290]>
];


// ---------------------------------------------------------------------------
// Lacking-pair and character calculations
// ---------------------------------------------------------------------------

IsLacking := function(M, epsilon)
    // S_2^new(Gamma_0(1)) = 0.
    if M eq 1 then
        return true;
    end if;
    for item in lacking_data do
        if item[1] eq epsilon and M in item[2] then
            return true;
        end if;
    end for;
    return false;
end function;


PrimeIndicesInDivisor := function(M, prime_divisors_N)
    return [i : i in [1..#prime_divisors_N] |
                IsDivisibleBy(M, prime_divisors_N[i])];
end function;


BitsToSigns := function(bits)
    return [1 - 2*bits[i] : i in [1..#bits]];
end function;


CharacterIsTrivialOnIntersection := function(H, V, indices_M, bits)
    /*
      The level-M character epsilon is retained in H-invariants precisely when
      it is trivial on H meet W_M.  Equivalently it extends to a character of
      W_N/H.  Here 1 in 'bits' represents Atkin--Lehner sign -1.
    */
    U_M := sub<V | [V.i : i in indices_M]>;
    K := H meet U_M;
    for h in Basis(K) do
        dot := 0;
        for j in [1..#indices_M] do
            if h[indices_M[j]] ne 0 and bits[j] eq 1 then
                dot := 1 - dot;
            end if;
        end for;
        if dot eq 1 then
            return false;
        end if;
    end for;
    return true;
end function;


JacobianGoodPrimes := function(N, H, V, prime_divisors_N)
    /*
      At level M | N, the old multiplicity space supplies every extension to
      W_N of a level-M sign character once.  Thus a newform factor of level M
      occurs in Jac(X_0(N)/H) iff its character is trivial on H meet W_M.

      Neron--Ogg--Shafarevich then says that p | N is good precisely when no
      retained nonzero newspace has level divisible by p.
    */
    good := [];
    divisors_N := Divisors(N);

    for p_index in [1..#prime_divisors_N] do
        p := prime_divisors_N[p_index];
        bad := false;

        for M in divisors_N do
            if M gt 1 and IsDivisibleBy(M, p) then
                indices_M := PrimeIndicesInDivisor(M, prime_divisors_N);
                s := #indices_M;

                for mask in [0..2^s - 1] do
                    bits := [(mask div 2^(j-1)) mod 2 : j in [1..s]];
                    epsilon := BitsToSigns(bits);

                    if not IsLacking(M, epsilon) and
                       CharacterIsTrivialOnIntersection(
                           H, V, indices_M, bits) then
                        bad := true;
                        break;
                    end if;
                end for;
            end if;
            if bad then
                break;
            end if;
        end for;

        if not bad then
            Append(~good, p);
        end if;
    end for;

    return good;
end function;


SwapsComponentsAtPrime := function(H, p_index)
    // An element w_d swaps the two Deligne--Rapoport components at p iff p | d.
    for h in Basis(H) do
        if h[p_index] ne 0 then
            return true;
        end if;
    end for;
    return false;
end function;


CurveGoodPrimes := function(jacobian_good, H, prime_divisors_N)
    /*
      If H has nonzero projection to the p-coordinate, the quotient model has
      irreducible geometric special fibre.  The one-vertex criterion in
      Section 3 of the paper then makes curve-good equivalent to Jacobian-good.

      If the projection is zero, the two isomorphic components remain.  For a
      positive-genus quotient they cannot contract to a smooth special fibre,
      so the curve has bad reduction even in a Jacobian-good case.
    */
    good := [];
    for p in jacobian_good do
        p_index := Index(prime_divisors_N, p);
        assert p_index ne 0;
        if SwapsComponentsAtPrime(H, p_index) then
            Append(~good, p);
        end if;
    end for;
    return good;
end function;


HasPositiveGenus := function(N, H, V, prime_divisors_N)
    // Fast zero/nonzero test that does not construct J_0(N).
    for M in Divisors(N) do
        if M gt 1 then
            indices_M := PrimeIndicesInDivisor(M, prime_divisors_N);
            s := #indices_M;
            for mask in [0..2^s - 1] do
                bits := [(mask div 2^(j-1)) mod 2 : j in [1..s]];
                if not IsLacking(M, BitsToSigns(bits)) and
                   CharacterIsTrivialOnIntersection(
                       H, V, indices_M, bits) then
                    return true;
                end if;
            end for;
        end if;
    end for;
    return false;
end function;


// ---------------------------------------------------------------------------
// Subspaces H <= F_2^r = W_N
// ---------------------------------------------------------------------------

AllSubspacesOfDimension := function(V, k)
    /*
      Enumerate subspaces through their unique reduced-row-echelon bases.
      This avoids depending on a package-specific subspace enumerator.
    */
    r := Dimension(V);
    assert 0 le k and k le r;

    if k eq 0 then
        return [sub<V | V!0>];
    end if;

    answer := [];
    for pivot_set in Subsets({1..r}, k) do
        pivots := Setseq(pivot_set);
        Sort(~pivots);

        free_positions := [<i,j> : i in [1..k], j in [1..r] |
                           j gt pivots[i] and j notin pivot_set];

        for mask in [0..2^#free_positions - 1] do
            rows := [[GF(2)!0 : j in [1..r]] : i in [1..k]];
            for i in [1..k] do
                rows[i][pivots[i]] := GF(2)!1;
            end for;
            for t in [1..#free_positions] do
                i := free_positions[t][1];
                j := free_positions[t][2];
                rows[i][j] := GF(2)!((mask div 2^(t-1)) mod 2);
            end for;
            Append(~answer, sub<V | rows>);
        end for;
    end for;

    return answer;
end function;


SubgroupGeneratorDivisors := function(H, prime_divisors_N)
    generators := [];
    for h in Basis(H) do
        d := 1;
        for i in [1..#prime_divisors_N] do
            if h[i] ne 0 then
                d *:= prime_divisors_N[i];
            end if;
        end for;
        Append(~generators, d);
    end for;
    return generators;
end function;


IsPrunedCover := function(H, dead_quotients)
    // If K <= H and X/H is bad at every p | N, then the cover X/K is too.
    for D in dead_quotients do
        if H subset D then
            return true;
        end if;
    end for;
    return false;
end function;


// ---------------------------------------------------------------------------
// Exact quotient genus from H-invariant homology
// ---------------------------------------------------------------------------

AtkinLehnerHomologyMatrices := function(N, prime_divisors_N)
    A := JZero(N);
    g := Dimension(A);
    matrices := AssociativeArray();

    if g gt 0 then
        for mask in [1..2^#prime_divisors_N - 1] do
            d := 1;
            for i in [1..#prime_divisors_N] do
                if ((mask div 2^(i-1)) mod 2) eq 1 then
                    d *:= prime_divisors_N[i];
                end if;
            end for;
            matrices[d] := Matrix(AtkinLehnerOperator(A, d));
        end for;
    end if;

    return g, matrices;
end function;


ExactQuotientGenus := function(H, prime_divisors_N, genus_X0, matrices)
    if genus_X0 eq 0 then
        return 0;
    end if;

    Q := Rationals();
    invariant_homology := RSpace(Q, 2*genus_X0);
    identity := IdentityMatrix(Q, 2*genus_X0);

    for d in SubgroupGeneratorDivisors(H, prime_divisors_N) do
        invariant_homology meet:= Nullspace(matrices[d] - identity);
    end for;

    assert IsEven(Dimension(invariant_homology));
    return Dimension(invariant_homology) div 2;
end function;


// ---------------------------------------------------------------------------
// Candidate levels and checks
// ---------------------------------------------------------------------------

AllPlusLackingLevels := function()
    levels := [];
    for item in lacking_data do
        if &and[s eq 1 : s in item[1]] then
            for N in item[2] do
                if N notin levels then
                    Append(~levels, N);
                end if;
            end for;
        end if;
    end for;
    Sort(~levels);
    return levels;
end function;


if RUN_SELF_TEST then
    // Remark 3.9: X_0(74)/<w_74> has genus 2 and is good at 2.
    V_test := VectorSpace(GF(2), 2);
    H_test := sub<V_test | V_test![1,1]>;
    P_test := [2,37];
    assert JacobianGoodPrimes(74, H_test, V_test, P_test) eq [2];
    assert CurveGoodPrimes([2], H_test, P_test) eq [2];

    // The full quotient reproduces the same gained prime (Table 6).
    assert JacobianGoodPrimes(74, V_test, V_test, P_test) eq [2];
end if;


// ---------------------------------------------------------------------------
// Main enumeration
// ---------------------------------------------------------------------------

out := Open(OUTPUT_FILE, "w");
fprintf out,
    "N\trank_H\tindex_in_WN\tgenerators_wd\tgenus\t" cat
    "jacobian_good_primes\tcurve_good_primes\n";

row_count := 0;
level_count := 0;

for N in AllPlusLackingLevels() do
    assert IsSquarefree(N);
    prime_divisors_N := PrimeDivisors(N);
    r := #prime_divisors_N;
    V := VectorSpace(GF(2), r);

    /*
      Every intermediate quotient covers X_0(N)^*.  If the latter is bad at
      every prime dividing N, every cover is bad there as well.  Moreover, a
      good prime for a cover forces the level-N all-plus newspace to vanish,
      so the complete Tables 2--5 show that no N outside this loop is needed.
    */
    full_good := JacobianGoodPrimes(N, V, V, prime_divisors_N);
    if #full_good eq 0 then
        continue;
    end if;

    level_count +:= 1;
    if COMPUTE_EXACT_GENUS then
        genus_X0, homology_matrices :=
            AtkinLehnerHomologyMatrices(N, prime_divisors_N);
    else
        genus_X0 := -1;
        homology_matrices := AssociativeArray();
    end if;

    // Larger H means a lower quotient.  Descending rank lets a dead quotient
    // prune all of its covers, exactly as in the observation in the question.
    // This must be a Magma list, not a homogeneous sequence: as k decreases,
    // dead quotients have subspaces of different dimensions, whose parents
    // Magma will not coerce into one sequence universe.
    dead_quotients := [* *];
    for k in [r..0 by -1] do
        for H in AllSubspacesOfDimension(V, k) do
            if IsPrunedCover(H, dead_quotients) then
                continue;
            end if;

            jacobian_good :=
                JacobianGoodPrimes(N, H, V, prime_divisors_N);
            if #jacobian_good eq 0 then
                Append(~dead_quotients, H);
                continue;
            end if;

            positive_genus :=
                HasPositiveGenus(N, H, V, prime_divisors_N);
            curve_good := positive_genus select
                CurveGoodPrimes(jacobian_good, H, prime_divisors_N)
                else jacobian_good;

            if COMPUTE_EXACT_GENUS then
                quotient_genus := ExactQuotientGenus(
                    H, prime_divisors_N, genus_X0, homology_matrices);
                assert (quotient_genus gt 0) eq positive_genus;
            else
                quotient_genus := positive_genus select -1 else 0;
            end if;

            is_full := k eq r;
            is_trivial := k eq 0;
            include_by_position :=
                (not is_full or INCLUDE_FULL_QUOTIENT) and
                (not is_trivial or INCLUDE_TRIVIAL_COVER);
            include_by_genus := not POSITIVE_GENUS_ONLY or positive_genus;
            include_by_reduction := INCLUDE_JACOBIAN_ONLY_CASES or
                                    #curve_good gt 0;

            if include_by_position and include_by_genus and
               include_by_reduction then
                generators :=
                    SubgroupGeneratorDivisors(H, prime_divisors_N);
                fprintf out, "%o\t%o\t%o\t%o\t%o\t%o\t%o\n",
                    N, k, 2^(r-k), generators, quotient_genus,
                    jacobian_good, curve_good;
                row_count +:= 1;
            end if;
        end for;
    end for;
end for;

delete out;

print "Candidate levels processed:", level_count;
print "Rows written:", row_count;
print "Output file:", OUTPUT_FILE;
