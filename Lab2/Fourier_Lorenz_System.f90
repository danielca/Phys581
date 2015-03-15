program Fourier_Lorenz_System 

use fourier_analysis_module
use ODE_system_module
use Differential_equations_module

implicit none



call FixedPoints()
!call Astro()





contains

subroutine FixedPoints()
    integer::i,j,num_time
    real(kind=8)::x,y, time_step, r
    real(kind=8), dimension(:), allocatable::xt, yt
    
    num_time=16384
    time_step = 0.01
    
    open(unit=46, file = "./Data/FixedPoints.txt")
    open(unit=47, file = "./Data/LorenzPhase1.txt")
    open(unit=48, file = "./Data/LorenzPhase3.txt")
    open(unit=49, file = "./Data/LorenzPhase13.txt")
    open(unit=50, file = "./Data/LorenzPhase145.txt")
    open(unit=51, file = "./Data/LorenzPhase26.txt")
    open(unit=52, file = "./Data/LorenzSpec.txt")
    !do i=0,300
    i=0
        allocate(xt(num_time), yt(num_time))
        !set the new r
        r = dble(i)*dble(0.1)
        write(*,*) "Now running radius ", r
        call runLorenzSystem(r, x, num_time, time_step, xt, yt)
        write(46,*) r, x
        
        !Write the phase plots to file for the required radi
        if ((r.gt.0.99) .and. (r.lt.1.01)) then
            do j=1,size(xt)
                write(47,*) dble(j)*time_step, xt(j), yt(j)
            end do
        else if ((r.gt.1.99) .and. (r.lt.2.01)) then
            do j=1,size(xt)
                write(48,*) dble(j)*time_step, xt(j), yt(j)
            end do
        else if ((r.gt.12.99) .and. (r.lt.13.01)) then
            do j=1,size(xt)
                write(49,*) dble(j)*time_step, xt(j), yt(j)
            end do
        else if ((r.gt.14.44) .and. (r.lt.14.6)) then
            do j=1,size(xt)
                write(50,*) dble(j)*time_step, xt(j), yt(j)
            end do
        else if ((r.gt.15.99) .and. (r.lt.16.01)) then
            do j=1,size(xt)
                write(51,*) dble(j)*time_step, xt(j), yt(j)
            end do
        end if
        call lorenzSpectral(r, xt, time_step, 52)
        deallocate(xt,yt)
    !end do
    close(46)
    close(47)
    close(48)
    close(49)
    close(50)
    close(51)
    close(52)
end subroutine


subroutine lorenzSpectral(r, xt, dt, file_int)
    real(kind=8), intent(in)::r, dt
    real(kind=8), intent(in), dimension(:)::xt
    integer, intent(in)::file_int
    complex(kind=8), dimension(:), allocatable::fft_dat
    real(kind=8), dimension(:), allocatable::freq, magnitude, windowed
    integer::i,j

    allocate(fft_dat(size(xt)), freq(size(xt)))
    allocate(magnitude(size(xt)), windowed(size(xt)))
    
    call window_hanning(xt,windowed)
    call fft(windowed, dt, freq, fft_dat)
    call calc_power(fft_dat, magnitude)

    do i=1,size(freq)
        if (freq(i).ge.0) then
            write(file_int,*) r, freq(i), magnitude(i)
        end if
    end do

    deallocate(fft_dat, freq)
    deallocate(magnitude, windowed)
   
end subroutine

subroutine runLorenzSystem(r,x,num_time, time_step,xt,yt)
    integer, intent(in)::num_time
    real(kind=8), intent(inout)::r
    real(kind=8), intent(out)::x
    real(kind=8), dimension(:), intent(out)::xt,yt
    real(kind=8), dimension(3)::temp
    real(kind=8), dimension(:), allocatable::time
    real(kind=8), dimension(:,:), allocatable::funcs
    real(kind=8)::time_step
    integer::i

    !set the constants
    call set_sigma(10.0d0)
    call set_b(8.0d0/3.0d0)
    call set_r(r)
    allocate(funcs(3,num_time),time(num_time))
    time(1) = 0

    do i = 2, num_time
        time(i) = (i-1)*time_step
    end do
    funcs(:,1)=(/5.0, 5.0, 5.0/)
    do i=1, num_time-1
        call ODE_system_RK4(funcs(:,i),ODE_system, time(i), time_step, 1, temp)
        funcs(:,i+1) = temp 
        xt(i) = funcs(1,i)
        yt(i) = funcs(2,i)
    end do

    x = funcs(1,num_time-1)

end subroutine

subroutine Astro()
    integer::file_size, i
    real(kind=8), dimension(32768)::time, noCount, freq, magnitude, windowed_count
    complex(kind=8), dimension(32768)::fft_dat
    file_size = 28400

    open (unit = 43, file = "binary.txt")
    do i = 1, file_size
        read(43,*) time(i), noCount(i)
    end do
    do i=file_size+1,size(time)
        time(i) = (time(2)-time(1)) * dble(i)
        noCount(i) = 0
    end do
    close(43)
    
    call window_hanning(noCount, windowed_count)
    call fft(windowed_count, dble(time(3)-time(1)), freq, fft_dat)
    call calc_power(fft_dat, magnitude)
    
    open(unit=44, file="./Data/Astro.txt")
    do i=1, size(freq)
        write(44,*) time(i), noCount(i), freq(i), magnitude(i)
    end do
    close(44)


end subroutine



end program
