module Fourier_analysis_module

    implicit none

    private
    integer, parameter :: dp = kind(1.0d0)

    public :: fft, ifft, fft_nr
    public :: calc_power, calc_phase
    public :: reorder_cmplx, reorder_real
    !public :: hanning, hamming, blackman, blackman_harris

    interface fft
        module procedure fft_complex, fft_real
    end interface

    interface calc_power
        module procedure calc_power_real, calc_power_cmplx
    end interface

    interface calc_phase
        module procedure calc_power_real, calc_power_cmplx
    end interface


contains



subroutine fft_complex(dat, del_t, freq, dft_dat)
    complex(dp), dimension(:), intent(in) :: dat
    real(dp), intent(in) :: del_t
    complex(dp), dimension(:), intent(out) :: dft_dat
    real(dp), dimension(:), intent(out) :: freq

    call fft_nr_cleanup(dat, del_t, freq, dft_dat, 1)

end subroutine


subroutine fft_real(dat, del_t, freq, dft_dat)
    real(dp), dimension(:), intent(in) :: dat
    real(dp), intent(in) :: del_t
    complex(dp), dimension(:), intent(out) :: dft_dat
    real(dp), dimension(:), intent(out) :: freq

    call fft_nr_cleanup(cmplx(dat, 0.0d0, kind = dp), del_t, freq, dft_dat, 1)

end subroutine


subroutine ifft(dat, del_f, time, idft_dat)
    complex(dp), dimension(:), intent(in) :: dat
    real(dp), intent(in) :: del_f
    complex(dp), dimension(:), intent(out) :: idft_dat
    real(dp), dimension(:), intent(out) :: time

    call fft_nr_cleanup(dat, del_f, time, idft_dat, -1)

    idft_dat = idft_dat / real(size(dat), kind = dp)

end subroutine

subroutine fft_nr_cleanup(dat, del_t, freq, dft_dat, i_sign)
    complex(dp), dimension(:), intent(in) :: dat
    real(dp), intent(in) :: del_t
    complex(dp), dimension(:), intent(out) :: dft_dat
    real(dp), dimension(:), intent(out) :: freq
    integer, intent(in) :: i_sign
    complex(dp), dimension(:), allocatable :: dat_temp
    real(dp), dimension(:), allocatable :: real_dat
    real(dp) :: factor, temp
    complex(dp) :: temp2
    integer :: num_dat, pow, nn, i, ip1, nn2, nn4

    num_dat = size(dat)

    pow = nint(log(1.0*size(dft_dat))/log(2.0))
    nn = 2**pow

    if (nn .ne. size(dft_dat)) then
        write(*,*) "ERROR in fft: size(dft_dat) must be power of 2 "
        write(*,*) "Terminating program."
        call exit()
    end if
    if (size(dft_dat) .ne. size(freq)) then
        write(*,*) "ERROR in fft: size mismatch"
        write(*,*) "Terminating program."
        call exit()
    end if
    if (num_dat .ne. size(dft_dat)) then
        write(*,*) "ERROR in fft: size mismatch"
        write(*,*) "Terminating program."
        call exit()
    end if
    if ((i_sign .ne. 1) .and. (i_sign .ne. -1)) then
        write(*,*) "ERROR in fft: i_sign must be +1 or -1"
        write(*,*) "Terminating program."
        call exit()
    end if

    allocate(real_dat(2*nn))
    allocate(dat_temp(nn))
    dat_temp = dat

    if (i_sign == -1) then
        call reorder_cmplx(dat_temp)
    end if

    real_dat = 0.0
    do i = 1, num_dat
        real_dat(2*i - 1) = real(dat_temp(i))
        real_dat(2*i) = aimag(dat_temp(i))
    end do

    call fft_nr(real_dat, nn, i_sign)

    do i = 1, nn
        dft_dat(i) = cmplx(real_dat(2*i-1), real_dat(2*i))
    end do

    factor = 1.0/(nn*del_t)

    nn2 = nn/2
    nn4 = nn/4

    if (i_sign == 1) then
        do i = 1, nn2
            freq(i) = (i - 1)*factor
        end do
        do i = nn2 + 1, nn
            freq(i) = -(nn - i + 1)*factor
        end do

        call reorder_real(freq)
        call reorder_cmplx(dft_dat)

        freq = - freq       ! NR defines pos/neg frequency opposite to most people
    else
        do i = 1, nn
            freq(i) = (i-1)*factor
        end do
    end if

    deallocate(real_dat)

end subroutine

subroutine reorder_real(arr)
    real(dp), dimension(:), intent(inout) :: arr
    real(dp) :: temp
    integer :: nn, nn2, nn4, ip1, i

    nn = size(arr)
    nn2 = nn/2
    nn4 = nn/4

    do i = 0, nn4-1
        ip1 = i + 1
        temp = arr(nn2 - i)
        arr(nn2 - i) = arr(ip1)
        arr(ip1) = temp

        temp = arr(nn - i)
        arr(nn - i) = arr(nn2 + ip1)
        arr(nn2 + ip1) = temp
    end do

end subroutine

subroutine reorder_cmplx(arr)
    complex(dp), dimension(:), intent(inout) :: arr
    complex(dp) :: temp
    integer :: nn, nn2, nn4, ip1, i

    nn = size(arr)
    nn2 = nn/2
    nn4 = nn/4

    do i = 0, nn4-1
        ip1 = i + 1
        temp = arr(nn2 - i)
        arr(nn2 - i) = arr(ip1)
        arr(ip1) = temp

        temp = arr(nn - i)
        arr(nn - i) = arr(nn2 + ip1)
        arr(nn2 + ip1) = temp
    end do

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

subroutine calc_power_real(signal, power)
    real(dp), dimension(:), intent(in) :: signal
    real(dp), dimension(:), intent(out) :: power

    power = 20.0*log10(abs(signal))
end subroutine

subroutine calc_power_cmplx(signal, power)
    complex(dp), dimension(:), intent(in) :: signal
    real(dp), dimension(:), intent(out) :: power

    power = 20.0*log10(abs(signal))
end subroutine

subroutine calc_phase_real(signal, phase)
    real(dp), dimension(:), intent(in) :: signal
    real(dp), dimension(:), intent(out) :: phase

    phase = atan2(0.0d0, signal)
end subroutine

subroutine calc_phase_complex(signal, phase)
    complex(dp), dimension(:), intent(in) :: signal
    real(dp), dimension(:), intent(out) :: phase

    phase = atan2(aimag(signal), real(signal))
end subroutine


!subroutine Hanning(Xin)
!    real(kind=8), intent(inout), dimension(:)::Xin
!    real(kind=8):: N, PI
!    integer::i
!
!    N = DBLE(size(Xin))
!    PI = 3.14159
!
!    do i=1,N
!        Xin(i) = Xin(i) * (0.5 - 0.5*cos(2*PI*(DBLE(i)/N)))
!    end do
!end subroutine
!
!subroutine Hamming(Xin)
!    real(kind=8), intent(inout), dimension(:)::Xin
!    real(kind=8):: N, PI
!    integer::i
!
!    N = DBLE(size(Xin))
!    PI = 3.14159
!
!    do i=1,N
!        Xin(i) = Xin(i) * (0.54 - 0.46*cos(2*PI*(DBLE(i)/N)))
!    end do
!end subroutine
!
!subroutine Blackman(Xin)
!    real(kind=8), intent(inout), dimension(:)::Xin
!    real(kind=8):: N, PI
!    integer::i
!
!    N = DBLE(size(Xin))
!    PI = 3.14159
!
!    do i=1,N
!        Xin(i) = Xin(i) * (0.42 - 0.5*cos(2*PI*(DBLE(i)/N)) + 0.08*cos(4*PI*(DBL(i)/N)))
!    end do
!end subroutine
!
end module
