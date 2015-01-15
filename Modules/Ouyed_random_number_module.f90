MODULE Ouyed_random_number_module
! A module for random number generation from the following distributions:
!
!     Distributions: Normal, Exponential, Beta, Cauchy
!
!  ***********************************************************************                                    
!  Note:
!   The Last 2 Subroutines in this module varies the seed for the uniforn RNGs
!   
!  ***********************************************************************  
!  Note:
! The compilers own random number generator, SUBROUTINE RANDOM_NUMBER(r),
! is used to provide a source of uniformly distributed random numbers.
!
!  ***********************************************************************
!  Note:
!  At this stage, only one random number is generated at each call to
!      one of the functions above.
!  ***********************************************************************
! 


IMPLICIT NONE
REAL, PRIVATE      :: zero = 0.0, half = 0.5, one = 1.0, two = 2.0,   &
                      vsmall = TINY(1.0), vlarge = HUGE(1.0)
INTEGER, PARAMETER :: dp = SELECTED_REAL_KIND(12, 60)


CONTAINS


FUNCTION random_normal() RESULT(fn_val)
!  The function random_normal() returns a normally distributed pseudo-random
!  number with zero mean and unit variance.

!  The algorithm uses the ratio of uniforms method of A.J. Kinderman
!  and J.F. Monahan augmented with quadratic bounding curves.

REAL :: fn_val

!     Local variables
REAL     :: s = 0.449871, t = -0.386595, a = 0.19600, b = 0.25472,    &
            r1 = 0.27597, r2 = 0.27846, u, v, x, y, q

!     Generate P = (u,v) uniform in rectangle enclosing acceptance region

DO
  CALL RANDOM_NUMBER(u)
  CALL RANDOM_NUMBER(v)
  v = 1.7156 * (v - half)

!     Evaluate the quadratic form
  x = u - s
  y = ABS(v) - t
  q = x**2 + y*(a*y - b*x)

!     Accept P if inside inner ellipse
  IF (q < r1) EXIT
!     Reject P if outside outer ellipse
  IF (q > r2) CYCLE
!     Reject P if outside acceptance region
  IF (v**2 < -4.0*LOG(u)*u**2) EXIT
END DO

!     Return ratio of P's coordinates as the normal deviate
fn_val = v/u
RETURN

END FUNCTION random_normal


FUNCTION random_exponential() RESULT(fn_val)
! FUNCTION GENERATES A RANDOM VARIATE IN [0,INFINITY) FROM
! A NEGATIVE EXPONENTIAL DISTRIBUTION WlTH DENSITY PROPORTIONAL
! TO EXP(-random_exponential), USING INVERSION.

REAL  :: fn_val

!     Local variable
REAL  :: r

DO
  CALL RANDOM_NUMBER(r)
  IF (r > zero) EXIT
END DO

fn_val = -LOG(r)
RETURN

END FUNCTION random_exponential



FUNCTION random_beta(aa, bb, first) RESULT(fn_val)
! FUNCTION GENERATES A RANDOM VARIATE IN [0,1]
! FROM A BETA DISTRIBUTION WITH DENSITY
! PROPORTIONAL TO BETA**(AA-1) * (1-BETA)**(BB-1).
! USING CHENG'S LOG LOGISTIC METHOD.

!     AA = SHAPE PARAMETER FROM DISTRIBUTION (0 < REAL)
!     BB = SHAPE PARAMETER FROM DISTRIBUTION (0 < REAL)

REAL, INTENT(IN)    :: aa, bb
LOGICAL, INTENT(IN) :: first
REAL                :: fn_val

!     Local variables
REAL, PARAMETER  :: aln4 = 1.3862944
REAL             :: a, b, g, r, s, x, y, z
REAL, SAVE       :: d, f, h, t, c
LOGICAL, SAVE    :: swap

IF (aa <= zero .OR. bb <= zero) THEN
  WRITE(*, *) 'IMPERMISSIBLE SHAPE PARAMETER VALUE(S)'
  STOP
END IF

IF (first) THEN                        ! Initialization, if necessary
  a = aa
  b = bb
  swap = b > a
  IF (swap) THEN
    g = b
    b = a
    a = g
  END IF
  d = a/b
  f = a+b
  IF (b > one) THEN
    h = SQRT((two*a*b - f)/(f - two))
    t = one
  ELSE
    h = b
    t = one/(one + (a/(vlarge*b))**b)
  END IF
  c = a+h
END IF

DO
  CALL RANDOM_NUMBER(r)
  CALL RANDOM_NUMBER(x)
  s = r*r*x
  IF (r < vsmall .OR. s <= zero) CYCLE
  IF (r < t) THEN
    x = LOG(r/(one - r))/h
    y = d*EXP(x)
    z = c*x + f*LOG((one + d)/(one + y)) - aln4
    IF (s - one > z) THEN
      IF (s - s*z > one) CYCLE
      IF (LOG(s) > z) CYCLE
    END IF
    fn_val = y/(one + y)
  ELSE
    IF (4.0*s > (one + one/d)**f) CYCLE
    fn_val = one
  END IF
  EXIT
END DO

IF (swap) fn_val = one - fn_val
RETURN
END FUNCTION random_beta




FUNCTION random_Cauchy() RESULT(fn_val)

!     Generate a random deviate from the standard Cauchy distribution

REAL     :: fn_val

!     Local variables
REAL     :: v(2)

DO
  CALL RANDOM_NUMBER(v)
  v = two*(v - half)
  IF (ABS(v(2)) < vsmall) CYCLE               ! Test for zero
  IF (v(1)**2 + v(2)**2 < one) EXIT
END DO
fn_val = v(1) / v(2)

RETURN
END FUNCTION random_Cauchy

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
!
!   2 subroutines to vary the seed: init_random_seed() and seed_random_number(iounit)
!
!   Try the first routine first
!
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




!
!  initialize random_see()
!
!   Usage:   call init_random_seed() [instead of call random_seed()]
!
subroutine init_random_seed()
            implicit none
            integer, allocatable :: seed(:)
            integer :: i, n, un, istat, dt(8), pid, t(2), s
            integer(8) :: count, tms
          
            call random_seed(size = n)
            allocate(seed(n))
            ! First try if the OS provides a random number generator
            open(newunit=un, file="/dev/urandom", access="stream", &
                 form="unformatted", action="read", status="old", iostat=istat)
            if (istat == 0) then
               read(un) seed
               close(un)
            else
               ! Fallback to XOR:ing the current time and pid. The PID is
               ! useful in case one launches multiple instances of the same
               ! program in parallel.
               call system_clock(count)
               if (count /= 0) then
                  t = transfer(count, t)
               else
                  call date_and_time(values=dt)
                  tms = (dt(1) - 1970) * 365_8 * 24 * 60 * 60 * 1000 &
                       + dt(2) * 31_8 * 24 * 60 * 60 * 1000 &
                       + dt(3) * 24 * 60 * 60 * 60 * 1000 &
                       + dt(5) * 60 * 60 * 1000 &
                       + dt(6) * 60 * 1000 + dt(7) * 1000 &
                       + dt(8)
                  t = transfer(tms, t)
               end if
               s = ieor(t(1), t(2))
               pid = getpid() + 1099279 ! Add a prime
               s = ieor(s, pid)
               if (n >= 3) then
                  seed(1) = t(1) + 36269
                  seed(2) = t(2) + 72551
                  seed(3) = pid
                  if (n > 3) then
                     seed(4:) = s + 37 * (/ (i, i = 0, n - 4) /)
                  end if
               else
                  seed = s + 37 * (/ (i, i = 0, n - 1 ) /)
               end if
            end if
            call random_seed(put=seed)
 end subroutine init_random_seed

SUBROUTINE seed_random_number(iounit)
! 
! This one initialized  (seed) of the uniform random number generator for ANY compiler
!                                     seed_random_number
!
INTEGER, INTENT(IN)  :: iounit

! Local variables

INTEGER              :: k
INTEGER, ALLOCATABLE :: seed(:)

CALL RANDOM_SEED(SIZE=k)
ALLOCATE( seed(k) )

WRITE(*, '(a, i2, a)')' Enter ', k, ' integers for random no. seeds: '
READ(*, *) seed
WRITE(iounit, '(a, (7i10))') ' Random no. seeds: ', seed
CALL RANDOM_SEED(PUT=seed)

DEALLOCATE( seed )

RETURN
END SUBROUTINE seed_random_number


END MODULE Ouyed_random_number_module 

