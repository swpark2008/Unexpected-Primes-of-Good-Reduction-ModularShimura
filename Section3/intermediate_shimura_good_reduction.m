/*
  intermediate_shimura_good_reduction.m

  Classify genuine intermediate Atkin--Lehner quotients

      X_0(D;N)/H,   0 < H < W_{DN},

  of positive genus having a gained prime of good reduction.  Here D and N
  are coprime and squarefree and D is the product of an even number of primes.

  Candidate pairs are the union of:

    * the 259 squarefree-N rows of Proposition 4.1 in Joan Nualart Riera's
      2015 thesis (the genus-zero full quotients omitted by PPV); and
    * the 46 positive-genus full quotients in Table 7 of
      Padurariu--Park--Voight, arXiv:2607.11248.

  The zero/nonzero tests use the complete lacking-sign data in Tables 2--5
  of PPV.  At q | D the Jacquet--Langlands correspondence flips the classical
  Atkin--Lehner sign.  At q | N it does not.

  The subgroup H is encoded entirely by integer bit masks.  In particular,
  no Magma subspace object is ever appended to a typed sequence; this avoids
  the universe-coercion failure seen in earlier versions of the modular code.

  Run:

      magma intermediate_shimura_good_reduction.m

  Outputs:

      intermediate_shimura_good_reduction.tsv
      intermediate_shimura_good_reduction_table.tex

  In the output, generators [d_1,...,d_s] mean
  H = <w_{d_1},...,w_{d_s}>.  They are the unique reduced-row-echelon basis
  relative to the increasing list of primes dividing DN.
*/


// ---------------------------------------------------------------------------
// User options
// ---------------------------------------------------------------------------

OUTPUT_TSV := "intermediate_shimura_good_reduction.tsv";
OUTPUT_TEX := "intermediate_shimura_good_reduction_table.tex";
SCRIPT_VERSION := "2026-08-26.2";

// The requested classification concerns genuine intermediate quotients.
INCLUDE_FULL_QUOTIENT := false;
INCLUDE_TRIVIAL_COVER := false;

// Retain the eight cases where the Jacobian is good but the curve is not.
// The TSV and LaTeX columns distinguish the two notions.
INCLUDE_JACOBIAN_ONLY_CASES := true;

RUN_SELF_TEST := true;


// ---------------------------------------------------------------------------
// Complete lacking pairs from Tables 2--5 of arXiv:2607.11248
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
// Candidate pairs (D,N)
// ---------------------------------------------------------------------------

// All squarefree-N rows of NR15, Proposition 4.1.
prop41_squarefree_pairs := [
    <6,1>, <6,5>, <6,7>, <6,11>, <6,13>, <6,17>,
    <6,19>, <6,23>, <6,29>, <6,31>, <6,35>, <6,37>,
    <6,41>, <6,43>, <6,47>, <6,53>, <6,55>, <6,59>,
    <6,61>, <6,65>, <6,67>, <6,71>, <6,73>, <6,77>,
    <6,79>, <6,83>, <6,85>, <6,89>, <6,91>, <6,95>,
    <6,97>, <6,107>, <6,109>, <6,113>, <6,115>, <6,119>,
    <6,137>, <6,143>, <6,145>, <6,155>, <6,161>, <6,203>,
    <6,235>, <10,1>, <10,3>, <10,7>, <10,11>, <10,13>,
    <10,17>, <10,19>, <10,21>, <10,23>, <10,29>, <10,31>,
    <10,33>, <10,37>, <10,39>, <10,41>, <10,51>, <10,53>,
    <10,57>, <10,61>, <10,69>, <10,77>, <10,93>, <14,1>,
    <14,3>, <14,5>, <14,11>, <14,13>, <14,15>, <14,19>,
    <14,23>, <14,29>, <14,37>, <14,39>, <14,43>, <14,57>,
    <15,1>, <15,2>, <15,7>, <15,11>, <15,13>, <15,14>,
    <15,17>, <15,19>, <15,22>, <15,26>, <15,29>, <15,34>,
    <15,41>, <21,1>, <21,2>, <21,5>, <21,10>, <21,11>,
    <21,13>, <21,19>, <21,22>, <21,26>, <22,1>, <22,3>,
    <22,5>, <22,7>, <22,13>, <22,15>, <22,17>, <22,19>,
    <22,21>, <22,35>, <26,1>, <26,3>, <26,5>, <26,7>,
    <26,15>, <26,17>, <26,21>, <33,1>, <33,2>, <33,5>,
    <33,7>, <33,10>, <33,14>, <34,1>, <34,3>, <34,5>,
    <34,7>, <34,11>, <35,1>, <35,2>, <35,3>, <35,6>,
    <35,13>, <38,1>, <38,3>, <38,7>, <38,13>, <39,1>,
    <39,2>, <39,5>, <39,7>, <39,10>, <46,1>, <46,3>,
    <46,5>, <51,1>, <51,2>, <51,5>, <51,10>, <55,1>,
    <55,2>, <55,3>, <57,1>, <57,2>, <57,7>, <58,1>,
    <58,3>, <58,5>, <62,1>, <62,3>, <62,7>, <65,1>,
    <65,3>, <69,1>, <69,2>, <74,1>, <74,3>, <74,5>,
    <77,1>, <77,2>, <77,3>, <82,1>, <82,3>, <85,1>,
    <85,3>, <86,1>, <86,3>, <87,1>, <87,2>, <93,1>,
    <93,2>, <94,1>, <95,1>, <95,2>, <95,3>, <106,1>,
    <111,1>, <111,2>, <115,1>, <115,2>, <118,1>, <119,1>,
    <119,2>, <122,1>, <129,1>, <134,1>, <134,3>, <143,1>,
    <143,2>, <146,1>, <159,1>, <159,2>, <161,1>, <166,1>,
    <178,1>, <183,1>, <194,1>, <202,1>, <206,1>, <210,1>,
    <210,11>, <210,13>, <210,17>, <210,19>, <215,1>, <237,1>,
    <314,1>, <330,1>, <330,7>, <330,13>, <390,1>, <390,7>,
    <462,1>, <462,5>, <510,1>, <510,7>, <546,1>, <546,5>,
    <570,1>, <570,7>, <690,1>, <714,1>, <770,1>, <770,3>,
    <798,1>, <858,1>, <870,1>, <910,1>, <930,1>, <966,1>,
    <1110,1>, <1122,1>, <1190,1>, <1218,1>, <1230,1>, <1254,1>,
    <1290,1>, <1302,1>, <1326,1>, <1410,1>, <1590,1>, <1722,1>,
    <1770,1>, <1794,1>, <1914,1>, <1938,1>, <1974,1>, <2010,1>,
    <2130,1>
];

// PPV Table 7.  The paper prints columns N,D; these tuples are (D,N).
paper_table7_pairs := [
    <91,2>, <123,2>, <133,2>, <141,2>, <145,2>, <155,2>,
    <177,2>, <187,2>, <213,2>, <217,2>, <247,2>, <259,2>,
    <267,2>, <301,2>, <1155,2>, <1365,2>, <1995,2>,
    <142,3>, <145,3>, <158,3>, <205,3>, <1430,3>, <91,5>,
    <65,6>, <85,6>, <91,6>, <115,6>, <133,6>,
    <57,10>, <77,10>, <93,10>, <51,14>, <38,15>, <46,21>,
    <33,26>, <21,34>, <35,34>, <39,34>, <15,46>, <21,46>,
    <14,51>, <21,58>, <15,74>, <14,85>, <14,93>, <10,141>
];


// ---------------------------------------------------------------------------
// Integer-mask linear algebra for H <= W_{DN} = F_2^r
// ---------------------------------------------------------------------------

MaskHasBit := function(mask, i)
    return ((mask div 2^(i-1)) mod 2) eq 1;
end function;


MaskXor := function(a, b, r)
    c := 0;
    for i in [1..r] do
        if MaskHasBit(a, i) ne MaskHasBit(b, i) then
            c +:= 2^(i-1);
        end if;
    end for;
    return c;
end function;


MaskFromIndices := function(indices)
    mask := 0;
    for i in indices do
        mask +:= 2^(i-1);
    end for;
    return mask;
end function;


MaskFromDivisor := function(d, prime_divisors)
    return MaskFromIndices(
        [i : i in [1..#prime_divisors] |
             IsDivisibleBy(d, prime_divisors[i])]);
end function;


SubgroupCodeFromBasis := function(basis_masks, r)
    code := { Integers() | 0 };
    for b in basis_masks do
        old_code := Setseq(code);
        for x in old_code do
            Include(~code, MaskXor(x, b, r));
        end for;
    end for;
    return code;
end function;


AllSubgroupsOfRank := function(r, k)
    /*
      Return a Magma list of <basis_masks, code> records.  The bases run
      through unique reduced row echelon forms.  A list [* ... *], rather
      than a typed sequence [...], is deliberate: the records contain sets.
    */
    assert 0 le k and k le r;
    answer := [* *];

    if k eq 0 then
        Append(~answer, <[], { Integers() | 0 }>);
        return answer;
    end if;

    for pivot_set in Subsets({1..r}, k) do
        pivots := Setseq(pivot_set);
        Sort(~pivots);
        free_positions :=
            [<i,j> : i in [1..k], j in [1..r] |
                     j gt pivots[i] and j notin pivot_set];

        for free_mask in [0..2^#free_positions - 1] do
            basis_masks := [2^(pivots[i]-1) : i in [1..k]];
            for t in [1..#free_positions] do
                if MaskHasBit(free_mask, t) then
                    i := free_positions[t][1];
                    j := free_positions[t][2];
                    basis_masks[i] +:= 2^(j-1);
                end if;
            end for;
            code := SubgroupCodeFromBasis(basis_masks, r);
            Append(~answer, <basis_masks, code>);
        end for;
    end for;

    return answer;
end function;


IsPrunedCover := function(H_code, dead_quotient_codes)
    // If K <= H and X/H is bad at every p | DN, the cover X/K is too.
    for dead_code in dead_quotient_codes do
        if H_code subset dead_code then
            return true;
        end if;
    end for;
    return false;
end function;


GeneratorDivisors := function(basis_masks, prime_divisors)
    generators := [];
    for mask in basis_masks do
        d := 1;
        for i in [1..#prime_divisors] do
            if MaskHasBit(mask, i) then
                d *:= prime_divisors[i];
            end if;
        end for;
        Append(~generators, d);
    end for;
    return generators;
end function;


// ---------------------------------------------------------------------------
// Lacking-sign and retained-character tests
// ---------------------------------------------------------------------------

IsLacking := function(M, classical_signs)
    for item in lacking_data do
        if item[1] eq classical_signs and M in item[2] then
            return true;
        end if;
    end for;
    return false;
end function;


PrimeIndicesInDivisor := function(M, prime_divisors)
    return [i : i in [1..#prime_divisors] |
                IsDivisibleBy(M, prime_divisors[i])];
end function;


ClassicalBitsToSigns := function(bits)
    return [1 - 2*bits[i] : i in [1..#bits]];
end function;


GeometricNegativeMask := function(
        D, indices_M, classical_bits, prime_divisors)
    /*
      A 1 records eigenvalue -1 for the geometric Shimura involution.
      Jacquet--Langlands flips signs at ramified primes q | D.
    */
    mask := 0;
    for j in [1..#indices_M] do
        i := indices_M[j];
        bit := classical_bits[j];
        if IsDivisibleBy(D, prime_divisors[i]) then
            bit := 1 - bit;
        end if;
        if bit eq 1 then
            mask +:= 2^(i-1);
        end if;
    end for;
    return mask;
end function;


CharacterIsTrivialOnIntersection := function(
        H_code, support_mask, negative_mask, r)
    /*
      The level-M character is retained precisely when it is trivial on
      H meet W_M.  Elements of H outside W_M are ignored because the old
      multiplicity space supplies all extensions at primes dividing DN/M.
    */
    outside_mask := 2^r - 1 - support_mask;
    for h in H_code do
        supported := true;
        parity := 0;
        for i in [1..r] do
            if MaskHasBit(h, i) and MaskHasBit(outside_mask, i) then
                supported := false;
                break;
            end if;
            if MaskHasBit(h, i) and MaskHasBit(negative_mask, i) then
                parity := 1 - parity;
            end if;
        end for;
        if supported and parity eq 1 then
            return false;
        end if;
    end for;
    return true;
end function;


RetainedNonzeroNewspace := function(
        D, M, H_code, prime_divisors, r)
    indices_M := PrimeIndicesInDivisor(M, prime_divisors);
    support_mask := MaskFromIndices(indices_M);
    s := #indices_M;

    for sign_mask in [0..2^s - 1] do
        classical_bits :=
            [(sign_mask div 2^(j-1)) mod 2 : j in [1..s]];
        classical_signs := ClassicalBitsToSigns(classical_bits);
        if not IsLacking(M, classical_signs) then
            negative_mask := GeometricNegativeMask(
                D, indices_M, classical_bits, prime_divisors);
            if CharacterIsTrivialOnIntersection(
                    H_code, support_mask, negative_mask, r) then
                return true;
            end if;
        end if;
    end for;
    return false;
end function;


HasPositiveGenus := function(D, N, H_code, prime_divisors)
    r := #prime_divisors;
    for A in Divisors(N) do
        M := D*A;
        if RetainedNonzeroNewspace(D, M, H_code, prime_divisors, r) then
            return true;
        end if;
    end for;
    return false;
end function;


JacobianGoodPrimes := function(D, N, H_code, prime_divisors)
    /* Lemma 3.7, with H-invariants inserted before the isogeny factors. */
    r := #prime_divisors;
    good := [];

    for p in prime_divisors do
        bad := false;
        for A in Divisors(N) do
            M := D*A;
            if IsDivisibleBy(M, p) and
               RetainedNonzeroNewspace(
                   D, M, H_code, prime_divisors, r) then
                bad := true;
                break;
            end if;
        end for;
        if not bad then
            Append(~good, p);
        end if;
    end for;
    return good;
end function;


SubgroupProjectsToPrime := function(basis_masks, p_index)
    if #basis_masks eq 0 then
        return false;
    end if;
    return &or[MaskHasBit(mask, p_index) : mask in basis_masks];
end function;


CurveGoodPrimes := function(
        D, N, jacobian_good, basis_masks, prime_divisors)
    /*
      For p | N, a nonzero p-coordinate identifies the two components.
      The resulting one-vertex model is smooth iff its Jacobian is good.
      Primes p | D are always bad for a positive-genus retained factor.
    */
    good := [];
    for p in jacobian_good do
        if IsDivisibleBy(N, p) then
            p_index := Index(prime_divisors, p);
            assert p_index ne 0;
            if SubgroupProjectsToPrime(basis_masks, p_index) then
                Append(~good, p);
            end if;
        end if;
    end for;
    return good;
end function;


// ---------------------------------------------------------------------------
// Output helpers
// ---------------------------------------------------------------------------

SequenceString := function(S, left_delimiter, right_delimiter)
    result := left_delimiter;
    for i in [1..#S] do
        result cat:= Sprint(S[i]);
        if i lt #S then
            result cat:= ",";
        end if;
    end for;
    result cat:= right_delimiter;
    return result;
end function;


SubgroupLatex := function(generators)
    result := "$\\langle ";
    for i in [1..#generators] do
        result cat:= "w_{" cat Sprint(generators[i]) cat "}";
        if i lt #generators then
            result cat:= ",";
        end if;
    end for;
    result cat:= "\\rangle$";
    return result;
end function;


PrimeSetLatex := function(primes)
    if #primes eq 0 then
        return "--";
    end if;
    return "$\\{" cat SequenceString(primes, "", "") cat "\\}$";
end function;


WriteLatexPreamble := procedure(tex)
    fprintf tex, "\\documentclass[10pt]{article}\n";
    fprintf tex, "\\usepackage[margin=18mm]{geometry}\n";
    fprintf tex, "\\usepackage{booktabs,longtable,pdflscape}\n";
    fprintf tex, "\\begin{document}\n\\begin{landscape}\n\\scriptsize\n";
    fprintf tex, "\\begin{longtable}{rrlrrll}\n";
    fprintf tex,
        "\\caption{Positive-genus intermediate Shimura quotients with a " cat
        "gained prime.}\\\\\n";
    fprintf tex, "\\toprule\n";
    fprintf tex,
        "$D$ & $N$ & $H$ & $[W_{DN}:H]$ & $p_J$ & $p_X$ & source \\\\\n";
    fprintf tex, "\\midrule\n\\endfirsthead\n";
    fprintf tex, "\\toprule\n";
    fprintf tex,
        "$D$ & $N$ & $H$ & $[W_{DN}:H]$ & $p_J$ & $p_X$ & source \\\\\n";
    fprintf tex, "\\midrule\n\\endhead\n";
    fprintf tex, "\\midrule\\multicolumn{7}{r}{continued}\\\\\n\\endfoot\n";
    fprintf tex, "\\bottomrule\n\\endlastfoot\n";
end procedure;


WriteLatexPostamble := procedure(tex)
    fprintf tex, "\\end{longtable}\n";
    fprintf tex,
        "\\noindent Here $p_J$ (respectively $p_X$) lists primes of gained " cat
        "good reduction for the Jacobian (respectively the curve).  A dash " cat
        "in $p_X$ denotes a Jacobian-only case.  Source P is Proposition~4.1 " cat
        "of NR15; source T is Table~7 of PPV.  Only squarefree $N$ from " cat
        "Proposition~4.1 is used.  Bases for $H$ are in canonical reduced " cat
        "row echelon form relative to increasing primes dividing $DN$.\n";
    fprintf tex, "\\end{landscape}\n\\end{document}\n";
end procedure;


// ---------------------------------------------------------------------------
// Self-tests
// ---------------------------------------------------------------------------

if RUN_SELF_TEST then
    // Full genus-zero quotient from Proposition 4.1: all factors are lacking.
    P := PrimeDivisors(6*5);
    B := [2^(i-1) : i in [1..#P]];
    C := SubgroupCodeFromBasis(B, #P);
    assert not HasPositiveGenus(6, 5, C, P);
    assert JacobianGoodPrimes(6, 5, C, P) eq P;

    // PPV Table 7: X_0^*(91;2) has gained prime 2 and positive genus.
    P := PrimeDivisors(91*2);
    B := [2^(i-1) : i in [1..#P]];
    C := SubgroupCodeFromBasis(B, #P);
    assert HasPositiveGenus(91, 2, C, P);
    assert JacobianGoodPrimes(91, 2, C, P) eq [2];

    // PPV Remark 3.9: X_0(210;11)/<w_2,w_5,w_7,w_33> is good at 11.
    P := PrimeDivisors(210*11);
    B := [MaskFromDivisor(d, P) : d in [2,5,7,33]];
    C := SubgroupCodeFromBasis(B, #P);
    assert HasPositiveGenus(210, 11, C, P);
    assert JacobianGoodPrimes(210, 11, C, P) eq [11];
    assert CurveGoodPrimes(210, 11, [11], B, P) eq [11];
end if;


// ---------------------------------------------------------------------------
// Main enumeration
// ---------------------------------------------------------------------------

candidates := [* *];
for pair in prop41_squarefree_pairs do
    Append(~candidates, <pair[1], pair[2], "P">);
end for;
for pair in paper_table7_pairs do
    Append(~candidates, <pair[1], pair[2], "T">);
end for;
assert #prop41_squarefree_pairs eq 259;
assert #paper_table7_pairs eq 46;
assert #candidates eq 305;

out := Open(OUTPUT_TSV, "w");
tex := Open(OUTPUT_TEX, "w");
fprintf out,
    "D\tN\trank_H\tindex_in_WDN\tgenerators_wd\t" cat
    "jacobian_good_primes\tcurve_good_primes\tsource\n";
WriteLatexPreamble(tex);

row_count := 0;
level_count := 0;
curve_row_count := 0;
jacobian_only_count := 0;

print "Running intermediate Shimura search, version", SCRIPT_VERSION;

for candidate in candidates do
    D := candidate[1];
    N := candidate[2];
    source := candidate[3];

    assert D gt 1 and GCD(D, N) eq 1;
    assert IsSquarefree(D) and IsSquarefree(N);
    assert IsEven(#PrimeDivisors(D));

    prime_divisors := PrimeDivisors(D*N);
    r := #prime_divisors;
    rows_at_level := 0;
    dead_quotient_codes := [* *];

    // Descending rank makes the bad-quotient pruning observation effective.
    for k in [r..0 by -1] do
        for subgroup_record in AllSubgroupsOfRank(r, k) do
            basis_masks := subgroup_record[1];
            H_code := subgroup_record[2];

            if IsPrunedCover(H_code, dead_quotient_codes) then
                continue;
            end if;

            jacobian_good := JacobianGoodPrimes(
                D, N, H_code, prime_divisors);
            if #jacobian_good eq 0 then
                // This is a Magma list, so sets from different ambient ranks
                // never trigger a sequence-universe coercion.
                Append(~dead_quotient_codes, H_code);
                continue;
            end if;

            positive_genus := HasPositiveGenus(
                D, N, H_code, prime_divisors);
            if not positive_genus then
                continue;
            end if;

            curve_good := CurveGoodPrimes(
                D, N, jacobian_good, basis_masks, prime_divisors);
            if not INCLUDE_JACOBIAN_ONLY_CASES and #curve_good eq 0 then
                continue;
            end if;

            is_full := k eq r;
            is_trivial := k eq 0;
            if (is_full and not INCLUDE_FULL_QUOTIENT) or
               (is_trivial and not INCLUDE_TRIVIAL_COVER) then
                continue;
            end if;

            generators := GeneratorDivisors(basis_masks, prime_divisors);
            index_in_W := 2^(r-k);

            fprintf out, "%o\t%o\t%o\t%o\t%o\t%o\t%o\t%o\n",
                D, N, k, index_in_W, generators, jacobian_good,
                curve_good, source;
            fprintf tex, "%o & %o & %o & %o & %o & %o & %o \\\\\n",
                D, N, SubgroupLatex(generators), index_in_W,
                PrimeSetLatex(jacobian_good), PrimeSetLatex(curve_good),
                source;

            row_count +:= 1;
            rows_at_level +:= 1;
            if #curve_good gt 0 then
                curve_row_count +:= 1;
            else
                jacobian_only_count +:= 1;
            end if;
        end for;
    end for;

    if rows_at_level gt 0 then
        level_count +:= 1;
    end if;
end for;

WriteLatexPostamble(tex);
delete out;
delete tex;

assert level_count eq 170;
assert row_count eq 606;
assert curve_row_count eq 598;
assert jacobian_only_count eq 8;

print "Candidate pairs:", #candidates;
print "Pairs with reported intermediate quotients:", level_count;
print "Rows written:", row_count;
print "Rows with curve-good primes:", curve_row_count;
print "Jacobian-only rows:", jacobian_only_count;
print "TSV output:", OUTPUT_TSV;
print "LaTeX output:", OUTPUT_TEX;
