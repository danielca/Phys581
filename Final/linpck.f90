












      integer function isamax(n,sx,incx)
!  
!       finds the index of element having max. absolute value.
!  
      real:: sx(1),smax
      integer:: i,incx,ix,n
!  
      isamax = 0
      if( n .lt. 1 ) return
      isamax = 1
      if(n.eq.1)return
      if(incx.eq.1)go to 20
!  
!          code for increment not equal to 1
!  
      ix = 1
      smax = abs(sx(1))
      ix = ix + incx
      do 10 i = 2,n
         if(abs(sx(ix)).le.smax) go to 5
         isamax = i
         smax = abs(sx(ix))
    5    ix = ix + incx
   10 continue
      return
!  
!          code for increment equal to 1
!  
   20 smax = abs(sx(1))
      do 30 i = 2,n
         if(abs(sx(i)).le.smax) go to 30
         isamax = i
         smax = abs(sx(i))
   30 continue
      return
      end
!  
      integer function ismax(n,sx,incx)
!  
!       finds the index of element having max. value.
!  
      real:: sx(1),smax
      integer:: i,incx,ix,n
!  
      ismax = 0
      if( n .lt. 1 ) return
      ismax = 1
      if(n.eq.1)return
      if(incx.eq.1)go to 20
!  
!          code for increment not equal to 1
!  
      ix = 1
      smax = sx(1)
      ix = ix + incx
      do 10 i = 2,n
         if(sx(ix).le.smax) go to 5
         ismax = i
         smax = sx(ix)
    5    ix = ix + incx
   10 continue
      return
!  
!          code for increment equal to 1
!  
   20 smax = sx(1)
      do 30 i = 2,n
         if(sx(i).le.smax) go to 30
         ismax = i
         smax = sx(i)
   30 continue
      return
      end
      integer function ismin(n,sx,incx)
!  
!       finds the index of element having min. value.
!  
      real:: sx(1),smin
      integer:: i,incx,ix,n
!  ::
      ismin = 0
      if( n .lt. 1 ) return
      ismin = 1
      if(n.eq.1)return
      if(incx.eq.1)go to 20
!  
!          code for increment not equal to 1
!  
      ix = 1
      smin = sx(1)
      ix = ix + incx
      do 10 i = 2,n
         if(sx(ix).ge.smin) go to 5
         ismin = i
         smin = sx(ix)
    5    ix = ix + incx
   10 continue
      return
!  
!          code for increment equal to 1
!  
   20 smin = sx(1)
      do 30 i = 2,n
         if(sx(i).ge.smin) go to 30
         ismin = i
         smin = sx(i)
   30 continue
      return
      end
      subroutine  scopy(n,sx,incx,sy,incy)
!  
!       copies a vector, x, to a vector, y.
!  
      real:: sx(1),sy(1)
      integer:: i,incx,incy,ix,iy,m,mp1,n
!  
      if(n.le.0)return
      if(incx.eq.1.and.incy.eq.1)go to 20
!  
!          code for unequal increments or equal increments
!            not equal to 1
!  
      ix = 1
      iy = 1
      if(incx.lt.0)ix = (-n+1)*incx + 1
      if(incy.lt.0)iy = (-n+1)*incy + 1
      do 10 i = 1,n
        sy(iy) = sx(ix)
        ix = ix + incx
        iy = iy + incy
   10 continue
      return
!  
!          code for both increments equal to 1
!  
!  
!          clean-up loop
!  
   20 m = mod(n,7)
      if( m .eq. 0 ) go to 40
      do 30 i = 1,m
        sy(i) = sx(i)
   30 continue
      if( n .lt. 7 ) return
   40 mp1 = m + 1
      do 50 i = mp1,n,7
        sy(i) = sx(i)
        sy(i + 1) = sx(i + 1)
        sy(i + 2) = sx(i + 2)
        sy(i + 3) = sx(i + 3)
        sy(i + 4) = sx(i + 4)
        sy(i + 5) = sx(i + 5)
        sy(i + 6) = sx(i + 6)
   50 continue
      return
      end
      real function sdot(n,sx,incx,sy,incy)
!  
!       forms the dot product of two vectors.
!  
      real:: sx(1),sy(1),stemp
      integer:: i,incx,incy,ix,iy,m,mp1,n
!  
      stemp = 0.0e0
      sdot = 0.0e0
      if(n.le.0)return
      if(incx.eq.1.and.incy.eq.1)go to 20
!  
!          code for unequal increments or equal increments
!            not equal to 1
!  
      ix = 1
      iy = 1
      if(incx.lt.0)ix = (-n+1)*incx + 1
      if(incy.lt.0)iy = (-n+1)*incy + 1
      do 10 i = 1,n
        stemp = stemp + sx(ix)*sy(iy)
        ix = ix + incx
        iy = iy + incy
   10 continue
      sdot = stemp
      return
!  
!          code for both increments equal to 1
!  
!  
!          clean-up loop
!  
   20 m = mod(n,5)
      if( m .eq. 0 ) go to 40
      do 30 i = 1,m
        stemp = stemp + sx(i)*sy(i)
   30 continue
      if( n .lt. 5 ) go to 60
   40 mp1 = m + 1
      do 50 i = mp1,n,5
        stemp = stemp + sx(i)*sy(i) + sx(i + 1)*sy(i + 1) + &
        sx(i + 2)*sy(i + 2) + sx(i + 3)*sy(i + 3) + sx(i + 4)*sy(i + 4)
   50 continue
   60 sdot = stemp
      return
      end
      real function snrm2 ( n, sx, incx)
      integer::          next
      real ::  sx(1),  cutlo, cuthi, hitest, sum, xmax, zero, one
      data zero, one /0.0e0, 1.0e0/
!  
!       euclidean norm of the n-vector stored in sx() with storage
!       increment incx .
!       if    n .le. 0 return with result = 0.
!       if n .ge. 1 then incx must be .ge. 1
!  
!  
!       four phase method     using two built-in constants that are
!       hopefully applicable to all machines.
!           cutlo = maximum of  sqrt(u/eps)  over all known machines.
!           cuthi = minimum of  sqrt(v)      over all known machines.
!       where
!           eps = smallest no. such that eps + 1. .gt. 1.
!           u   = smallest positive no.   (underflow limit)
!           v   = largest  no.            (overflow  limit)
!  
!       brief outline of algorithm..
!  
!       phase 1    scans zero components.
!       move to phase 2 when a component is nonzero and .le. cutlo
!       move to phase 3 when a component is .gt. cutlo
!       move to phase 4 when a component is .ge. cuthi/m
!       where m = n for x() real and m = 2*n for complex.
!  
!       values for cutlo and cuthi..
!       from the environmental parameters listed in the imsl converter
!       document the limiting values are as follows..
!       cutlo, s.p.   u/eps = 2**(-102) for  honeywell.  close seconds are
!                     univac and dec at 2**(-103)
!                     thus cutlo = 2**(-51) = 4.44089e-16
!       cuthi, s.p.   v = 2**127 for univac, honeywell, and dec.
!                     thus cuthi = 2**(63.5) = 1.30438e19
!       cutlo, d.p.   u/eps = 2**(-67) for honeywell and dec.
!                     thus cutlo = 2**(-33.5) = 8.23181d-11
!       cuthi, d.p.   same as s.p.  cuthi = 1.30438d19
!       data cutlo, cuthi / 8.232d-11,  1.304d19 /
!       data cutlo, cuthi / 4.441e-16,  1.304e19 /
      data cutlo, cuthi / 4.441e-16,  1.304e19 /
!  
      if(n .gt. 0) go to 10
         snrm2  = zero
         go to 300
!  
   10 assign 30 to next
      sum = zero
      nn = n * incx
!                                                   begin main loop
      i = 1
   20    go to next,(30, 50, 70, 110)
   30 if( abs(sx(i)) .gt. cutlo) go to 85
      assign 50 to next
      xmax = zero
!  
!                          phase 1.  sum is zero
!  
   50 if( sx(i) .eq. zero) go to 200
      if( abs(sx(i)) .gt. cutlo) go to 85
!  
!                                  prepare for phase 2.
      assign 70 to next
      go to 105
!  
!                                  prepare for phase 4.
!  
  100 i = j
      assign 110 to next
      sum = (sum / sx(i)) / sx(i)
  105 xmax = abs(sx(i))
      go to 115
!  
!                     phase 2.  sum is small.
!                               scale to avoid destructive underflow.
!  
   70 if( abs(sx(i)) .gt. cutlo ) go to 75
!  
!                       common code for phases 2 and 4.
!                       in phase 4 sum is large.  scale to avoid overflow.
!  
  110 if( abs(sx(i)) .le. xmax ) go to 115
         sum = one + sum * (xmax / sx(i))**2
         xmax = abs(sx(i))
         go to 200
!  
  115 sum = sum + (sx(i)/xmax)**2
      go to 200
!  
!  
!                    prepare for phase 3.
!  
   75 sum = (sum * xmax) * xmax
!  
!  
!       for real or d.p. set hitest = cuthi/n
!       for complex      set hitest = cuthi/(2*n)
!  
   85 hitest = cuthi/float( n )
!  
!                     phase 3.  sum is mid-range.  no scaling.
!  
      do 95 j =i,nn,incx
      if(abs(sx(j)) .ge. hitest) go to 100
   95    sum = sum + sx(j)**2
      snrm2 = sqrt( sum )
      go to 300
!  
  200 continue
      i = i + incx
      if ( i .le. nn ) go to 20
!  
!                end of main loop.
!  
!                compute square root and adjust for scaling.
!  
      snrm2 = xmax * sqrt(sum)
  300 continue
      return
      end
      real function sasum(n,sx,incx)
!  
!       takes the sum of the absolute values.
!  
      real:: sx(1),stemp
      integer ::i,incx,m,mp1,n,nincx
!  
      sasum = 0.0e0
      stemp = 0.0e0
      if(n.le.0)return
      if(incx.eq.1)go to 20
!  
!          code for increment not equal to 1
!  
      nincx = n*incx
      do 10 i = 1,nincx,incx
        stemp = stemp + abs(sx(i))
   10 continue
      sasum = stemp
      return
!  
!          code for increment equal to 1
!  
!  
!          clean-up loop
!  
   20 m = mod(n,6)
      if( m .eq. 0 ) go to 40
      do 30 i = 1,m
        stemp = stemp + abs(sx(i))
   30 continue
      if( n .lt. 6 ) go to 60
   40 mp1 = m + 1
      do 50 i = mp1,n,6
        stemp = stemp + abs(sx(i)) + abs(sx(i + 1)) + abs(sx(i + 2)) &
       + abs(sx(i + 3)) + abs(sx(i + 4)) + abs(sx(i + 5))
   50 continue
   60 sasum = stemp
      return
      end
      subroutine saxpy(n,sa,sx,incx,sy,incy)
!  
!       constant times a vector plus a vector.
!  
      real:: sx(1),sy(1),sa
      integer:: i,incx,incy,ix,iy,m,mp1,n
!  
      if(n.le.0)return
      if (sa .eq. 0.0) return
      if(incx.eq.1.and.incy.eq.1)go to 20
!  
!          code for unequal increments or equal increments
!            not equal to 1
!  
      ix = 1
      iy = 1
      if(incx.lt.0)ix = (-n+1)*incx + 1
      if(incy.lt.0)iy = (-n+1)*incy + 1
      do 10 i = 1,n
        sy(iy) = sy(iy) + sa*sx(ix)
        ix = ix + incx
        iy = iy + incy
   10 continue
      return
!  
!          code for both increments equal to 1
!  
!  
!          clean-up loop
!  
   20 m = mod(n,4)
      if( m .eq. 0 ) go to 40
      do 30 i = 1,m
        sy(i) = sy(i) + sa*sx(i)
   30 continue
      if( n .lt. 4 ) return
   40 mp1 = m + 1
      do 50 i = mp1,n,4
        sy(i) = sy(i) + sa*sx(i)
        sy(i + 1) = sy(i + 1) + sa*sx(i + 1)
        sy(i + 2) = sy(i + 2) + sa*sx(i + 2)
        sy(i + 3) = sy(i + 3) + sa*sx(i + 3)
   50 continue
      return
      end
