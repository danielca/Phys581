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

contains

subroutine white_noise()
    real(dp), dimension(8192) :: noise, auto_corr, dft
    real(dp), dimension(4096) :: spectrum, freq, phase
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
    end do

    call auto_correlation(noise, auto_corr)
    call fft_real(auto_corr(1:4096), 1.0d0, freq, spectrum, phase)

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
    call fft_real(auto_corr(1:4096), 1.0d0, freq, spectrum, phase)

    call linspace(freq, -pi, pi)

    do i = 1, num
        write(fid, *) i, abs(auto_corr(i))
    end do

    write(fid, *) ""
    write(fid, *) ""

    do i = 1, num_spec
        write(fid, *) freq(i), spectrum(i)
    end do


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

    call fft_clean(cmplx(sig, 0.0d0, kind = dp), 1.0/del_t, freq, sig_dft)
    call fft_clean(cmplx(noisy_sig, 0.0d0, kind = dp), 1.0/del_t, freq, noisy_sig_dft)

    noisy_sig_pow = 20.0*log10(abs(noisy_sig_dft))
    do i = 1, num
        if (noisy_sig_pow(i) < 25.0) then
            clean_sig_dft(i) = cmplx(1.0d-20, 1.0d-20)
        else
            clean_sig_dft(i) = noisy_sig_dft(i)
        end if
    end do

    call ifft_clean(noisy_sig_dft, 1.0/del_t, temp, noisy_sig_idft) 

    do i = 1, num
        write(fid, *) time(i), sig(i), noisy_sig(i), abs(clean_sig_idft(i))
        write(*,*) noisy_sig_idft(i)
    end do
    write(fid, *) ""
    write(fid, *) ""
    do i = 1, num
        write(fid, *) freq(i), sig_pow(i), noisy_sig_pow(i), 20.0*log10(abs(clean_sig_dft(i)))
    end do

    close(fid)
end subroutine

end program
