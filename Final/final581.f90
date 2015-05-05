

















!  =======================================================================
!  /////////////////////////  PHYS 581 FINAL  \\\\\\\\\\\\\\\\\\\\\\c
!  -----------------------------------------------------------------------
      implicit NONE
      INCLUDE 'param.h'
      INCLUDE 'gridparam.h'
      INCLUDE 'root.h'
      INCLUDE 'variables.h'

      real::     zcs, time_begin, time_end
      integer :: iswout,iswhst,iswusr
      external:: startrun,datadump,srcstep, &
              cfl,checkgrid,intchk,setobjects
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////////////////
!  =======================================================================
!  
      write(6,"(///10x,'PHYS 581 FINAL ')")
      write(6,"(///10x,'INSTRUCTOR: Prof. R. Ouyed ')")
      write(6,"()")
      write(6,"()")
      write(6,"(10x,'COMMUNICATION BETWEEN STUDENTS IS NOT ALLOWED')")
      write(6,"()")
      write(6,"(10x,'This code is solely intended for use in this final exam')")
      write(6,"(10x,'Distribution, copying or sharing of this code, or')")
      write(6,"(10x,'use for other purposes than this exam, is')")
      write(6,"(10x,'strictly prohibited.')")
      write(6,"()")

      call cpu_time(time_begin)

!  
!    Initialize problem and write first data dump
!  
      zcs    = 0.0
      iswout = 1
      iswhst = 1
      iswusr = 1
      call startrun
      call datadump(iswout,iswhst,iswusr)
      write(6,"(/,'Setup complete with ',i2,' warning(s):',' entering main loop...')") nwarn
!  
!  --------------------------  start of main loop  -----------------------
!    execution ends when INTCHK returns a value of 1 for ifsen
    
!  
1000  continue
        call updatev 
        call fluxes 
        call setobjects   !This is called every time step: allows for custom boundaries/geometries
        nhy = nhy + 1
        time  = time  + dt
        call intchk(iswout,iswhst,iswusr)
        iswout=0; iswhst=1; iswusr=1; 
        call datadump(iswout,iswhst,iswusr)
        if (ifsen .eq. 1) goto 2000
        call cfl 
        call checkgrid
      goto 1000
!  
!  --------------------------  end of main loop  -------------------------
!    terminate run by making final dumps, write goodbyes
!  
2000  continue
      call cpu_time(time_end)
      iswout = 1
      iswhst = 1
      iswusr = 1
      call datadump(iswout,iswhst,iswusr)
      tused = (time_end - time_begin)
      zcs = float(nhy*nx1z*nx2z)/tused
      write(6,"('Execution terminated with ',i4,' warning(s)')") nwarn
      write(6,"('Total run time in seconds =', 1f12.5)") tused
      write(6,"('zone-cycles per cpu second =',1e12.5)") zcs
      close(unit=2)
      close(unit=3)
      end
