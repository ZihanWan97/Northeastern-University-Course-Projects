/* CSYE7105 HW1 Q3  */
/* Please parallelize this program with OpenMP */
/* Totals 18 points*/

#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

#define NRA 1600                 /* number of rows in matrix A */
#define NCA  800                 /* number of columns in matrix A */
#define NCB 1000                 /* number of columns in matrix B */

int main (int argc, char *argv[]) 
{
int	tid, nthreads, i, j, k, chunk;
double	a[NRA][NCA],           /* matrix A to be multiplied */
	b[NCA][NCB],               /* matrix B to be multiplied */
	c[NRA][NCB];               /* result matrix C */
	
chunk = 10;                    



/* Please set the follow block as parallel region;
   and consider the data scope.   */  
#pragma omp parallel shared(a,b,c,chunk) private(nthreads,tid,i,j,k)
  {
  tid = omp_get_thread_num();
  if (tid == 0)
    {
    nthreads = omp_get_num_threads();
    printf("Starting matrix multiple example with %d threads\n",nthreads);
    printf("Initializing matrices...\n");
    }

  for (i=0; i<NRA; i++)
    for (j=0; j<NCA; j++)
      a[i][j]= i+j;
  for (i=0; i<NCA; i++)
    for (j=0; j<NCB; j++)
      b[i][j]= i*j;
  for (i=0; i<NRA; i++)
    for (j=0; j<NCB; j++)
      c[i][j]= 0;

  printf("Thread %d starting matrix multiply...\n",tid); 

/* Set "static" scheduling for the work-sharing for-loop with the size of "chunk". */
  #pragma omp for schedule(static,chunk)
  for (i=0; i<NRA; i++)    
    {
    for(j=0; j<NCB; j++)       
      for (k=0; k<NCA; k++)
        c[i][j] += a[i][k] * b[k][j];
    }
  }   /*** End of parallel region ***/

printf("Done.\n"); 

}


