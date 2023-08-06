HPC TEAM SCRIPTS

HOW TO OPTIMISE HPL.dat file
Understanding Your System:
Before optimizing the HPL.dat file, it's crucial to have a good understanding of the hardware and software configuration of your computing platform. This includes the number of processors, memory, network topology, and other relevant system specifications.

Problem Sizes (Ns) and Block Sizes (NBs):
Select problem sizes (Ns) and block sizes (NBs) that match the memory capacity and cache sizes of your processors. Larger problem sizes can stress the system more, but if they don't fit in memory, the performance may degrade due to excessive swapping. Smaller block sizes can lead to more efficient cache usage but might increase communication overhead. Try a few different combinations to find the best trade-off.

Process Grid Configurations (P x Q):
Choose process grid configurations that align well with your computing platform's architecture. "Square" or slightly flattened grids often perform better. Avoid using 1-by-Q and P-by-1 grids as they may lead to suboptimal performance. Consider the number of processors available and try to utilize them effectively.

Panel Factorization and Recursive Stopping Criteria:
Experiment with different panel factorization algorithms (PFACTs) and recursive stopping criteria (NBMINs and NDIVs). These parameters can significantly impact performance based on your system's characteristics. Common choices for PFACT are left-looking (0) and right-looking (2).

Broadcast Algorithm:
Choose an appropriate broadcast algorithm (BCAST) based on the network performance of your system. Options include increasing ring (1), spread-roll (long, 4), and combinations of both (mix, 2). The best choice depends on the system's communication characteristics.

Look-ahead Depth:
Experiment with the look-ahead depth (DEPTHs) to balance computation and communication. A depth of 0 means no look-ahead, while a depth of 1 performs look-ahead after each update. A depth of 1 is a common choice and often provides good results.

Swapping Algorithm:
Select the swapping algorithm (SWAP) based on the system's memory and performance. The long algorithm (1) can be more efficient for large problem sizes, while the binary-exchange algorithm (0) might be better for smaller ones.

Local Storage:
Choose between transposed (0) and non-transposed (1) forms for the panel of columns (L1) and the panel of rows (U). Often, the non-transposed form is preferred for better performance.

Equilibration:
Consider enabling equilibration (1) to balance the numerical values in the matrix and improve numerical stability. In most cases, this phase is beneficial, especially for random matrices.

Memory Alignment:
Set the memory alignment (memory alignment in double) to a value that is a multiple of your system's cache line size (e.g., 4, 8, 16). This can improve memory access efficiency.

Thresholds and Tuning:
Experiment with different thresholds and parameters to fine-tune the HPL performance for your specific system. This might involve running multiple trials with varying configurations to find the optimal combination.
