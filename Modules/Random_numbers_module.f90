module Random_numbers_module
    implicit none
    
    private

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)

    integer(iqp) :: lcm_seed, lcm_a, lcm_c, lcm_m
    
    public :: set_lcm_seed
    public :: set_lcm_params
    public :: lcm_random_number
    public :: nr_ran0, nr_ran1, nr_ran2, nr_ran3
    public :: AutoCorrelation, auto_correlation

contains

    subroutine set_lcm_seed(seed_val)
        integer(iqp), intent(in) :: seed_val
        lcm_seed = seed_val
    end subroutine

    subroutine set_lcm_params(a_val, c_val, m_val)
        integer(iqp), intent(in) :: a_val, c_val, m_val
        lcm_a = a_val
        lcm_c = c_val
        lcm_m = m_val
    end subroutine
    
    real(dp) function lcm_random_number()
        lcm_seed = mod(lcm_a*lcm_seed + lcm_c, lcm_m)
        lcm_random_number = lcm_seed/real(lcm_m, kind = dp)
    end function

    subroutine AutoCorrelation(x, k, AC)
        real(dp), dimension(:), intent(in) :: x
        integer, intent(in) :: k
        real(dp), intent(out) :: AC
        real(dp) :: xbar, denom, numerator
        integer :: i, limit
        
        denom = 0
        numerator = 0
        limit = size(x)-k

        xbar = sum(x)/size(x)
        
        do i = 1, limit
            numerator = numerator + ((x(i)-xbar)*(x(i+k)-xbar))
            denom = denom + ((x(i)-xbar)**2)
        enddo

        AC = numerator/denom

    end subroutine

    real(dp) function auto_correlation(x, k)
        real(dp), dimension(:), intent(in) :: x
        integer, intent(in) :: k
        real(dp) :: xbar, denom, numerator
        integer :: i, limit
        
        denom = 0
        numerator = 0
        limit = size(x)-k

        xbar = sum(x)/size(x)
        
        do i = 1, limit
            numerator = numerator + ((x(i)-xbar)*(x(i+k)-xbar))
            denom = denom + ((x(i)-xbar)**2)
        enddo

        auto_correlation = numerator/denom

    end function

    real(dp) function nr_ran0(idum)
        ! Numerical Recipes random number generator 0
        ! Minimal random number generator of Park and Miller.
        ! Returns a uniform random deviate between 0.0 and 1.0.
        ! Set of reset idum to any integer value (except mask) to initialize the sequence.
        ! idum must not be altered between calls for successive deviates in a sequence.
        integer(iqp) :: idum, a, m, q, r, mask, k
        real(dp) :: m_inv

        ! Set parameters
        a = 16087
        m = 2147483647
        m_inv = 1.0/m
        q = 127773
        r = 2836
        mask = 123459876

        ! XORing with mask allows use of zero and other simple bit patterns for idum
        idum = ieor(idum, mask)

        ! Compute seed=mod(a*idum,m) without overflows using Schrange's method
        k = idum/q
        idum = a*(idum - k*q) - r*k     
        if (idum < 0) idum = idum + m

        ! Convert seed to a floating result
        nr_ran0 = m_inv*idum
    end function

    real(dp) function nr_ran1(idum)
        ! Numerical Recipes random number generator 1
        ! "Minimal" random number generator of Park and Miller with Bays-Durham shuffle and added safeguards.
        ! Returns a uniform random deviate between 0.0 and 1.0 (exclusive of endpoint values)
        ! Call with idum a negative integer to initialize;
        ! Thereafter do not alter idum between successive deviates in a sequence.
        ! rnmx should approximate the larges floating value that is less than 1.
        integer(iqp) :: idum, ia, im, iq, ir, ntab, ndiv
        real(dp) :: am, eps, rnmx
        parameter(  ia = 16807,                 &
                    im = 2147483647,            &
                    am = 1.0/im,                &
                    iq = 127773,                &
                    ir = 2836,                  &
                    ntab = 32,                  &
                    ndiv = 1+(im-1)/ntab,       &
                    eps = 1.2e-7,               &
                    rnmx = 1.0-eps              )
        integer(iqp) :: j, k, iv(ntab), iy
        save iv, iy
        data iv /ntab*0/, iy /0/
        if (idum .le. 0 .or. iy .eq. 0) then      ! Initialize.
            idum = max(-idum,1)                   ! Be sure to prevent idum = 0.
            do j = ntab+8, 1, -1                  ! Load the shuffle table (after 8 warm-ups).
                k=idum/iq
                idum=ia*(idum-k*iq)-ir*k
                if (idum.lt.0) idum=idum+im
                if (j.le.ntab) iv(j)=idum
            end do
            iy=iv(1)
        endif
        k=idum/iq                       ! Start here when not initializing.
        idum=ia*(idum-k*iq)-ir*k        ! Compute idum=mod(ia*idum,im) without overflows by
        if (idum.lt.0) idum=idum+im     ! Schrage’s method.
        j=1+iy/ndiv                     ! Will be in the range 1:ntab.
        iy=iv(j)                        ! Output previously stored value and refill the shuffle table.
        iv(j)=idum
        nr_ran1=min(am*iy,rnmx)            ! Because users don’t expect endpoint values.
        return
    end function

    real(dp) function nr_ran2(idum)
        ! Numerical Recipes random number generator 2
        ! Long period (> 2 × 10 18 ) random number generator of L’Ecuyer with Bays-Durham shuffle and added safeguards. 
        ! Returns a uniform random deviate between 0.0 and 1.0 (exclusive of the endpoint values). 
        ! Call with seed a negative integer to initialize; 
        ! thereafter, do not alter idum between successive deviates in a sequence. 
        ! RNMX should approximate the largest floating value that is less than 1.
        integer(iqp) :: idum, im1, im2, imm1, ia1, ia2, iq1, iq2, ir1, ir2, ntab, ndiv
        real(dp) :: ran2, am, eps, rnmx
        parameter ( im1  = 2147483563,         &
                    im2  = 2147483399,         &
                    am   = 1./im1,             &
                    imm1 = im1-1,              &
                    ia1  = 40014,              &
                    ia2  = 40692,              &
                    iq1  = 53668,              &
                    iq2  = 52774,              &
                    ir1  = 12211,              &
                    ir2  = 3791,               &
                    ntab = 32,                 &
                    ndiv = 1+imm1/ntab,        &
                    eps  = 1.2e-7,             &
                    rnmx = 1.-eps              )
        integer idum2, j, k, iv(ntab), iy
        save iv, iy, idum2
        data idum2/123456789/, iv/ntab*0/, iy/0/
        if (idum.le.0) then             ! Initialize.
            idum=max(-idum,1)           ! Be sure to prevent idum = 0.
            idum2=idum
            do j=ntab+8,1,-1            ! Load the shuffle table (after 8 warm-ups).
                k=idum/iq1
                idum=ia1*(idum-k*iq1)-k*ir1
                if (idum.lt.0) idum=idum+im1
                if (j.le.ntab) iv(j)=idum
            end do
        iy=iv(1)
        endif
        k=idum/iq1                          ! Start here when not initializing
        idum=ia1*(idum-k*iq1)-k*ir1         ! Schrage's method for idum = mod(ia1*idum, im1)
        if (idum.lt.0) idum=idum+im1
        k=idum2/iq2
        idum2=ia2*(idum2-k*iq2)-k*ir2       ! Schrage's method for idum2 = mod(ia2*idum2, im2)
        if (idum2.lt.0) idum2=idum2+im2
        j=1+iy/ndiv                         ! Will be in the range 1:ntab
        iy=iv(j)-idum2                      ! Here idum is shuffled, idum and idum2 are combined to generate output
        iv(j)=idum                          
        if(iy.lt.1)iy=iy+imm1
        nr_ran2=min(am*iy,rnmx)                ! Because users don't expect endpoint values
        return
    end function

    real(dp) function nr_ran3(idum)
        ! Returns a uniform random deviate between 0.0 and 1.0. 
        ! Set idum to any negative value to initialize or reinitialize the sequence.
        integer(iqp) idum
        integer(iqp) mbig,mseed,mz
        ! real mbig,mseed,mz
        real(dp) fac
        parameter (mbig=1000000000,mseed=161803398,mz=0,fac=1./mbig)
        ! parameter (mbig=4000000.,mseed=1618033.,mz=0.,fac=1./mbig)
        ! According to knuth, any large mbig , and any smaller (but still large) mseed can be substituted for the above values.
        integer(iqp) i,iff,ii,inext,inextp,k
        integer(iqp) mj,mk,ma(55)        ! The value 55 is special and should not be modified (see Knuth)
        ! real mj,mk,ma(55)
        save iff,inext,inextp,ma
        data iff /0/
        if(idum.lt.0.or.iff.eq.0)then   ! Initialization
            iff=1
            mj=abs(mseed-abs(idum))     ! Initialize ma(55) using the seed idum and the large number mseed
            mj=mod(mj,mbig)
            ma(55)=mj
            mk=1
            do i=1,54                   ! Now initialize the rest of the table,
                ii=mod(21*i,55)         ! in a slightly random order,
                ma(ii)=mk               ! with numbers that are not especially random
                mk=mj-mk
                if(mk.lt.mz)mk=mk+mbig
                mj=ma(ii)
            end do
            do k=1,4                    ! We randomize by "warming up the generator"
                do i=1,55
                    ma(i)=ma(i)-ma(1+mod(i+30,55))
                    if(ma(i).lt.mz)ma(i)=ma(i)+mbig
                end do
            end do
            inext = 0                   ! Prepare indices for our first generated number.
            inextp = 31                 ! The constant 31 is special (see Knuth)
            idum = 1
        end if
        inext = inext + 1               ! Here is where we start, except on initialization.
        if (inext == 56) inext = 1      ! In inext, wrapping around 56 to 1.
        inextp = inextp + 1             ! Ditto for inextp.
        if (inextp == 56) inextp = 1
        mj=ma(inext)-ma(inextp)         ! Now generate a new random number subtractively.
        if(mj.lt.MZ)mj=mj+MBIG          ! Be sure that it is in range.
        ma(inext)=mj                    ! Store it,
        nr_ran3=mj*FAC                     ! and output the derived uniform deviate.
        return
    end function

end module

