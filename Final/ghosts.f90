

















!c=======================================================================
!c/////////////////////////  SUBROUTINES GHOSTS  \\\\\\\\\\\\\\\\\\\\\\\\c
!c  PURPOSE: These routines set boundary values for all variables.
!c  For each variable **, there is a routine BVAL** contained below to
!c  compute boundary values.   
!c   
!  The routines are :
!  BVALD, BVALV1, BVALV2
!
!  Boundary values
!  are set for the first two zones beyond the boundary (except for ist)
!  to allow for 3rd order interpolation, e.g. for the iib, boundary
!  values are set for iim1(j) and iim2(j).  The corner zones
!  [(ii-1,ji-1),(io+1,ji-1), etc] are set across the ijb and the ojb.
!
!  EXTERNALS: [none]
!
!\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////
!
!  OUYED : Here the default boundaries for (d, v1, v2) are set to open
!
!      iim1, iim2, iop1, iop2, jim1, jim2, jop1, jop2.
!
!      For example, in the inner boundary we defime:
!
!      iim1   means inner i minus one OR (is -1)
!      iim2   means inner i minus two OR (is-2) 
!
!      There is one subroutine for each of the variables 
!
! OUYED :  DO NOT MODIFY THE CONTENT OF THIS FILE !
!          
!          USE AS A GUIDE TO SET THE LEFT BOUNARY (i.e. the two ghost
!          zones) IN SETOBJECTS.F90 
!
!=======================================================================
!---------------------  density boundary values  -----------------------
      subroutine bvald
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'bndry.h'
      integer::  i,j
      

      do 10 j=js,je
      d(iim1(j),j) = d(ii(j),j)     !Do for inner 
      d(iim2(j),j) = d(iim1(j),j)
      d(iop1(j),j) = d(io(j),j)
      d(iop2(j),j) = d(iop1(j),j)
10    continue
      do 20 i=is,ie
      d(i,jim1(i)) = d(i,ji  (i))
      d(i,jim2(i)) = d(i,jim1(i))
      d(i,jop1(i)) = d(i,jo  (i))
      d(i,jop2(i)) = d(i,jop1(i))
20    continue
      end
!
!-----------------------  velocity in 1-direction  ---------------------
!
      subroutine bvalv1
!
!  Note that the range of active zones for v1 is only i=iip1(j),io(j)
!  and j=ji(i),jo(i), so that the iib zones have different indices.
!  Also, the flow out boundary uses a switch to ensure fluid can only
!  flow OUT (boundary value set to 0 if it tries to flow in).
!
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'bndry.h'
      integer:: i,j

      do 10 j=js,je
      v1(ii(j),j)   = v1(iip1(j),j)
      v1(iim1(j),j) = v1(ii(j),j)
      v1(iop1(j),j) = v1(io(j),j)
      v1(iop2(j),j) = v1(iop1(j),j)
10    continue
      do 20 i=is,ie
      v1(i,jim1(i)) = v1(i,ji(i))
      v1(i,jim2(i)) = v1(i,jim1(i))
      v1(i,jop1(i)) = v1(i,jo(i))
      v1(i,jop2(i)) = v1(i,jop1(i))
20    continue

      end
!
!-----------------------  velocity in 2-direction ----------------------
!
      subroutine bvalv2
!
!  Note that the range of active zones for v2 is only i=ii(j),io(j)
!  and j=jip1(i),jo(i), so that the ijb zones have different indices.
!  Also, the flow out boundary uses a switch to ensure fluid can only
!  flow OUT (boundary value set to 0 if it tries to flow in).
!
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'bndry.h'
      integer::  i,j

      do 10 j=js,je
      v2(iim1(j),j) = v2(ii(j),j)
      v2(iim2(j),j) = v2(iim1(j),j)
      v2(iop1(j),j) = v2(io(j),j)
      v2(iop2(j),j) = v2(iop1(j),j)
10    continue
      do 20 i=is,ie
      v2(i,ji  (i)) = v2(i,jip1(i))
      v2(i,jim1(i)) = v2(i,ji(i))
      v2(i,jop1(i)) = v2(i,jo(i))
      v2(i,jop2(i)) = v2(i,jop1(i))
20    continue

      end
