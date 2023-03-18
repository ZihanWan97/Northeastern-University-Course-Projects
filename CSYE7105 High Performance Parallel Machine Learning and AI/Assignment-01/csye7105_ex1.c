/* CSYE7105 HW1 Q1  
   Please complete the data scope in the OpenMP parallel directive line
   Totals 7 points*/

#include <omp.h>
#define N 1000
#define N_THREADS 4

main () 
{
int tid, i, chunk;
double a[N], b[N], c[N];
		  
omp_set_num_threads(N_THREADS);		  
chunk = N/N_THREADS;


#pragma omp parallel shared(a,b,c,chunk) private(tid,i)
  {
  tid = omp_get_thread_num();
  for (i = tid * chunk; i < (tid+1) * chunk; i++)
    {
    c[i] = a[i] + b[i];
    }

  }  /* end of parallel section */   

}