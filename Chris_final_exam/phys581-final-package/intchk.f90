

















!  =======================================================================
!  ///////////////////////////  SUBROUTINE INTCHK  \\\\\\\\\\\\\\\\\\\\\\c
      subroutine intchk(iswout,iswhst,iswusr)
!  
!    PURPOSE:  Reads the buffer for valid interrupt messages and takes
!      appropriate action. Also checks stopping criteria, and sets ifsen=1
!      if stop condition is detected.
!  
!    INPUT ARGUMENTS: none
!  
!    OUTPUT ARGUMENTS: iswout,iswhst,iswusr=switches for 
!    out, history, and USER dumps; set to 1 if dump to be made in DATADUMP
!  
!    EXTERNALS:  CHECKIN, BCDFLT, FINDNO, [ETIME,SECOND]
!  
!    LOCALS:
!  -----------------------------------------------------------------------
      implicit NONE
      include 'param.h'
      include 'root.h'
!  -----------------------------------------------------------------------
      integer :: iswout,iswhst,iswusr
!  
      integer :: i,nchar,istrt,iend
      real :: valnew
      character*80 ::msg
!  
!  RAF: Force some variables to be 4 bytes on machines whose default
!  RAF: word length is 4 bytes to allow for double precision
!  
      integer*4 ::checkin, icheckn
      real*4 :: tarray(2),etime,tusd4
      external ::etime
      external ::checkin,bcdflt,findno
!    List of valid interrupt messages
      character*3:: intmsg(14) 
      data intmsg /  'sto','?  ','pau','abo','tli','nli','dum' &
       ,'dtd','out','dtf','hst','dth','usr','dtu' /
!  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\////////////////////////////////
!  =======================================================================
!    Check stopping criteria
!  
!        tusd4 = etime(tarray)
      tused = 0.0
      if (tlim .gt. 0.0 .and. time .ge. tlim) then
        write(6,"(1x,'terminating on time limit',1x,'tlim=',1e12.5,'nlim=',i7,1x,'time=', 1e12.5,'  cycle=',i7,'  tused=',1e12.5)")   tlim,nlim,time,nhy,tused
        ifsen = 1
      endif
      if (nlim .gt. 0    .and. nhy .ge. nlim) then
        write(6,"(1x,'terminating on cycle limit', 1x,'tlim=',1e12.5,'nlim=',i7,  1x,'time=', 1e12.5,'cycle=',i7,'tused=',1e12.5)")   tlim,nlim,time,nhy,tused
        ifsen = 1
      endif
      if (ifsen .eq. 1) return
!  
!    Check for interrupt messages.  If none or illegal message found
!    then return
! !  
!       icheckn = 1
!       nchar = checkin(msg,icheckn)
!       if (nchar .eq. 0) return
!       do i=1,14
!         if (msg(1:3) .eq. intmsg(i)) goto 20
!       enddo
!     !  write(6,"(1x,a3,'is not an interrupt message. Legal messages ','are:',1x,'sto ? pau abo tli nli dum dtd out dtf hst dth usr',' dtu')") msg(1:3)
!       return
! 20    continue
! !  
! !    Legal interrupt message found, process it
! !  
! !    stop command
! !  
!       if (msg(1:3) .eq. 'sto') then
!         write(6,"(1x,a3,': execution stopped with', 1x,'tlim=',1pe12.5,'nlim=',i7,1x,'time=', 1e12.5,'cycle=',i7,'tused=',1e12.5)")   msg,tlim,nlim,time,nhy,tused
!         ifsen = 1
!         return
!       endif
! !  
! !    status command
! !  
!       if (msg(1:3) .eq. '?  ') then
!         write(6,"(1x,a3,': execution continuing with'1x,'tlim=',1pe12.5,'nlim=',i7,1x,'time=', 1e12.5,'cycle=',i7,'tused=',1e12.5)")   msg,tlim,nlim,time,nhy,tused
!         return
!       endif
! !  
! !    pause command
! !  
!       if (msg(1:3) .eq. 'pau') then
!       !  write(6,"(1x,a3,': execution halted with',1x,'tlim=',1pe12.5,'nlim=',i7,1x,'time=', 1e12.5,'cycle=',i7,'tused=',1e12.5,1x,'Hit any key to restart execution')")   msg,tlim,nlim,time,nhy,tused
! 	icheckn = 0
!         nchar = checkin(msg,icheckn)
!         return
!       endif
! !  
! !    abort command
! !  
!       if (msg(1:3) .eq. 'abo') then
!         write(6,"(a3,': ABORT! do you really want to abort execution?', ' (type yes or no)')") msg
! 	icheckn = 0
!         nchar = checkin(msg,icheckn)
!         if (nchar .eq. 0) return
!         if (msg(1:3) .ne. 'yes') then
!           write(6,"('Abort cancelled, continuing execution ...')")
!           return
!         else
!           write(6,"('ABORT.................')")
!           stop
!         endif
!       endif
! !  
! !    reset physical time limit (tlim) command
! !  
!       if (msg(1:3) .eq. 'tli') then
!         call findno(msg,istrt,iend)
!         if (istrt .lt. 0) then
!           write(6,2000) msg
!           return
!         endif
!         call bcdflt(msg,valnew,(istrt-1),(iend-istrt+1))
!         if (valnew .lt. 0.0 .or. valnew .ge. huge) then
!           write(6,2000) msg
! 2000      format(1x,a3,': could not read reset number; execution ', 'continuing')
!           return
!         endif
!         tlim = valnew
!         write(6,"(a3,': tlim reset to ',1pe12.5)") msg,tlim
!         return
!       endif
! !  
! !    reset cycle limit (nlim) command
! !  
!       if (msg(1:3) .eq. 'nli') then
!         call findno(msg,istrt,iend)
!         if (istrt .lt. 0) then
!           write(6,2000) msg
!           return
!         endif
!         call bcdflt(msg,valnew,(istrt-1),(iend-istrt+1))
!         if (valnew .lt. 0.0 .or. valnew .ge. huge) then
!           write(6,2000) msg
!           return
!         endif
!         nlim = nint(valnew)
!         write(6,"(a3,': nlim reset to ',i12)") msg,nlim
!       endif
! !  
! !    turn output dumps on
! !  
!       if (msg(1:3) .eq. 'out') then
!         write(6,"(a3,': output dump switch on')") msg
!         iswout = 1
!         return
!       endif
! !  
! !    reset output dump frequency (dtout) command
! !  
!       if (msg(1:3) .eq. 'dtf') then
!         call findno(msg,istrt,iend)
!         if (istrt .lt. 0) then
!           write(6,2000) msg
!           return
!         endif
!         call bcdflt(msg,valnew,(istrt-1),(iend-istrt+1))
!         if (valnew .lt. 0.0 .or. valnew .ge. huge) then
!           write(6,2000) msg
!           return
!         endif
!         dtout = valnew
!         write(6,"(a3,': dtout reset to ',1pe12.5)") msg,dtout
!       endif
! !  
! !    turn history dumps on
! !  
!       if (msg(1:3) .eq. 'hst') then
!         write(6,"(a3,': history dump switch on')") msg
!         iswhst = 1
!         return
!       endif
! !  
! !    turn USER dumps on
! !  
!       if (msg(1:3) .eq. 'usr') then
!         write(6,"(a3,': USER dump switch on')") msg
!         iswusr = 1
!         return
!       endif
! !  
!       return
      end
