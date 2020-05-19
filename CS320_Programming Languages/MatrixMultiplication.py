#  Program #3
#  This program calculates the product of two matrices
#  CS320
#  10/12/2019
#  @author Jaime Valero Solesio cssc0518
#
import sys
def main():
 print("Program #3, cssc0518, Jaime Valero Solesio")
 if(len(sys.argv) != 2):
  print("Usage: p3.py dataFileName")
  sys.exit()
 A = []
 B = []
 C = read_matrices(A,B)
 
 # Print Matrices and the result of the product

 print("Matrix A contents:")
 print_matrix(A)
 print("Matrix B contents:")
 print_matrix(B)
 mult_matrices(A,B,C)
 print("Matrix A * B contents:")
 print_matrix(C)

# Function to the read the matrices
 
def read_matrices(A,B):
  with open(str(sys.argv[1])) as f:
    m = [int(x) for x in next(f).split()][0] # read line
    n = [int(x) for x in next(f).split()][0] # read line
    p = [int(x) for x in next(f).split()][0] # read line
    for i in range(m):
      A.append([int(x) for x in next(f).split()])
    for i in range(n):
      B.append([int(x) for x in next(f).split()])
  f.close()
  C = [ [0 for i in range(p)] for j in range(m)]
  return C

# Function to print a matrix

def print_matrix(matrix):
  for row in matrix:
    for column in row:
      print("%3d"% (column), end = ' ')
    print("")

# Function to multiply the matrices

def mult_matrices(A,B,C):
  for i in range(len(A)):
    for j in range(len(B[0])):
      tmp = 0
      for k in range(len(B)):
        tmp += (A[i][k] * B[k][j])
      C[i][j] = tmp

if __name__ == '__main__':
  main()
