program Noise_and_FFT
    use Ouyed_random_number_module
    use Random_numbers_module
    use Fourier_analysis_module
    use Useful_stuff_module

    implicit none

    integer, parameter :: dp = kind(1.0d0)
    real(dp), parameter :: pi = 4.0d0*atan(1.0d0)

    call white_noise()
    call noise_reduction()
    call signal_with_trend()

contains

subroutine white_noise()
    real(dp), dimension(8192) :: noise, auto_corr, win, auto_corr_w, dft
    complex(dp), dimension(8192) :: auto_corr_dft
    real(dp), dimension(8192) :: freq, spectrum
    real(dp) :: rand
    integer :: num, num_spec, fid, i, j

    num = size(noise)
    num_spec = size(spectrum)

    open( unit = new_file_unit(fid), &
          file = "./Data/White_noise.txt", &
          action = "write" )

    call init_random_seed()

    do i = 1, num
        call random_number(rand)
        noise(i) = 2.0*(rand - 0.5)*sqrt(3.0)
        win(i) = 1.0 !0.54 - 0.46*cos(2*pi*(i-1)/(num - 1.0))
    end do

    call auto_correlation(noise, auto_corr)

    do i = 1, num
        auto_corr_w(i) = auto_corr(i)*win(i)
    end do

    call fft(auto_corr_w(1:num_spec), 1.0d0, freq, auto_corr_dft)

    call calc_power(auto_corr_dft, spectrum)

    call linspace(freq, -pi, pi)

    do i = 1, num
        write(fid, *) i, abs(auto_corr(i))
    end do

    write(fid, *) ""
    write(fid, *) ""

    do i = 1, num_spec
        write(fid, *) freq(i), spectrum(i)
    end do

    write(fid, *) ""
    write(fid, *) ""

    do i = 1, num
        noise(i) = random_normal()
    end do

    call auto_correlation(noise, auto_corr)
    call fft(auto_corr(1:num_spec), 1.0d0, freq, auto_corr_dft)

    call calc_power(auto_corr_dft, spectrum)

    call linspace(freq, -pi, pi)

    do i = 1, num
        write(fid, *) i, abs(auto_corr(i))
    end do

    write(fid, *) ""
    write(fid, *) ""

    do i = 1, num_spec
        write(fid, *) freq(i), spectrum(i)
    end do

    write(*,*) sum(auto_corr_dft)/real(size(spectrum))

    close(fid)

end subroutine

subroutine noise_reduction()
    real(dp), dimension(512) :: sig, noisy_sig, time, freq, temp
    complex(dp), dimension(512) :: sig_dft, noisy_sig_dft, clean_sig_dft
    real(dp), dimension(512) :: sig_pow, noisy_sig_pow, clean_sig_pow
    complex(dp), dimension(512) :: noisy_sig_idft, clean_sig_idft
    real(dp) :: del_t, f0, rand
    integer :: fid, num, i

    open( unit = new_file_unit(fid), &
          file = "./Data/Noise_reduction.txt", &
          action = "write" )

    num = size(sig)

    del_t = 22.2d-6
    f0 = 440.0

    call init_random_seed()

    do i = 1, num
        time(i) = (i-1)*del_t
        sig(i) = sin(2.0*pi*f0*time(i)) + 0.5*sin(4.0*pi*f0*time(i))
        call random_number(rand)
        noisy_sig(i) = sig(i) + rand - 0.5
    end do

    call fft(sig, del_t, freq, sig_dft)
    call fft(noisy_sig, del_t, freq, noisy_sig_dft)

    call calc_power(sig_dft, sig_pow)
    call calc_power(noisy_sig_dft, noisy_sig_pow)
    do i = 1, num
        if (noisy_sig_pow(i) < 25.0) then
            clean_sig_dft(i) = cmplx(1.0d-20, 1.0d-20)
        else
            clean_sig_dft(i) = noisy_sig_dft(i)
        end if
    end do

    call ifft(clean_sig_dft, freq(2) - freq(1), temp, clean_sig_idft) 

    do i = 1, num
        write(fid, *) time(i)*1d3, sig(i), noisy_sig(i), real(clean_sig_idft(i))
    end do
    write(fid, *) ""
    write(fid, *) ""
    do i = 1, num
        write(fid, *) freq(i)*1d-3, sig_pow(i), noisy_sig_pow(i), 20.0*log10(abs(clean_sig_dft(i)))
    end do

    close(fid)
end subroutine

subroutine signal_with_trend()
    real(dp), dimension(512) :: t, f, t_idft
    real(dp), dimension(512) :: x, x_pow, y, y_pow, g, yc_pow
    complex(dp), dimension(512) :: x_dft, y_dft, yc_dft, yc
    real(dp) :: f0, f1, df, dt, ran, crit_pow
    integer :: i, num, fid

    open(   unit = new_file_unit(fid), &
            file = "./Data/Signal_with_trend.txt", &
            action = "Write" )

    f0 = 9.0/512.0
    f1 = 4.0/512.0

    num = size(x)

    call init_random_seed()

    do i = 0, num-1
        t(i+1) = i
        g(i+1) = 1.0 + i*0.025
        x(i+1) = 2.0*sin(2.0*pi*f0*i) + cos(2.0*pi*f1*i) + g(i+1)
        call random_number(ran)
        y(i+1) = x(i+1) + (ran - 0.5)*12.0
    end do

    dt = t(2) - t(1)

    call fft(x, dt, f, x_dft)
    call fft(y, dt, f, y_dft)

    call calc_power(x_dft, x_pow)
    call calc_power(y_dft, y_pow)

    crit_pow = 20.0*log10(9.0) + 10.0*log10(512.0)
    do i = 1, num
        if (y_pow(i) < crit_pow) then
            yc_dft(i) = cmplx(0.0d-20, 0.0d-20)
        else
            yc_dft(i) = y_dft(i)
        end if
    end do

    call calc_power(yc_dft, yc_pow)

    df = f(2) - f(1)

    call ifft(yc_dft, df, t_idft, yc)

    do i = 1, num
        write(fid, *) t(i), x(i), y(i), real(yc(i))
    end do

    write(fid, *) ""
    write(fid, *) ""

    do i = 1, num
        write(fid, *) f(i), x_pow(i), y_pow(i), yc_pow(i), crit_pow
    end do

    write(fid, *) ""
    write(fid, *) ""

    do i = 0, num-1
        t(i+1) = i
        g(i+1) = 1.0 + i*0.025
        x(i+1) = 2.0*sin(2.0*pi*f0*i) + cos(2.0*pi*f1*i)
        call random_number(ran)
        y(i+1) = x(i+1) + (ran - 0.5)*12.0
    end do

    dt = t(2) - t(1)

    call fft(x, dt, f, x_dft)
    call fft(y, dt, f, y_dft)

    call calc_power(x_dft, x_pow)
    call calc_power(y_dft, y_pow)

    crit_pow = 20.0*log10(9.0) + 10.0*log10(512.0)
    do i = 1, num
        if (y_pow(i) < crit_pow) then
            yc_dft(i) = cmplx(0.0d-20, 0.0d-20)
        else
            yc_dft(i) = y_dft(i)
        end if
    end do

    call calc_power(yc_dft, yc_pow)

    df = f(2) - f(1)

    call ifft(yc_dft, df, t_idft, yc)

    yc = yc + g
    x = x + g
    y = y + g

    do i = 1, num
        write(fid, *) t(i), x(i), y(i), real(yc(i))
    end do

    write(fid, *) ""
    write(fid, *) ""

    do i = 1, num
        write(fid, *) f(i), x_pow(i), y_pow(i), yc_pow(i), crit_pow
    end do

    close(fid)

end subroutine

end program
