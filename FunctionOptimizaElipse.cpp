#include "mex.h"
#include <stdio.h>
#include <math.h>

/* timestwo.c - example found in API guide
 *
 *Here the program to FIT BAYESSIAN SHAPE MODELS ON 3D
 */
/* $Revision: 10/05/2012 C_Arellano$ */

/* this is to define function to use later */
/*this is just an example*/
double add(double parameter1[3], double parameter2[3],double g[3])
{
	int i;
	for(i=0;i<3;i++)
		g[i]=parameter1[i]+parameter2[i];
	return 0;
}
/* declare some variables to use later*/
double matA [3][3];
double matB [3][3];
double sigmaA [3][3];
double sigmaB [3][3];
double V[3];
double U[3];
/*this is to multiply matrices*/
double mult(double a[3][3], double b[3][3],double C[3][3])
{ int i,j,k; double sum;
for (i=0; i<3; i++){
   for (j=0; j<3; j++)
     {
     sum = 0;
	 for (k=0; k<3; k++){
       sum = sum + a[i][k]*b[k][j];
     }
	 C[i][j] = sum;}
}
return 0;
}
/*this is to add matrices*/
double suma(double a[3][3], double b[3][3],double H[3][3])
{int i,j;
	for(i=0;i<3;i++){
	for(j=0;j<3;j++)
	{H[j][i]= a[j][i]+b[j][i];
	/*f=x[k];*/
	/*printf(" and its double is %f\n",i);*/
	/*printf(" and its double is %f\n",j);*/
	/*printf(" and its double is %f\n",f);*/
}
}
return 0;
}
/* function determinante */
double det(double M[3][3]) { 
	double final; 
	final=M[0][0]*(M[2][2]*M[1][1]-M[2][1]*M[1][2])-M[1][0]*(M[2][2]*M[0][1]-M[2][1]*M[0][2])+M[2][0]*(M[1][2]*M[0][1]-M[1][1]*M[0][2]); 
	return(final);}

/* to asigne matrix */
double asigna( double x[],int a, int D, double Y[3][3]) 
{int i,j,k,A,f;
A=a*D*D;
k=A;
for(i=0;i<3;i++){
	for(j=0;j<3;j++)
	{Y[j][i]= x[k];
	f=x[k];
	/*printf(" and its double is %f\n",i);*/
	/*printf(" and its double is %f\n",j);*/
	/*printf(" and its double is %f\n",f);*/
	k++;}
}
return 0;
}

/* this is to inverse a matrix */
double inv(double a[3][3],double H[3][3])
{ double De;
De=det(a);
H[0][0]=(1/De)*(a[2][2]*a[1][1]-a[2][1]*a[1][2]);
H[0][1]=-(1/De)*(a[2][2]*a[0][1]-a[2][1]*a[0][2]);
H[0][2]=(1/De)*(a[1][2]*a[0][1]-a[1][1]*a[0][2]);
H[1][0]=-(1/De)*(a[2][2]*a[1][0]-a[2][0]*a[1][2]);
H[1][1]=(1/De)*(a[2][2]*a[0][0]-a[2][0]*a[0][2]);
H[1][2]=-(1/De)*(a[1][2]*a[0][0]-a[1][0]*a[0][2]);
H[2][0]=(1/De)*(a[2][1]*a[1][0]-a[2][0]*a[1][1]);
H[2][1]=-(1/De)*(a[2][1]*a[0][0]-a[2][0]*a[0][1]);
H[2][2]=(1/De)*(a[1][1]*a[0][0]-a[1][0]*a[0][1]);
	/*f=x[k];*/
	/*printf(" and its double is %f\n",i);*/
	/*printf(" and its double is %f\n",j);*/
	/*printf(" and its double is %f\n",f);*/

return 0;
}

/* traspuesta de una matriz */
double Tmat(double a[3][3],double H[3][3])
{int i,j;
	for(i=0;i<3;i++){
	for(j=0;j<3;j++)
	{H[j][i]= a[i][j];
	/*f=x[k];*/
	/*printf(" and its double is %f\n",i);*/
	/*printf(" and its double is %f\n",j);*/
	/*printf(" and its double is %f\n",f);*/
}
}
return 0;
}
/* asigne vector POINT */
double Vect(double a[], int b,int D, double v[3])
{int k;
k=(b)*D;
v[0]=a[k];
v[1]=a[k+1];
v[2]=a[k+2];
	return 0;
}

/* asigne vector PC */
double VectPC(double a[], int b,int D, int d, double v[3])
{int k;
k=(b)*D+d;
v[0]=a[k];
v[1]=a[k+1];
v[2]=a[k+2];
	return 0;
}
/*multiplica vector by matrix */
double VxM(double a[],double b[3][3],double H[3])
{ int i,k; double sum;
for (i=0; i<3; i++){
     sum = 0;
	 for (k=0; k<3; k++){
       sum = sum + a[k]*b[k][i];
     }
	 H[i] = sum;
}
return 0;
}
/*multiplica  matrix by vector */
double MxV(double b[3][3],double a[3],double H[3])
{ int i,k; double sum,m;
for (i=0; i<3; i++){
     sum = 0;
	 for (k=0; k<3; k++){
       sum = sum + b[i][k]*a[k];
m=b[i][k];
     }
	 H[i] = sum;

}
return 0;
}
double VpV(double b[3],double a[3])
{ int k; double final;
     final = 0;
	 for (k=0; k<3; k++){
       final = final + b[k]*a[k];
     }
return final;
}

/* Funtion for the energy */
double En(double u[3], double Su[3][3],double invSu[3][3],double w1,double v[3], double Sv[3][3],double invSv[3][3],double w2,double invSc[3][3])
{double final,ar[3][3],uc1[3],uc2[3],Sc[3][3],q,ua[3],ub[3],uc[3],c;
/*to calculate the noralization*/
suma(Su,Sv,ar);
inv(invSc,Sc);
/*to compute q*/
MxV(invSu,u,ua);
MxV(invSv,v,ub);
add(ua,ub,uc1);
MxV(Sc,uc1,uc); 
/*to compute q*/
MxV(invSc,uc,uc2);
q=VpV(u,ua)+VpV(v,ub)-VpV(uc,uc2);
/*calculate constant before exponential*/
c=(w1*w2)/((pow((2*3.1416),1.5)*sqrt(det(ar))));
final=c*exp(-q/2);
/* printf(" and its double is %f\n",final);*/
return(final);
}
double VMV(double a[3],double b[3][3],double c[3])
{double final,tem1[3];
MxV(b,c,tem1);
final=VpV(a,tem1);
return(final);
}
double VMMMV(double a[3],double b1[3][3],double b2[3][3],double b3[3][3],double c[3])
{double final,temp1[3][3],temp2[3][3];
mult(b1,b2,temp1);
mult(temp1,b3,temp2);
final=VMV(a,temp2,c);
return(final);
}
/* to calculate the distance and disciminate the one to use*/
double dist(double a[3], double s[],int largo,double tolerance,int d[])
{int i,final,z;double distancia;
z=0;
for(i=0;i<largo;i++)
{
distancia=sqrt(pow(a[0]-s[i*3],2)+pow(a[1]-s[i*3+1],2)+pow(a[2]-s[i*3+2],2));

if(distancia < tolerance)
{
d[z]=i;
z=z+1;
}
}
final=z;

return(final);
}
/***********************************************************************************************/
/* THIS IS THE MAIN FUNCTION */

void FunctionOptimiza(double y[],double x1[], double x2[],double x3[], double x4[], double x5[],double x6[],int mrowsx1,int mrowsx4)
{ 
	
/***********************************************************************************************/
int i,k,m,n,newLong,close[100000]; /*variables*/
double sumE2,E2,u[3],V[3],w1,w2;
/* u:observation,V:newshape,r:averageshape,v's: eigenvectors */
double Sc[3][3],invSc[3][3],invSu[3][3],invSv[3][3],Su[3][3],Sv[3][3];


/*covariance marices*/
/***********************************************************************************************/
/*just to remember*/
/*double a11,a12,a13,a22,a21,a23,a31,a32,a33,b11,b12,b13,b21,b22,b23,b31,b32,b33;*/
/*printf(" and its double is %d\n",y1[2]);*/
/*examples of how to use them */
/* asigna(x2,3,3,matA); put the matrix in matA, 0 is the value I want (point) and 3 is the dimention */
/* mult(matA,matA,matB); multiply them and put it in matB */ 
/* inv(matA,matB); invert matA and put it in matB */
/*Tmat(matA,matB);*/
/* f=matB[1][2]; calculate the determinante */
/*	f=6;*/
 /*printf(" and its double is %f\n",f); */
/***********************************************************************************************/
 /*loop for MxN
 /***********************************************************************************************/
m=0;n=0;
sumE2=0;
E2=0;
/*k=model and i=observations*/
for(i=0;i<mrowsx1;i++){
Vect(x1,i,3,u);
w1=x3[i];
asigna(x2,i, 3, Su);
newLong=dist(u, x4,mrowsx4,100,close);
for(k=0;k<newLong;k++){
	    Vect(x4,close[k],3,V);
	/*asigning variables: vectors */
		w2=x6[close[k]];
		/*asigning variables: covariance matrices */
		asigna(x5,close[k], 3, Sv);
		/*compute teh inverses and Sc*/ 
		inv(Su,invSu);
		inv(Sv,invSv);
		suma(invSu,invSv,invSc);
		inv(invSc,Sc);
		/*compute energy for this points*/
		E2=En(u,Su,invSu,w1,V,Sv,invSv,w2,invSc);
		/*printf(" and its double is %f\n",w1);*/
		/*acumulate final energy*/
		sumE2=sumE2+E2;
		}
	}

y[0]=sumE2;
}


/***********************************************************************************************/
/* THIS IS THE MEXFUNCTION FOR READING VARIABLES FROM MATLAB */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[] )
{
 double *x1,*x2,*x3,*x4,*x5,*x6,*y;/*innputs are: the means,covariance and the weights*/
  /* the order inputs and dimention should be u(3,n),SigmaU(3,3,n),wigthU(1xn)*/
  /* the order inputs and dimention should be M(3,n),SigmaM(3,3,m),wigthM(1xm)*/
  /* x7 is shapepc, x8 is alfas (to calculate the dimention) and x9 is shapeMU
 /*to check values */
  /* I include x10 with the closest points vector */
  int mrowsx1,ncolsx1,mrowsx2,ncolsx2,mrowsx3,ncolsx3,mrowsx4,ncolsx4,mrowsx5,ncolsx5,mrowsx6,ncolsx6;
  /* Check for proper number of arguments. */
  if(nrhs!=6) {
    mexErrMsgTxt("sixinput required.");
  } else if(nlhs>1) {
    mexErrMsgTxt("Too many output arguments.");
  }
  
  /* The input must be a noncomplex scalar double.*/
  mrowsx1 = mxGetM(prhs[0]);
  ncolsx1 = mxGetN(prhs[0]);
    mrowsx2 = mxGetM(prhs[1]);
  ncolsx2 = mxGetN(prhs[1]);
    mrowsx3 = mxGetM(prhs[2]);
  ncolsx3 = mxGetN(prhs[2]);
    mrowsx4 = mxGetM(prhs[3]);
  ncolsx4 = mxGetN(prhs[3]);
    mrowsx5 = mxGetM(prhs[4]);
  ncolsx5 = mxGetN(prhs[4]);
    mrowsx6 = mxGetM(prhs[5]);
  ncolsx6 = mxGetN(prhs[5]);

   /* me end*/
  if( !mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
      !( mrowsx1==3) ) {
    mexErrMsgTxt("Input must be a noncomplex scalar double.");
  }
  /* me */
    if( !mxIsDouble(prhs[1]) || mxIsComplex(prhs[1]) ||
      !(mrowsx2==3) ) {
    mexErrMsgTxt("Input must be a noncomplex scalar double.");
  }
  x1 = mxGetPr(prhs[0]);
  x2 = mxGetPr(prhs[1]);
   x3 = mxGetPr(prhs[2]);
  x4 = mxGetPr(prhs[3]);
   x5 = mxGetPr(prhs[4]);
  x6 = mxGetPr(prhs[5]);

  /* Create matrix for the return argument. */
  plhs[0] = mxCreateDoubleMatrix(1,1, mxREAL);

  /* Assign pointers to each input and output. */

  y = mxGetPr(plhs[0]);

  /* Call the timestwo subroutine. */
FunctionOptimiza(y,x1,x2,x3,x4,x5,x6,ncolsx1,ncolsx4);
}
