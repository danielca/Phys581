

















!  =======================================================================
!  /////////////////////////  SUBROUTINE SETGRID \\\\\\\\\\\\\\\\\\\\\\\\\\c
      subroutine setgrid 
!  
!    PURPOSE:  Initializes the grid in a new run according to the control
!    parameters in the input deck namelists "xgrid" and ygrid".  All grid
!    variables are initialized, except the indices for the grid boundaries
!    (done in setup).
!  
!    EXTERNALS: CVMGT
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'variables.h'
      INCLUDE 'root.h'
      INCLUDE 'scratch.h'
      integer :: nbl,igrid,imin,imax,jmin,jmax,iter,i,j
      real  ::   x1min,x1max,dx1min &
             ,x2min,x2max,dx2min &
             ,vol1a(in),vol1b(in)
!  
      namelist /xgrid/ nbl,x1min,x1max
      namelist /ygrid/ nbl,x2min,x2max
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\//////////////////////////////////
!  =======================================================================
!  -----------  GENERATE X1 GRID  ----------------------------------------
!    Read in blocks of x1 grid zones.  Note we loop over read statement
!    until all blocks are read (signalled by reading in lgrid = .true.).
!    We can zone within each block completely independently of the others,
!    however we must ensure the starting position of one block (x1min) is
!    the same as the ending position (x1max) of the previous.
!     nbl    is number of active zones in block read in
!     x1min  is x1a(imin) ; bottom position of block
!     x1max  is x1a(imax) ; top    position of block
!     imax,imin  are indices of top and bottom of block
!  
      read (1,xgrid)
      write(2,xgrid)

      is=3
      ie = nbl + 3


      do 20 i=is-2,ie+2
        dx1a(i) = (x1max-x1min)/nbl
        dx1b(i) = dx1a(i) 
        x1a(i) = (i-is)*dx1a(i)
        x1b(i) = (i-is)*dx1b(i)+0.5*dx1a(i)
20    continue

!  
!    OUYED : You must here compute dx1a(i), dx1b(i), x1a(i), x1b(i)
!        Keep the below definitions. They are needed elsewhere in the code.
!  
      do 60 i=is-2,ie+2
        dx1ai(i) = 1.0 / dx1a(i)
        dx1bi(i) = 1.0 / dx1b(i)
         g2a(i) = 1.0
         g2b(i) = 1.0
         g31a(i) = 1.0
         g31b(i) = 1.0
        dg2ad1(i) = 0.0
        dg2bd1(i) = 0.0
        dg31ad1(i) = 0.0
        dg31bd1(i) = 0.0
60    continue
!  
!  -----------  X2 GRID GENERATOR  ---------------------------------------
!    Variable names and values are the same as used in x1 grid generator
!  
      read (1,ygrid)
      write(2,ygrid)
      
      js = 3
      je = nbl + 3


      do 30 j=js-2,je+2
        dx2a(j) = (x2max-x2min)/nbl 
        dx2b(j) = dx2a(j) 
        x2a(j) = (j-js)*dx2a(j)
        x2b(j) = (j-js)*dx2a(j)+0.5*dx2a(j)
30    continue

      
!  
!   OUYED : You must here set up dx2a(i), dx2b(i), x2a(i), x2b(i).
!        Keep the below definitions. They are needed elsewhere in the code.
!  

      do 160 j=js-2,je+2
        dx2ai(j) = 1.0 / dx2a(j)
        dx2bi(j) = 1.0 / dx2b(j)
        g32a (j) = 1.0
        g32b (j) = 1.0
        g4a (j) = x2a(j)
        g4b (j) = x2b(j)
       dg32ad2(j) = 0.0
       dg32bd2(j) = 0.0
160   continue
!  
!    OUYED : Keep all of the stuff below, it is also needed in the code
!  
!  
!    Volume factors used in integral form of difference equations, and in
!    transport module
!  
      vfac = 1.0
!  
      vol1a(is-2) = g2a(is-2)*g31a(is-2)*x1a(is-2)
      do 200 i=is-2,ie+1
        vol1a(i+1) = g2a(i+1)*g31a(i+1)*x1a(i+1)
        dvl1a(i  ) = vfac*(vol1a(i+1) - vol1a(i))
200   continue
!  
      vol1b(is-2) = g2b(is-2)*g31b(is-2)*x1b(is-2)
      do 210 i=is-2,ie+1
        vol1b(i+1) = g2b(i+1)*g31b(i+1)*x1b(i+1)
        dvl1b(i+1) = vfac*(vol1b(i+1) - vol1b(i))
210   continue
!  
      do 220 j=js-2,je+1
        dvl2a(j  ) = g4a(j+1) - g4a(j)
220   continue
      do 230 j=js-2,je+1
        dvl2b(j+1) = g4b(j+1) - g4b(j)
230   continue
!  

      return
      end
