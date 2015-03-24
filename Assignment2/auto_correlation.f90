program correlation
use Fourier_analysis_module
use Random_numbers_module
use Ouyed_random_number_module
implicit none
real(kind=8), dimension(:), allocatable::signal
real(kind=8)::rand_num, PI, dt, a
integer::i,sample_max

call init_random_seed()
PI = 3.14159265359
sample_max = 2048
dt = (2.*PI)/dble(sample_max)
allocate(signal(sample_max))

do i=1,sample_max
    signal(i) = signal_func(dble(i)*dt)
end do


open(unit=42, file="./Data/signal_noiseless.txt")
call processSignal(42,sample_max,signal)
close(42)


!EVERYBODY MAKE SOME NOISE
a=0.1
do i=1, sample_max
    call random_number(rand_num)
    signal(i) = signal_func(dble(i)*dt) + a*(rand_num-1)
end do
open(unit=44,file="./Data/signal_a01.txt")
call processSignal(44,sample_max,signal)
close(44)

a=1.0
do i=1, sample_max
    call random_number(rand_num)
    signal(i) = signal_func(dble(i)*dt) + a*(rand_num-1)
end do
open(unit=46,file="./Data/signal_a1.txt")
call processSignal(46,sample_max,signal)
close(46)


a=10.0
do i=1, sample_max
    call random_number(rand_num)
    signal(i) = signal_func(dble(i)*dt) + a*(rand_num-1)
end do
open(unit=48,file="./Data/signal_a10.txt")
call processSignal(48,sample_max,signal)
close(48)



deallocate(signal)


contains


subroutine processSignal(file1,sample_max, signal)
    real(kind=8), dimension(:), intent(in)::signal
    integer, intent(in)::file1, sample_max
    real(kind=8), dimension(:), allocatable::ac, power, ac_power, freq, ac_freq
    complex(kind=8), dimension(:), allocatable::ac_fft, fft_dat
    integer::i

    allocate(ac(sample_max))
    allocate(freq(sample_max), ac_freq(sample_max))
    allocate(power(sample_max), ac_power(sample_max))
    allocate(fft_dat(sample_max), ac_fft(sample_max))

    

    call fft(signal, dt, freq, fft_dat)
    call calc_power(fft_dat, power)
    


    call auto_correlation(signal, ac)

    call fft(ac, dt, ac_freq, ac_fft)
    call calc_power(ac_fft, ac_power)
    
    do i=1,size(freq)
        write(file1,*) i, signal(i), freq(i), power(i), ac_power(i)/2.0, ac(i)
    end do

    deallocate(ac)
    deallocate(freq)
    deallocate(ac_freq)
    deallocate(power)
    deallocate(ac_power)
    deallocate(fft_dat)
    deallocate(ac_fft)

end subroutine


real(kind=8) function signal_func(x)
    real(kind=8), intent(in)::x
    signal_func = 1./(1.-0.9*sin(x))
end function











end program
