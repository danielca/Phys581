

















!  =======================================================================
!  ////////////////////////  SUBROUTINE EOS   \\\\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine eos 
!  
!    eos means Equation Of State
!  
!    PURPOSE: Calculates the gas pressure at each zone centered point on
!    the grid.  
!  
!    EXTERNALS: [none]
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      integer ::  i,j
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  =======================================================================
!  
      do 20 j=js-2,je+2
        do 10 i=iim2(j),iop2(j)
          p(i,j) = d(i,j)**gamma
10      continue
20    continue
!  
      return
      end
