# Unexpected Primes of Good Reduction in Quotients of Modular and Shimura Curves

The following repository contains Magma and Sage implementations utilized to compute the set of all possible levels for which the modular curves of level N and weight 2 with a given sign pattern have trivial dimensions, as well as the set of gained primes of good reduction for Atkin--Lehner quotients of modular and Shimura curves. The respective codes that implement results stated in Sections 2, 3, and 4 of the manuscript are stored in respective folders.

## Section 2: Dimensions of weight 2 newforms

The following codes can be used to obtain Tables 2, 3, 4, and 5 from the manuscript. We refer to page 8-9, steps 1 through 5 for further details of the implementation.

* Steps 1-4: We execute the file "Computations-PPV-Shimura" implemented on Magma. We note that the hard-coded upper bound on N for each "Computations-PPV-X-Shimura-Version3" file is computed using "boundceiling.m" file. The total execution time and memory usage can be found in the file "ExecutionTime". The code will output all files of form "Shimura-W-ResultsXXX", where W is the number of distinct prime factors of the level N, and XXX indicates the type of sign pattern endowed to the modular curve with W many distinct prime factors (Given the execution time for running the Magma code takes approximately 3~4 days, we stored all the outputs one achieves from running the code under the folder "Shimura-Data").
* Step 5: We attach the jupyter notebook file "Snew-New.ipynb" implemented on Sage, which also uses the Sage code written by Kimball Martin (Link: https://kimballmartin.github.io/data/). A sample output of running the code can be downloaded using the html file "Snew-New.html". To run the "Snew-New.ipynb" code as shown in the file, one is required to follow the following procedures beforehand.
  - Access the LMFDB beta page: https://beta.lmfdb.org/NumberField/QuadraticImaginaryClassGroups
  - Download the following list of files:
    + |d| = 3 mod 8, k = 0, 1, 2
    + |d| = 4 mod 16, k = 0, 1, 2, 3, 4, 5
    + |d| = 7 mod 8, k = 0, 1, 2
    + |d| = 8 mod 16, k = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  - Rename all the files in the following format and store under the folder "Shimura-Data":
    + cl_3_mod_8_k (where k = 0, 1, 2)
    + cl_4_mod_16_k (where k = 0, 1, 2, 3, 4, 5)
    + cl_7_mod_8_k (where k = 0, 1, 2)
    + cl_8_mod_16_k (where k = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

## Section 3: Gained primes of good reduction

We execute the file "sub_main.m", from which the gained primes of good reduction as well as genera of the original modular (Shimura) curves and their Atkin--Lehner quotients are computed. The output of running the code can be found under "Output" file. We would like to thank Freddy Saia and Oana Padurariu for sharing their github repository, whose code we used to implement "sub_main.m". (Link: https://github.com/fsaia/GenusAtMost2/blob/main/quot_genus.m).

## Section 4: Tables

We execute the file "unexpected-iso.m", from which the exceptional isomorphisms between Atkin--Lehner quotients of modular curves are computed. The output of running the code can be found under "unexpected-iso-Output" file. The exceptional isomorphism are recorded in Table 6 of the manuscript.
