**Review and Grade:**

Please practice the questions and prepare the answers well before you meet your TA.

TA will grade your homework based on how well you complete the operations on the Discovery.

 

Login Discovery, then please implement the following operations according to the requirements. When review, show the operations to your TA step by step.

```c++
srun -p debug --pty /bin/bash
```

1. Show the node list, time limit, state, and CPU numbers of the “debug” partition.           6 pts

```c++
sinfo -p debug -o "%P %N %l %t %c"
```



2. Tell the TA the meaning of the following codes of the job state and what you should do if it happens: **PD, R, S, CG**                         8 pts

```
PD (PENDING) :  Job is awaiting resource allocation.
R (RUNNING) : Job currently has an allocation.
S (SUSPENDED) : Job has an allocation, but execution has been suspended and CPUs have been released for other jobs.
CG (COMPLETING) : Job is in the process of completing. Some processes on some nodes may still be active
```



3. Show all pending jobs on the “debug” partition.           4 pts

```c++
squeue -p debug -t PD
```



```c++
exit
```



4. Show how to use **srun** to request one node and 4 tasks for 30 minutes with 16GB memory on the reservation “csye7105” partition.     5 pts

```c++
srun -p reservation --reservation=csye7105 --nodes=1 --ntasks=4 --mem=16Gb  --time=00:30:00 --pty /bin/bash
```



5. Use **squeue** to show the job information in the question 4, including the job_id and the node name which the job is working, and the job state.      5pts

```C++
squeue -p reservation --reservation=csye7105 -o "%i %N %t"
```



6. Show how to cancel the job in the question 4.            4 pts  

   ```c++
   scancel -u wan.zih
   ```

   

7. In your $HOME, create a new directory: *tmp7105*; then create a sub-directory: *homework1*        4 pts

 ```
cd $HOME
mkdir tmp7105
cd tmp7105
mkdir homework1
 ```



8. Show how to transfer (any) one file in your local machine to the cluster to your subdirectory you created in question 7.                4 pts

```c++
xfer.discovery.neu.edu
```



9. Load modules of anaconda3/2022.01 and cuda/11.4     4 pts

```c++
module load anaconda3/2022.01
module load cuda/11.4
```



10. Check available modules and loaded modules.            4 pts

```
module avail
module list
```



11. In HW1, the csye7105_ex2.c has been parallelized according to the requirements. On this compute node, implement the following operations:      8 pts

- - Compile the parallelized C program with OpenMP flag.

  - OpenMP parallel run the compiled file on 2 threads.

  - Show TA the current number of threads by using echo environmental variable.

  - Change the number of threads to 4 and run the compiled file again. 

    ```c++
    gcc -o csye7105_ex2 -fopenmp csye7105_ex2.c   
    srun -p debug --pty exit/bin/bash
    export OMP_NUM_THREADS=2
    ./csye7105_ex2
    echo $OMP_NUM_THREADS
    export OMP_NUM_THREADS=4
    ./csye7105_ex2
    ```



```
exit
cd $HOME
```



12. Show TA the list of all your Python environments and activate your customized Python environment and deactivate it.        8 pts

```c++
conda info -e
source activate py2022
conda deactivate
```



13. Copy the tarball *hpl-2.3.tar.gz* from /scratch/flyingsky2007 to your home directory; then extract the tarball using the command tar and flags.     6 pts

```c++
 cp /scratch/flyingsky2007/hpl-2.3.tar.gz /home/wan.zih
 tar -xf hpl-2.3.tar.gz
```



14. Write a sbatch script according to the following requirements:      30 pts

Note: write this script when the TA interviews you. You can write it in the cluster in vi or in your local machine then transfer it to the cluster.

```
(1) define the names of the job, output file and error file as hw2, hw2.out and hw2.err.

(2) request one compute node from the “csye7105” partition.

(3) request 4 tasks per node.

(4) request 4GB memory.

(5) define your work directory, and go to this work directory.

(6) set the number of threads to 4

(7) command to run your OpenMP-compiled file csye7105_ex2.

(8) load anaconda3/2022.01 module.

(9) command to run a python file (any).
```

```
nano hw2.bash


#!/bin/bash
#SBATCH --job-name=hw2
#SBATCH --output=hw2.out
#SBATCH --error=hw2.err
#SBATCH --partition=reservation
#SBATCH --reservation=csye7105
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem=4Gb
workdir=$HOME/tmp7105/homework1
cd workdir
export OMP_NUM_THREADS=4
./csye7105_ex2
module load anaconda3/2022.01
source activate py2022
./hw2.py
conda deactivate


sbatch hw2.bash
cat hw2.bash
```









