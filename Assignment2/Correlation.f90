program Correlation

    use Fourier_analysis_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0*atan(1.0)

    open( unit = 42, file = "./Data/Correlation.txt", action = "write")

    call power_spectrum(A = 10.0d-6, f = 60.000d0, num = 250, window = 1, fid = 42)
    call power_spectrum(A = 10.0d-6, f = 59.673d0, num = 250, window = 1, fid = 42)
    call hann_window(42)
    call power_spectrum(A = 10.0d-6, f = 60.000d0, num = 250, window = 2, fid = 42)
    call power_spectrum(A = 10.0d-6, f = 59.673d0, num = 250, window = 2, fid = 42)
    call power_spectrum(A = 10.0d-6, f = 60.000d0, num = 250, window = 3, fid = 42)
    call power_spectrum(A = 10.0d-6, f = 59.673d0, num = 250, window = 3, fid = 42)

    close(42)

contains

subroutine power_spectrum(A, f, num, window, fid)
    real(dp), intent(in) :: A, f
    integer, intent(in) :: num, window, fid
    real(dp), dimension(num) :: sig, win_sig
    complex(dp), dimension(num) :: dft
    real(dp), dimension(num) :: freq, time, power, mag_sqrd
    real(dp) :: dt, max_pow, hm_pow, fwhm_pow, tot_pow
    integer :: i

    dt = 1.0/250.0

    do i = 0, num - 1
        time(i+1) = i*dt
        sig(i+1) = A*sin(2.0*pi*f*time(i+1))

        freq(i+1) = i/(dt*num)
        if (freq(i+1) >= 0.5/dt) then
            freq(i+1) = freq(i+1) - 1.0/dt
        end if

    end do

    if (window == 1) then
        call window_rect(sig, win_sig)
    else if (window == 2) then
        call window_hanning(sig, win_sig)
    else
        call window_blackhar(sig, win_sig)
    end if

    call calc_dft(win_sig, dft)

    call reorder2_cmplx(dft)
    call reorder2_real(freq)

    call calc_power(dft, power)

    mag_sqrd = abs(dft)**2

    do i = 1, num
        write(fid, *) freq(i), power(i), time(i), sig(i)
    end do

    write(fid, *) ""
    write(fid, *) ""

    max_pow = maxval(mag_sqrd)
    fwhm_pow = 0.0
    tot_pow = 0.0
    do i = 1, num
        tot_pow = tot_pow + mag_sqrd(i)
        if (mag_sqrd(i) >= 0.5*max_pow) then
            fwhm_pow = fwhm_pow + mag_sqrd(i)
        end if
    end do

    write(*,*) ""
    write(*,*) "-------------------------------------------"
    write(*,*) "A =", A
    write(*,*) "f =", f
    write(*,*) "W =", window
    write(*,*) ""
    write(*,*) "Max. power =", 2.0*max_pow/dble(num)
    write(*,*) "FWHM power =", fwhm_pow/dble(num)
    write(*,*) "Tot. power =", tot_pow/dble(num)
    write(*,*) "-------------------------------------------"
    write(*,*) ""

end subroutine

subroutine hann_window(fid)
    integer, intent(in) :: fid
    integer, parameter :: num = 250
    real(dp), dimension(num) :: sig, win_sig, freq, time, power
    complex(dp), dimension(num) :: dft
    real(dp) :: dt
    integer :: i

    dt = 1.0/250.0

    sig = 1.0
    do i = 0, num - 1
        time(i+1) = i*dt

        freq(i+1) = i/(dt*num)
        if (freq(i+1) >= 0.5/dt) then
            freq(i+1) = freq(i+1) - 1.0/dt
        end if

    end do

    call window_hanning(sig, win_sig)

    call calc_dft(win_sig, dft)

    call reorder2_cmplx(dft)
    call reorder2_real(freq)

    call calc_power(dft, power)

    do i = 1, num
        write(fid, *) time(i), win_sig(i), freq(i), power(i)
    end do

    write(fid, *) ""
    write(fid, *) ""

end subroutine

subroutine reorder2_real(arr)
    real(dp), dimension(:), intent(inout) :: arr
    real(dp) :: temp
    integer :: num, i

    num = size(arr)

    do i = 1, num/2
        temp = arr(num/2 + i)
        arr(num/2 + i) = arr(i)
        arr(i) = temp
    end do

end subroutine


subroutine reorder2_cmplx(arr)
    complex(dp), dimension(:), intent(inout) :: arr
    complex(dp) :: temp
    integer :: num, i

    num = size(arr)

    do i = 1, num/2
        temp = arr(num/2 + i)
        arr(num/2 + i) = arr(i)
        arr(i) = temp
    end do

end subroutine



end program
