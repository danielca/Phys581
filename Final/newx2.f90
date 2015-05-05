

















!  =======================================================================
!  //////////////////////////  SUBROUTINE NEWX2  \\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine newx2
!  
!    PURPOSE: Computes "new" x2 grid variables (grid variables at advanced
!    time) to be used in TRANSPRT.  Grid values are calculated for 
!    j=js-2 to je+2, except for dvl2a (j=js,je+2) and dvl2b (j=js+1,je+2).
!    Note similarity of the expressions used to those in the grid
!    generator routine GRIDI.
!  
!    EXTERNALS: [none]
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'root.h'
      integer:: j
      real:: qa,qb,qc,qd,ppafc29(jn)
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////
!  =======================================================================
      x2an(js-2) = x1an(js-2) + vg2(js-2)*dt
      do 10 j=js-1,je+2
         x2an(j  ) = x2a (j) + vg2(j)*dt
        dx2an(j-1) = x2an(j) - x2an(j-1)
10    continue
      dx2an(je+2) = (dx2an(je+1)/dx2an(je))*dx2an(je+1)
!  
      dx2bn(js-2) = dx2an(js-2)
       x2bn(js-2) =  x2an(js-1) - 0.5*dx2an(js-2)
      do 20 j=js-1,je+2
         x2bn(j) = x2an(j) + 0.5*dx2an(j)
        dx2bn(j) = x2bn(j) - x2bn(j-1)
20    continue
!  
      do 30 j=js-2,je+2
        g32ah (j) = 1.0
        g32bh (j) = 1.0
        g4ah (j) = 0.5*(x2a(j) + x2an(j))
        g4bh (j) = 0.5*(x2b(j) + x2bn(j))
        g32an (j) = 1.0
        g32bn (j) = 1.0
        g4an (j) = x2an(j)
        g4bn (j) = x2bn(j)
30    continue
!  
!    New volume factors
!  
      do 40 j=js-2,je+1 
        dvl2ah(j  ) = g4ah(j+1) - g4ah(j)
        dvl2an(j  ) = g4an(j+1) - g4an(j)
40    continue
      do 50 j=js-2,je+1
        dvl2bh(j+1) = g4bh(j+1) - g4bh(j)
        dvl2bn(j+1) = g4bn(j+1) - g4bn(j)
50    continue
      return
      end
