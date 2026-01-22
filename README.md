# Gain of Primes of Good Reduction in Quotients of Modular and Shimura Curves

The following repository contains Magma and Sage implementations utilized to compute the set of all possible levels for which the modular curves of level N and weight 2 with a given sign pattern have trivial dimensions.

* Magma Code: We execute the file "Computations-PPV-Shimura". The total execution time and memory usage can be found in the file "ExecutionTime". The code will output all files of form "Shimura-W-ResultsXXX", where W is the number of distinct prime factors of the level N, and XXX indicates the type of sign pattern endowed to the modular curve with W many distinct prime factors.
* Given the execution time for running the Magma code is very long, we stored all the outputs one achieves from running the code under the folder "Shimura-Data-New".
* Sage Code: We attach the jupyter notebook file "Snew.ipynb". A sample output of running the code can be downloaded using the html file "PPV-Snew.html". To run the "Snew.ipynb" code as shown in the file, one is required to follow the following procedures beforehand.
  - Access the LMFDB beta page: https://beta.lmfdb.org/NumberField/QuadraticImaginaryClassGroups
  - Download the following list of files:
    + |d| = 3 mod 8, k = 0, 1, 2
    + |d| = 4 mod 16, k = 0, 1, 2, 3, 4, 5
    + |d| = 7 mod 8, k = 0, 1, 2
    + |d| = 8 mod 16, k = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
  - Rename all the files in the following format and store under the folder "Shimura-Data-New":
    + cl_3_mod_8_k (where k = 0, 1, 2)
    + cl_4_mod_16_k (where k = 0, 1, 2, 3, 4, 5)
    + cl_7_mod_8_k (where k = 0, 1, 2)
    + cl_8_mod_16_k (where k = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
* Another Magma code: We execute the file "sub_main.m", from which the gained primes of good reduction as well as genera of the original modular (Shimura) curves and their Atkin-Lehner quotients are computed. The output of running the code can be found under "Output" file. We would like to thank Freddy Saia and Oana Padurariu for sharing their github repository, whose code we used to implement "sub_main.m". (Link: https://github.com/fsaia/GenusAtMost2/blob/main/quot_genus.m).
