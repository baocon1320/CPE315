#include <stdlib.h>
#include "matmul.h"

Matrix Allocate2ndMatrix(int height, int width, int init);

void matmul( float*, const float*, const float*, unsigned int, unsigned int, unsigned int);

////////////////////////////////////////////////////////////////////////////////
//! C = A * B
//! @param C          result matrix
//! @param A          matrix A 
//! @param B          matrix B
//! @param hA         height of matrix A
//! @param wB         width of matrix B
////////////////////////////////////////////////////////////////////////////////

/* You'll need to modify this function such that matrix B is accessed
 * correctly once you change the memory layout to column-major. */
void matmul(float* C, const float* A, const float* B, unsigned int hA, 
    unsigned int wA, unsigned int wB)
{
  int size = 16;
  for(unsigned int a = 0; a < hA; a += size)
  {
      unsigned int d = a + size;
     for(unsigned int b = 0; b < wB; b += size)
     {
        unsigned int e = b + size;
         //C[a * wB + b] = 0.0;
            for(unsigned int i = 0; i < hA; i++)
            {
               for(unsigned int j = a; j < d; j++)
               {
                  double sum = C[i * wB + j];
                  for(unsigned int k = b; k < e; k ++)
                  {  
                     double l = A[i * wA + k];
                     double m = B[j * wB + k];
                     sum += l * m;
                    // C[i * wB + j] += A[i * wA + k] * B[j * wB + k];
                  }
                  C[i * wB + j] = (float)sum;
               }

            }
     }
  }
  /*
  for (unsigned int i = 0; i < hA; ++i)
    for (unsigned int j = 0; j < wB; ++j) {
      double sum = 0;
      for (unsigned int k = 0; k < wA; ++k) {
        double a = A[i * wA + k];
        double b = B[j * wB + k];
        sum += a * b;
      }
      C[i * wB + j] = (float)sum;
    }
    */
}

// Allocate a matrix of dimensions height*width
Matrix Allocate2ndMatrix(int height, int width)
{
  Matrix M;
  M.width = M.pitch = width;
  M.height = height;
  int size = M.width * M.height;
  M.elements = NULL;

  M.elements = (float*) malloc(size*sizeof(float));

  /* This is a row-major allocation and initialization.
   * You need to modify this function which is only called
   * for Matrix B such that a column-major ordering is
   * performed. */
  for(unsigned int i = 0; i < M.height; i++)
  {
     for(unsigned int j = i; j < M.height * M.width; j+= M.height)
     {
         M.elements[j] = (rand() / (float)RAND_MAX);
     }
  }
  /*
  for(unsigned int i = 0; i < M.height * M.width; i++)
  {
    M.elements[i] = (rand() / (float)RAND_MAX);
  }
  */
  return M;
}	

