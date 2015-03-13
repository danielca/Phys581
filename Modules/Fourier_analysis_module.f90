module Fourier_analysis_module

    implicit none

    private
    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)


    public :: calc_dft, calc_idft, dft_2d, idft_2d
    public :: fft, ifft, fft_nr
    public :: calc_power, calc_phase
    public :: reorder_cmplx, reorder_real
    public :: window_rect, window_hanning, window_hamming
    public :: window_blackmann, window_blackhar

    interface calc_dft
        module procedure dft_real, dft_cmplx
    end interface

    interface fft
        module procedure fft_real, fft_cmplx
    end interface

    interface calc_power
        module procedure calc_power_real, calc_power_cmplx
    end interface

    interface calc_phase
        module procedure calc_phase_real, calc_phase_cmplx
    end interface



contains



subroutine dft_2d(dat, dft_dat)
    real(dp), dimension(:,:), intent(in) :: dat
    complex(dp), dimension(:,:), intent(out) :: dft_dat
    complex(dp) :: c1, c2
    integer :: num1, num2, n1, n2, k1, k2

    num1 = size(dat, 1)
    num2 = size(dat, 2)

    c1 = exp(cmplx(0.0d0, -2.0*pi/dble(num1)))
    c2 = exp(cmplx(0.0d0, -2.0*pi/dble(num2)))

    do k1 = 0, num1-1
        do k2 = 0, num2-1
            dft_dat(k1+1, k2+1) = 0.0
            do n1 = 0, num1-1
                do n2 = 0, num2-1
                    dft_dat(k1+1, k2+1) = dft_dat(k1+1, k2+1) + &
                                          dat(n1+1, n2+1)*(c1**(k1*n1))*(c2**(k2*n2))
                end do
            end do
        end do
    end do

end subroutine


subroutine idft_2d(dat, idft_dat)
    complex(dp), dimension(:,:), intent(in) :: dat
    complex(dp), dimension(:,:), intent(out) :: idft_dat
    complex(dp) :: c1, c2
    integer :: num1, num2, n1, n2, k1, k2

    num1 = size(dat, 1)
    num2 = size(dat, 2)

    c1 = exp(cmplx(0.0d0, 2.0*pi/dble(num1)))
    c2 = exp(cmplx(0.0d0, 2.0*pi/dble(num2)))

    do k1 = 0, num1-1
        do k2 = 0, num2-1
            idft_dat(k1+1, k2+1) = 0.0
            do n1 = 0, num1-1
                do n2 = 0, num2-1
                    idft_dat(k1+1, k2+1) = idft_dat(k1+1, k2+1) + &
                                           dat(n1+1, n2+1)*(c1**(k1*n1))*(c2**(k2*n2))
                end do
            end do
        end do
    end do

    idft_dat = idft_dat/dble(num1*num2)

end subroutine


subroutine dft_real(dat, dft_dat)
    real(dp), dimension(:), intent(in) :: dat
    complex(dp), dimension(:), intent(out) :: dft_dat

    call dft_cmplx(cmplx(dat, 0.0, kind = dp), dft_dat)

end subroutine


subroutine dft_cmplx(dat, dft_dat)
    complex(dp), dimension(:), intent(in) :: dat
    complex(dp), dimension(:), intent(out) :: dft_dat
    complex(dp) :: factor
    integer :: num, n, k, ind, min_k

    num = size(dat)

    if (num .ne. size(dft_dat)) then
        write(*,*) "ERROR in dft: size mismatch"
        write(*,*) "Terminating program."
        call exit()
    end if

    min_k = -nint(num/2.0 - 0.75)

    dft_dat = 0.0
    factor = exp(cmplx(0.0d0, -2.0*pi/dble(num)))
    do k = min_k, min_k + num - 1
        ind = k - min_k + 1
        do n = 0, num-1
            dft_dat(ind) = dft_dat(ind) + dat(n+1)*(factor**(k*n))
        end do
    end do

end subroutine


subroutine calc_idft(dat, idft_dat)
    complex(dp), dimension(:), intent(in) :: dat
    complex(dp), dimension(:), intent(out) :: idft_dat
    complex(dp) :: factor
    integer :: num, n, k, ind, min_k

    num = size(dat)

    if (num .ne. size(idft_dat)) then
        write(*,*) "ERROR in dft: size mismatch"
        write(*,*) "Terminating program."
        call exit()
    end if

    min_k = -nint(num/2.0 - 0.75)

    idft_dat = 0.0
    factor = exp(cmplx(0.0d0, 2.0*pi/dble(num)))
    do k = min_k, min_k + num - 1
        ind = k - min_k + 1
        do n = 0, num-1
            idft_dat(n+1) = idft_dat(n+1) + dat(ind)*(factor**(k*n))
        end do
    end do
    idft_dat = idft_dat/dble(num)

end subroutine


subroutine fft_cmplx(dat, del_t, freq, dft_dat)
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


subroutine calc_phase_cmplx(signal, phase)
    complex(dp), dimension(:), intent(in) :: signal
    real(dp), dimension(:), intent(out) :: phase

    phase = atan2(aimag(signal), real(signal))
end subroutine


subroutine window_rect(sig, win_sig)
    real(dp), intent(in), dimension(:) :: sig
    real(dp), intent(out), dimension(:) :: win_sig

    win_sig = sig

end subroutine


subroutine window_hanning(sig, win_sig)
    real(dp), intent(in), dimension(:) :: sig
    real(dp), intent(out), dimension(:) :: win_sig
    real(dp) :: factor
    integer :: num, i

    num = size(sig)

    factor = 2.0d0*pi/(num - 1.0d0)
    do i = 0, num - 1
        win_sig(i+1) = sig(i+1) * (0.5 - 0.5*cos(factor*i))
    end do

end subroutine


subroutine window_hamming(sig, win_sig)
    real(dp), intent(in), dimension(:) :: sig
    real(dp), intent(out), dimension(:) :: win_sig
    real(dp) :: factor
    integer :: num, i

    num = size(sig)

    factor = 2.0d0*pi/(num - 1.0d0)
    do i = 1, num
        win_sig(i) = sig(i) * (0.54 - 0.46*cos(factor*i))
    end do

end subroutine


subroutine window_blackmann(sig, win_sig)
    real(dp), intent(in), dimension(:) :: sig
    real(dp), intent(out), dimension(:) :: win_sig
    real(dp) :: win, factor1, factor2
    integer :: num, i

    num = size(sig)

    factor1 = 2.0d0*pi/(num - 1.0d0)
    factor2 = 4.0d0*pi/(num - 1.0d0)

    do i = 1, num
        win = 0.42d0
        win = win - 0.5d0*cos(factor1*i)
        win = win + 0.08d0*sin(factor2*i)

        win_sig(i) = sig(i) * win
    end do

end subroutine


subroutine window_blackhar(sig, win_sig)
    real(dp), intent(in), dimension(:) :: sig
    real(dp), intent(out), dimension(:) :: win_sig
    real(dp) :: win, factor1, factor2, factor3
    integer :: num, i

    num = size(sig)

    factor1 = 2.0d0*pi/(num - 1.0d0)
    factor2 = 4.0d0*pi/(num - 1.0d0)
    factor3 = 6.0d0*pi/(num - 1.0d0)

    do i = 1, num
        win = 0.35875d0
        win = win - 0.48829d0*cos(factor1*i)
        win = win + 0.14128d0*sin(factor2*i)
        win = win - 0.01168d0*sin(factor3*i)

        win_sig(i) = sig(i) * win
    end do

end subroutine

end module
