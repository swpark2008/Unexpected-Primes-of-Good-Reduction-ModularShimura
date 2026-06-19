// Compute the numerical bounds in Table 1 from the inequality
//
//   F_{C,m}(x) = rho_{C,m}/12*x - A_C(m)
//        - 2^(m-1+B_C)/3.14 * sqrt(x)*(log(x)+4*log(2)).
//
// where C is a congruence class.  To get a stronger inequality, we use 314/100 exactly.

// BoundCeiling(C,m) returns the smallest integer B such that F_{C,m}(B) > 0.

function FirstPrimesAtLeast(a, m)
  ps := [];
  n := a;
  while #ps lt m do
    if IsPrime(n) then
      Append(~ps, n);
    end if;
    n +:= 1;
  end while;
  return ps;
end function;

function StartPrime(C)
  if C eq "pm" then
    return 5;      // N == +/-1 mod 6
  elif C eq "three" then
    return 3;      // N == 3 mod 6
  elif C eq "even" then
    return 2;      // N == 0 mod 2
  else
    error "unknown congruence class";
  end if;
end function;

function BClass(C)
  if C eq "pm" then
    return 1;
  else
    return 2;
  end if;
end function;

function OmegaCutoff(C)
  if C eq "pm" then
    return 9;
  elif C eq "three" then
    return 11;
  elif C eq "even" then
    return 13;
  else
    error "unknown congruence class";
  end if;
end function;

function IsDash(C, m)
  return m ge OmegaCutoff(C);
end function;

function AValue(C, m)
  QQ := Rationals();

  if C eq "pm" then
    return (QQ!(19*2^m))/12 + 1;
  elif C eq "three" then
    return (QQ!(9*2^m))/4 + 1;
  elif C eq "even" then
    return QQ!(3*2^m + 1);
  else
    error "unknown congruence class";
  end if;
end function;

function RhoValue(C, m)
  QQ := Rationals();
  ps := FirstPrimesAtLeast(StartPrime(C), m);

  rho := QQ!1;
  for p in ps do
    rho *:= (QQ!(p-1))/(QQ!p);
  end for;

  return rho;
end function;

function FValue(C, m, x, RR)
  xx := RR!x;
  rho := RhoValue(C, m);
  A := AValue(C, m);

  coeff := (RR!(2^(m - 1 + BClass(C))))/(RR!(314/100));

  return ((RR!rho)/(RR!12))*xx
       - RR!A
       - coeff*Sqrt(xx)*(Log(xx) + (RR!4)*Log(RR!2));
end function;

function RootApprox(C, m, prec, steps)
  RR := RealField(prec);

  lo := RR!1;
  hi := RR!2;

  while FValue(C, m, hi, RR) le 0 do
    lo := hi;
    hi *:= 2;
  end while;

  for i in [1..steps] do
    mid := (lo + hi)/2;
    if FValue(C, m, mid, RR) gt 0 then
      hi := mid;
    else
      lo := mid;
    end if;
  end for;

  return (lo + hi)/2;
end function;

function BoundCeiling(C, m, prec)
  RR := RealField(prec);

  lo := 1;
  hi := 2;

  assert FValue(C, m, lo, RR) lt 0; // F(1) is not negative

  while FValue(C, m, hi, RR) le 0 do
    hi *:= 2;
  end while;

  while hi - lo gt 1 do
    mid := (lo + hi) div 2;

    if FValue(C, m, mid, RR) gt 0 then
      hi := mid;
    else
      lo := mid;
    end if;
  end while;

  // Now F(lo) <= 0 and F(hi) > 0.
  return hi;
end function;

function EntryStr(C, m, prec)
  if IsDash(C, m) then
    return "-";
  else
    return Sprint(BoundCeiling(C, m, prec));
  end if;
end function;

procedure PrintTable(prec)
  printf "omega(N) | N == +/-1 mod 6 | N == 3 mod 6 | N == 0 mod 2\n";
  printf "---------------------------------------------------------------\n";

  for m in [13,12,11,10,9,8,7,6,5,4,3,2] do
    printf "%o | %o | %o | %o\n",
      m,
      EntryStr("pm", m, prec),
      EntryStr("three", m, prec),
      EntryStr("even", m, prec);
  end for;
end procedure;

procedure PrintRoots(prec, steps)
  classes := ["pm", "three", "even"];

  for C in classes do
    printf "\nClass %o\n", C;

    for m in [2..(OmegaCutoff(C)-1)] do
      r := RootApprox(C, m, prec, steps);
      B := BoundCeiling(C, m, prec);
      printf "m=%o  root ~ %o  ceiling=%o\n", m, r, B;
    end for;
  end for;
end procedure;

PrintTable(120);

// Uncomment this to also print the real roots.
// PrintRoots(120, 200);
