
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! PROGRAM P4
!             Traveling Salesman Problem in FORTRAN 95
!             Calculates the shortest route
!             CS320
!             Date: 10/28/2019
!             Author: Jaime Valero Solesio cssc0518         
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
PROGRAM P4

IMPLICIT NONE

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Variable declarations
INTEGER :: numCities,status,i,j, permutations,distance,minDist
!INTEGER :: tmp
INTEGER, DIMENSION (:), ALLOCATABLE :: path,bestpath 
INTEGER, DIMENSION (:,:), ALLOCATABLE :: cities
CHARACTER(len = 80), DIMENSION (:), ALLOCATABLE :: cityNames
CHARACTER(len = 80) :: filename,line
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!Open the file and read number of cities
status = 7
WRITE (*, '(1x,A)', ADVANCE="NO") "Enter filename:  "
READ *, filename
PRINT *, filename
OPEN( UNIT=9, FILE=filename, STATUS="OLD",ACTION="READ",IOSTAT=status)
IF(status /= 0) THEN
    PRINT *, "ERROR, could not open file for reading." 
    STOP
END IF
READ (UNIT = 9, FMT= *, IOSTAT=status) numCities

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Allocate memory for all needed arrays

ALLOCATE(cityNames(numCities))
ALLOCATE(cities(numCities,numCities))  
ALLOCATE(path(numCities))
ALLOCATE(bestpath(numCities))

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Fill in arrays from data file

DO  i=1, numCities
   READ (UNIT = 9, FMT = '(A)', IOSTAT=status) cityNames(i)
 DO j=1, numCities
   READ (UNIT = 9, FMT= *, IOSTAT=status) cities(i,j)
   path(j) = j
   bestpath(j) = j
 END DO
END DO
CLOSE(9)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Use recursion to find minimal distance
minDist = 999999
distance = 0
CALL permute(2,numCities)

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Print formatted output
DO i=1,numCities-1
 PRINT "(A,A,A,A,I3,A)",TRIM(cityNames(bestpath(i)))," to ", & 
       TRIM(cityNames(bestpath(i+1))) &
       ," -- ",cities(bestpath(i),bestpath(i+1))," miles"
END DO
PRINT "(A,A,A,A,I3,A)",TRIM(cityNames(bestpath(numCities))),&
      " to ",TRIM(cityNames(1)) &
       ," -- ",cities(bestpath(numCities),1)," miles"
PRINT *, ""
PRINT "(A,I5)","Best distance is: ", minDist
PRINT "(A,I4)", "Number of permutations: ", permutations               
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!Format labels
100 FORMAT (I6)
200 FORMAT (A)


CONTAINS
!Permute function
RECURSIVE SUBROUTINE permute(first,last)
   INTEGER,INTENT(IN) :: first,last
   INTEGER :: tmp, m, n
   IF (first == last) THEN
      ! Initialize distance from Home City(1) to path(2)
      distance = cities(path(1),path(2))
      DO m=2,last-1
         distance = distance + cities(path(m),path(m+1))
      END DO
      distance = distance + cities(path(last),path(1))
      permutations = permutations + 1
      IF (distance < minDist) THEN
         minDist = distance
         DO n=1,numCities
           bestpath(n) = path(n)
         END DO
      END IF 
   ELSE 
     DO m=first, last
        tmp = path(first)
        path(first) = path(m)
        path(m) = tmp
        !Recursion Reduction Step
        CALL permute(first + 1, last)
        tmp = path(first)
        path(first) = path(m)
        path(m) = tmp 
     END DO
   END IF
END SUBROUTINE permute        
END PROGRAM P4
