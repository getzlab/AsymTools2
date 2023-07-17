/* map_mutations_to_targets_fast.c
   2014-10-25//Julian Hess, revised 2015-02-03

   Invocation: map_mutations_to_targets_fast(<loci matrix>, <target matrix>)
   where locus matrix is of the form
    <chr1> <pos1>
    <chr2> <pos2>
    ...
   and target matrix is of the form
    <chr1> <start1> <end1> 
    <chr2> <start2> <end2> 
    ...

   locus and target matrices must be sorted by chromosome and position

   returns -1 for mutations that map to no target
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mex.h"

#define L(r, c) c*llen + r
#define T(r, c) c*tlen + r

struct llroot {
   struct ll* last;
   struct ll* first;
   int l;
};

struct ll {
   struct ll* n;
   int tidx;
};

void append(struct llroot* x, int val) {
   struct ll* new = (struct ll*) malloc(sizeof(struct ll));
   new->n = 0;
   new->tidx = val;

   x->l++;
   if(x->first == 0) {
      x->first = new;
      x->last = new;
      return;
   }

   x->last->n = new;
   x->last = new;
}

/* print linked list */
void pr(struct ll* x) {
   printf("%d ", x->tidx);
   if(x->n != 0) pr(x->n);
}

/* convert linked list to array, 1-indexed */
double* smash(struct ll* x, int l) {
   double* out = (double*) malloc(sizeof(double)*l);
   int i = 0;
   for(i = 0; i < l; i++) {
      out[i] = x->tidx + 1;
      if(x->n == 0) break;
      x = x->n;
   }

   return out;
}

void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) {
   if(nrhs != 2)
      mexErrMsgTxt("Invocation: first_tidx = map_mutations_to_targets_fast(<locus matrix>, <target matrix>)\n            or\n            [tidx ntargets] = map_mutations_to_targets_fast(<locus matrix>, <target matrix>)");
   if(nlhs > 2)
      mexErrMsgTxt("Too many outputs!");

   int i, j, k;
   int ttot = 0;

   double* loci = mxGetPr(prhs[0]);
   double* targs = mxGetPr(prhs[1]);
   int llen = mxGetM(prhs[0]);
   int tlen = mxGetM(prhs[1]);

   if(mxGetN(prhs[0]) != 2)
      mexErrMsgTxt("Locus matrix must have two columns.");
   if(mxGetN(prhs[1]) != 3)
      mexErrMsgTxt("Target matrix must have three columns."); 

   struct llroot* roots = (struct llroot*) calloc(llen, sizeof(struct llroot));

   j = 0;
   for(i = 0; i < llen; i++) {
      k = 0;
      while((loci[L(i, 0)] > targs[T(j, 0)] || (loci[L(i, 1)] > targs[T(j, 2)] && 
	    loci[L(i, 0)] == targs[T(j, 0)])) && j < tlen - 1) j++;

      while(loci[L(i, 1)] >= targs[T(j + k, 1)] && loci[L(i, 1)] <= targs[T(j + k, 2)]
	    && loci[L(i, 0)] == targs[T(j + k, 0)]) {
	 append(&roots[i], j + k++);
      }
      ttot += roots[i].l;
   }

   if(nlhs < 2) {
      plhs[0] = mxCreateDoubleMatrix(llen, 1, mxREAL);
      double* out = mxGetPr(plhs[0]);
      for(i = 0; i < llen; i++) {
	 out[i] = (double) (roots[i].first ? roots[i].first->tidx + 1 : -1);
      }
   } else {
      plhs[0] = mxCreateDoubleMatrix(ttot, 1, mxREAL);
      plhs[1] = mxCreateDoubleMatrix(llen, 1, mxREAL);

      double* smashbuf;
      double* targs = mxGetPr(plhs[0]); /* concatenation of all smashed nodes */
      double* tidx = mxGetPr(plhs[1]); /* length of that node */

      j = 0;
      for(i = 0; i < llen; i++) {
	 int nt = roots[i].l;
	 smashbuf = smash(roots[i].first, nt);
	 memcpy(&targs[j], smashbuf, nt*sizeof(double));
	 j += nt;

	 tidx[i] = (double) nt;
      }
   }
   return;
} 
