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
      real::    dxmin2,dtcsmn,dtcmn
      real:: sound(in,jn)
      real:: vel(in,jn)
      real:: max_velocity
      
      external:: eos
!\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!=======================================================================

      call eos 

      !Calculate the sound speed at all zones:
      do j=js,je
        do i=ii(j),io(j)
          !sound(i,j) = gamma*p(i,j)/d(i,j)
          sound(i,j) = sqrt(gamma*p(i,j)/d(i,j))
          vel(i,j) = sqrt(v1(i,j)**2 + v2(i,j)**2)
        end do 
      end do 

      max_velocity = max(maxval(sound), maxval(vel))

      dt = courno*0.5/(sqrt(2.0)*max_velocity)

      !dt = 1E-3

      return
      end
