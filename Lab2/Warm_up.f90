program Warm_up
    use Fourier_analysis_module

    implicit none
    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 3.14159265359

    real(dp), dimension(1024) :: time, freq
    complex(dp), dimension(4, 1024) :: dat, fft
    real(dp), dimensioN(4, 1024) :: power
    real(dp) :: sr
    integer :: i

    open( unit = 42, file = "./Data/Warm_up.txt", action = "write" )

    do i = 1, 1024
        time(i) = i/1024.0
        dat(1, i) = cmplx(sin(2*pi*100*time(i)) + 0.5*sin(2*pi*200*time(i)), 0.0d0)
        dat(2, i) = cmplx(sin(2*pi*100.5*time(i)) + 0.5*sin(2*pi*200*time(i)), 0.0d0)
        dat(3, i) = cmplx((2.0 + sin(2*pi*8*time(i)))*sin(2*pi*100*time(i)), 0.0d0)
        dat(4, i) = cmplx(sin(2*pi*200*(1.0 + 0.1*sin(2*pi*8*time(i)))*time(i)), 0.0d0)
    end do

    sr = 1.0/(time(2) - time(1))

    do i = 1, 4
        call fft_clean(dat(i, :), sr, fft(i, :), freq)
        power(i, :) = 10.0*log10(abs(fft(i, :))**2)
    end do

    do i = 1, 1024
        write(42, *) freq(i), power(1, i), power(2, i), power(3, i), power(4, i)
    end do

    close(42)

end program
