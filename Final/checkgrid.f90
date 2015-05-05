

















!  =======================================================================
!  ////////////////////////  SUBROUTINE CHECKGRID  \\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine checkgrid
!  
!    PURPOSE: Controls grid motion by computing grid velocities and "new"
!    grid variables (variables at advanced time, to be used in TRANSPRT).
!  
!    EXTERNALS: NEWVG
!               NEWX1
!               NEWX2
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'root.h'
      integer i,j
      external newvg,scopy,newx1,newx2
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  =======================================================================
!    return if there is no grid motion in either direction
!  
      if ((x1fac .eq. 0.0) .and. (x2fac .eq. 0.0)) return
!  
!    update grid velocities
!  
      call newvg
!  
!    update "X1" grid
!  
      if (x1fac .ne. 0.0) then
        call scopy (in,  x1an ,1,  x1a ,1)
        call scopy (in,  x1bn ,1,  x1b ,1)
        call scopy (in, dx1an ,1, dx1a ,1)
        call scopy (in, dx1bn ,1, dx1b ,1)
        call scopy (in, g2an ,1, g2a ,1)
        call scopy (in, g2bn ,1, g2b ,1)
        call scopy (in, g31an ,1, g31a ,1)
        call scopy (in, g31bn ,1, g31b ,1)
        call scopy (in,dvl1an ,1,dvl1a ,1)
        call scopy (in,dvl1bn ,1,dvl1b ,1)
        do 10 i=is-2,ie+2
          dx1ai(i) = 1.0/dx1a(i)
          dx1bi(i) = 1.0/dx1b(i)
10      continue
        call newx1
      end if
!  
!    update "X2" grid 
!  
      if (x2fac .ne. 0.0) then
        call scopy (jn,  x2an ,1,  x2a ,1)
        call scopy (jn,  x2bn ,1,  x2b ,1)
        call scopy (jn, dx2an ,1, dx2a ,1)
        call scopy (jn, dx2bn ,1, dx2b ,1)
        call scopy (jn, g32an ,1, g32a ,1)
        call scopy (jn, g32bn ,1, g32b ,1)
        call scopy (jn, g4an ,1, g4a ,1)
        call scopy (jn, g4bn ,1, g4b ,1)
        call scopy (jn,dvl2an ,1,dvl2a ,1)
        call scopy (jn,dvl2bn ,1,dvl2b ,1)
        do 20 j=js-2,je+2
          dx2ai(j) = 1.0/dx2a(j)
          dx2bi(j) = 1.0/dx2b(j)
20      continue
        call newx2
      end if
!  
      return
      end
