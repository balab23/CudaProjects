
#include<stdio.h>
#include<cuda.h>

__global__ void square (float * d_out, float * d_in)
{
  int idx=threadIdx.x;
  float f=d_in[idx];
  d_out[idx]=f*f;
}

int main(int argc, char ** argv)
{
  const int size=64;
  float h_in[64]; float * h_out[64];
  int i;
  const int bytes=64* sizeof(float);

  for(i=0;i<64;i++)
  {
    d_in[i]=float(i);
  }

  float * d_in;
  float * d_out;

  cudaMalloc((void **) & d_in, bytes);
  cudaMalloc((void **) & d_out, bytes);

  cudaMemcpy(d_in, h_in,bytes,cudaMemcpyHostToDevice);

  square<<<1, size>>>(d_out,d_in);

  cudaMemcpy(h_out,d_out,bytes,cudaMemcpyDeviceToHost);

  for(i=0;i<64;i++)
  {
    printf("%f ", h_out[i]);

  }

  cudaFree(d_in);
  cudaFree(d_out);

  return 0;
}
