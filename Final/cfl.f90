!=======================================================================

!///////////////////////// SUBROUTINE CFL  \\\\\\\\\\\\\\\\\\\\\\\\\\\

     subroutine cfl 
!
!  PURPOSE: Computes the new explicit timestep using the updated values 
!  of the field variables from the source and transport steps.
!  
!
!  courno is the courant/CFL number speicified in the input deck (i.e. input file)
!  

      implicit NONE
      INCLUDE "param.h"
      INCLUDE "gridparam.h"
      INCLUDE "variables.h"
      INCLUDE "root.h"
      INCLUDE "scratch.h"
      integer:: i,j,imax,imaxcs,imaxc,jmax,jmaxcs,jmaxc
      real::    dxmin2,dtcsmn,dtcmn, max_speedx, max_speedy
      real:: sound(in,jn) 
      
      external:: eos
!\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!=======================================================================
!
      call eos 

      !Calculate the sound speed at all zones:
      max_speedx = 0.0
      max_speedy = 0.0
      do j=js,je
        do i=ii(j),io(j)
          sound(i,j) = gamma*p(i,j)/d(i,j)
          if (v1(i,j) .ge. max_speedx) then
            max_speedx = v1(i,j)
          end if
          if (v2(i,j).ge. max_speedy) then
            max_speedy = v2(i,j)
          end if
        end do 
      end do 

      !-----------

      !TO DO: Implement CFL condition properly. 

      !-----------

      dt = 1E-3
      !dt = 0.5*(10000./((max_speedx + max_speedy)*100)

      return
      end
