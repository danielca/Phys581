

















!  =======================================================================
!  /////////////////////////  SUBROUTINE NEWX1  \\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine newx1
!  
!    PURPOSE: Computes "new" x1 grid variables (grid variables at advanced
!    timestep) to be used in TRANSPRT.  Grid values are calculated for
!    i=is-2 to ie+2, except for dvl1a (i=is,ie+2) and dvl1b (i=is+1,ie+2).
!    Note similarity of the expressions used to those in the grid
!    generator routine GRIDI.
!  
!    EXTERNALS: [none]
!  
!    LOCALS:
!     vol1an,vol1bn = volume factors used to compute dvl1*n
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'scratch.h'
      INCLUDE 'root.h'

      integer:: i
      real ::   vol1an(in) ,  vol1bn(in), qa,qb,qc,qd,ppafc19(in)
      equivalence  (vol1an,wi0)  , (vol1bn,wi1)
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  =======================================================================
      x1an(is-2) = x1a(is-2) + vg1(is-2)*dt
      do 10 i=is-1,ie+2
         x1an(i  ) = x1a (i) + vg1(i)*dt
        dx1an(i-1) = x1an(i) - x1an(i-1)
10    continue
      dx1an(ie+2) = (dx1an(ie+1)/dx1an(ie)) * dx1an(ie+1)
!  
      dx1bn(is-2) = dx1an(is-2)
       x1bn(is-2) =  x1an(is-1) - 0.5*dx1an(is-2)
      do 20 i=is-1,ie+2
         x1bn(i) = x1an(i) + 0.5*dx1an(i)
        dx1bn(i) = x1bn(i) - x1bn(i-1)
20    continue
!  
      do 30 i=is-2,ie+2
        g2ah (i) = 1.0
        g2bh (i) = 1.0
        g31ah (i) = 1.0
        g31bh (i) = 1.0
        g2an (i) = 1.0
        g2bn (i) = 1.0
        g31an (i) = 1.0
        g31bn (i) = 1.0
30    continue
!  
!    New volume factors
!  
      vol1an(is-2) = g2an(is-2)*g31an(is-2)*x1an(is-2)
      do 40 i=is-2,ie+1
        vol1an(i+1) = g2an(i+1)*g31an(i+1)*x1an(i+1)
        dvl1an(i  ) = vfac*(vol1an(i+1) - vol1an(i))
40    continue
!  
      vol1bn(is-2) = g2bn(is-2)*g31bn(is-2)*x1bn(is-2)
      do 50 i=is-2,ie+1
        vol1bn(i+1) = g2bn(i+1)*g31bn(i+1)*x1bn(i+1)
        dvl1bn(i+1) = vfac*(vol1bn(i+1) - vol1bn(i))
50    continue
!  
!  
      return
      end
