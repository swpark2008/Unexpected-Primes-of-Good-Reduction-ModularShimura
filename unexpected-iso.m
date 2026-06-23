list := [
[74,37],
[86,43],
[111,37],
[114,57],
[130,65],
[134,67],
[146,73],
[159,53],
[170,65],
[174,58],
[182,91],
[186,93],
//[194,97], //done separately, see below
[195,65],
[206,103],
[222,37],
[230,115],
[231,77],
[255,85],
[266,133],
[330,165],
[546,273]
];

for pair in list do
	N1 := pair[1];
	N2 := pair[2];
	W1 := [p^Valuation(N1,p) : p in PrimeDivisors(N1)];
	W2 := [p^Valuation(N2,p) : p in PrimeDivisors(N2)];
	X1 := X0NQuotient(N1,W1);
	X2 := X0NQuotient(N2,W2);
	b := IsIsomorphic(X1,X2);
	print pair,b;
	print "----------";
end for;

//X0(97)^+ is isomorphic to X0(194)^*

P<a,b,c> := ProjectiveSpace(Rationals(),2);    
f1 := a^3*b - a^2*b^2 - a^3*c + a^2*b*c + b^3*c + 
    a^2*c^2 + a*b*c^2 - b*c^3;
X1 := Curve(P,f1);
f2 := a^3*b + a^2*b^2 + a^3*c + a^2*b*c + b^3*c - 
    a^2*c^2 + a*b*c^2 - b*c^3;
X2 := Curve(P,f2);
IsIsomorphicPlaneQuartics(X1, X2);

