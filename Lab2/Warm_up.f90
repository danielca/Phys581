program Warm_up
    use Fourier_analysis_module

    implicit none
    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 3.14159265359

    call simple_test()
    call recording_fft()

contains

subroutine simple_test()
    real(dp), dimension(1024) :: time, freq, time_ifft
    real(dp), dimension(4, 1024) :: dat
    complex(dp), dimension(4, 1024) :: dat_fft, dat_ifft, dat_fft_old
    real(dp), dimension(4, 1024) :: power
    real(dp), dimension(1024) :: test, test1, test2
    real(dp) :: sr
    integer :: i

    open( unit = 42, file = "./Data/Warm_up.txt", action = "write" )

    do i = 1, 1024
        time(i) = (i-1)/1024.0
        dat(1, i) = sin(2*pi*100*time(i)) + 0.5*sin(2*pi*200*time(i))
        dat(2, i) = sin(2*pi*100.5*time(i)) + 0.5*sin(2*pi*200*time(i))
        dat(3, i) = (2.0 + sin(2*pi*8*time(i)))*sin(2*pi*100*time(i))
        dat(4, i) = sin(2*pi*100*(1.0 + time(i)*0.1*sin(2*pi*8*time(i)))*time(i))
        !dat(4, i) = sin(2*pi*200*time(i) + 5*sin(2*pi*8*time(i)))
    end do

    sr = 1.0/(time(2) - time(1))

    do i = 1, 4
        call fft(dat(i, :), time(2) - time(1), freq, dat_fft(i, :))
        call calc_power(dat_fft(i, :), power(i, :))
        call ifft(dat_fft(i, :), freq(2) - freq(1), time_ifft, dat_ifft(i, :))
    end do

    do i = 1, 1024
        write(42, *) freq(i), power(1, i), power(2, i), power(3, i), power(4, i)
    end do

    do i = 1, 1024
        !write(*,*) time(i), dat(1, i), time_ifft(i), dat_ifft(1, i)
    end do

    close(42)
end subroutine

subroutine recording_fft()
    integer :: fin, fout, num
    real(dp) :: del_t
    real(dp), dimension(1048576) :: time, real_dat, freq, power
    complex(dp), dimension(1048576) :: cmplx_dat, dft_dat 
    integer :: i

    fin = 42
    fout = 43
    open( unit = fin, file = "./Data/myself.dat", action = "read" )
    open( unit = fout, file = "./Data/myself-fft.dat", action = "write" )

    num = 655360
    del_t = 1.0/65536.0

    cmplx_dat = cmplx(0.0d0, 0.0d0)
    do i = 1, num
        read(fin, *) time(i), real_dat(i)
        cmplx_dat(i) = cmplx(real_dat(i), 0.0d0)
    end do

    call fft(cmplx_dat, del_t, freq, dft_dat)

    power = 10.0*log10(abs(dft_dat)**2)

    do i = 1, size(freq)
        write(fout,*) freq(i), power(i)
    end do

    write(*,*) "Max f = ", maxval(freq)

    close(fin)
    close(fout)
end subroutine

end program
