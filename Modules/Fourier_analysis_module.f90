module Fourier_analysis_module

    implicit none

    private
    integer, parameter :: dp = kind(1.0d0)

    public :: fft_clean, Hanning, Hamming, Blackman, BlackmanHarris

contains

subroutine fft_clean(dat, sp_rate, dft_dat, freq)
    complex(dp), dimension(:), intent(in) :: dat
    real(dp), intent(in) :: sp_rate
    complex(dp), dimension(:), intent(out) :: dft_dat
    real(dp), dimension(:), intent(out) :: freq
    real(dp), dimension(:), allocatable :: real_dat
    real(dp) :: factor, temp
    complex(dp) :: temp2
    integer :: num_dat, pow, nn, i, ip1, nn2, nn4

    num_dat = size(dat)

    pow = nint(log(1.0*size(dft_dat))/log(2.0))

    nn = 2**pow
    if (nn .ne. size(dft_dat)) then
        write(*,*) "ERROR in fft_clean: size(dft_dat) must be power of 2 "
        write(*,*) "Terminating program."
        call exit()
    end if
    if (size(dft_dat) .ne. size(freq)) then
        write(*,*) "ERROR in fft_clean: size mismatch"
        write(*,*) "Terminating program."
        call exit()
    end if
    if (nn < num_dat) then
        write(*,*) "ERROR in fft_clean: 2**pow must be > size(dat) "
        write(*,*) "Terminating program."
        call exit()
    end if

    allocate(real_dat(2*nn))

    real_dat = 0.0
    do i = 1, num_dat
        real_dat(2*i - 1) = real(dat(i))
        real_dat(2*i) = aimag(dat(i))
    end do

    call fft_nr(real_dat, nn, 1)

    do i = 1, nn
        dft_dat(i) = cmplx(real_dat(2*i-1), real_dat(2*i))
    end do

    factor = sp_rate/real(nn, kind=dp)

    nn2 = nn/2
    nn4 = nn/4

    do i = 1, nn2
        freq(i) = (i - 1)*factor
    end do
    do i = nn2 + 1, nn
        freq(i) = -(nn - i + 1)*factor
    end do

    ! Reorder the arrays so that the frequencies end up in order
    do i = 0, nn4-1
        ip1 = i + 1
        temp = freq(nn2 - i)
        freq(nn2 - i) = freq(ip1)
        freq(ip1) = temp

        temp = freq(nn - i)
        freq(nn - i) = freq(nn2 + ip1)
        freq(nn2 + ip1) = temp

        temp2 = dft_dat(nn2 - i)
        dft_dat(nn2 - i) = dft_dat(ip1)
        dft_dat(ip1) = temp2

        temp2 = dft_dat(nn - i)
        dft_dat(nn - i) = dft_dat(nn2 + ip1)
        dft_dat(nn2 + ip1) = temp2
    end do

    freq = - freq   ! Because numerical recipes defines positive frequency opposite to how most people define it

    deallocate(real_dat)

end subroutine

subroutine fft_nr(dat, nn, i_sign)
    integer i_sign, nn
    real(dp) dat(2*nn)
    ! Replaces dat(1:2*nn) by its discrete Fourier transform, if i_sign 
    ! is input as 1; or replaces dat(1:2*nn) by nn times its inverse 
    ! discrete Fourier transform, if isign is input as −1. dat is a complex 
    ! array of length nn or, equivalently, a real array of length 2*nn . 
    ! nn MUST be an integer power of 2 (this is not checked for!).
    integer i,istep,j,m,mmax,n
    real tempi,tempr
    real(dp) theta,wi,wpi,wpr,wr,wtemp ! for the trigonometric recurrences
    n=2*nn
    j=1
    do i=1, n, 2
        ! This is the bit-reversal section of the routine.
        if(j.gt.i)then
        tempr=dat(j)
        ! Exchange the two complex numbers.
        tempi=dat(j+1)
        dat(j)=dat(i)
        dat(j+1)=dat(i+1)
        dat(i)=tempr
        dat(i+1)=tempi
        endif
        m=n/2
        do while ((m.ge.2).and.(j.gt.m))
            j=j-m
            m=m/2
        end do
        j=j+m
    end do
    mmax=2
    !Here begins the Danielson-Lanczos section of the routine.
    do while (n.gt.mmax)
        ! Outer loop executed log 2 nn times.
        istep=2*mmax
        theta=6.28318530717959d0/(i_sign*mmax)
        ! Initialize for the trigonometric recurrence
        wpr=-2.d0*sin(0.5d0*theta)**2
        wpi=sin(theta)
        wr=1.d0
        wi=0.d0
        do m=1,mmax,2
            ! Here are the two nested inner loops.

            do i=m,n,istep
                j=i+mmax
                !This is the Danielson-Lanczos formula:
                tempr=sngl(wr)*dat(j)-sngl(wi)*dat(j+1)
                tempi=sngl(wr)*dat(j+1)+sngl(wi)*dat(j)
                dat(j)=dat(i)-tempr
                dat(j+1)=dat(i+1)-tempi
                dat(i)=dat(i)+tempr
                dat(i+1)=dat(i+1)+tempi
            enddo
            wtemp=wr    ! Trigonometric recurrence.
            wr=wr*wpr-wi*wpi+wr
            wi=wi*wpr+wtemp*wpi+wi
        enddo
        mmax=istep
    end do
    return
    end subroutine 

subroutine Hanning(Xin)
    real(kind=8), intent(inout), dimension(:)::Xin
    real(kind=8):: N, PI
    integer::i

    N = DBLE(size(Xin))
    PI = 3.14159

    do i=1,N
        Xin(i) = Xin(i) * (0.5 - 0.5*cos(2*PI*(DBLE(i)/N)))
    end do
end subroutine

subroutine Hamming(Xin)
    real(kind=8), intent(inout), dimension(:)::Xin
    real(kind=8):: N, PI
    integer::i

    N = DBLE(size(Xin))
    PI = 3.14159

    do i=1,N
        Xin(i) = Xin(i) * (0.54 - 0.46*cos(2*PI*(DBLE(i)/N)))
    end do
end subroutine

subroutine Blackman(Xin)
    real(kind=8), intent(inout), dimension(:)::Xin
    real(kind=8):: N, PI
    integer::i

    N = DBLE(size(Xin))
    PI = 3.14159

    do i=1,N
        Xin(i) = Xin(i) * (0.42 - 0.5*cos(2*PI*(DBLE(i)/N)) + 0.08*cos(4*PI*(DBL(i)/N)))
    end do
end subroutine

end module
