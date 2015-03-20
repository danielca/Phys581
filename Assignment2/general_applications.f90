program general_applications
use Fourier_analysis_module
use Random_numbers_module
implicit none


!call beats()
!call solarActvity()
call stocks()
!call globalWarming()



contains

subroutine globalWarming()
    integer::i, file_max, array_size, temp, file_array
    real(kind=8), dimension(:), allocatable::co2, line, freq, power
    complex(kind=8), dimension(:), allocatable::fft_dat
    real(kind=8)::dt

    file_max = 51
    file_array = file_max*12
    array_size = 1024
    dt = 1.0

    allocate(co2(array_size))
    allocate(line(array_size))
    allocate(fft_dat(array_size))
    allocate(freq(array_size), power(array_size))
    open(unit=60, file="co2.txt", action="read")

    !4 lines need to be read before data
    read(60,*)
    read(60,*)
    read(60,*)
    read(60,*)

    !File has each month in a column. So all months in a year must be read in a single pass
    do i=1,file_array,12
        read(60,*) temp, co2(i), co2(i+1), co2(i+2), co2(i+3), co2(i+4), &
            co2(i+5), co2(i+6), co2(i+7), co2(i+8), co2(i+9), co2(i+10), co2(i+11)
    end do
    close(60)

    
    open(unit=61, file="./Data/co2_time1.txt")
    do i=1,file_array
        write(61,*) i, co2(i)
    end do

    close(61)
    
    open(unit=62, file = "./Data/co2_time2.txt")
    !create the line and subtract it out
    do i=1,file_array
        line(i) = lin_line(dble(i))
        co2(i) = co2(i) - line(i)
        write(62,*) i, co2(i), line(i)
    end do
    close (62)

    !pad to 1024 with 0s
    do i=file_array+1,array_size
        co2(i) = 0
        line(i) = 0
    end do
    
    call fft(co2, dt, freq, fft_dat)
    call calc_power(fft_dat, power)

    open(unit=63, file="./Data/co2_power.txt", action="write")
    do i=1,size(freq)
        write(63,*) freq(i), power(i)
    end do
    close(63)

    deallocate(co2)
    deallocate(line)
    deallocate(freq)
    deallocate(power)
    deallocate(fft_dat)
end subroutine

real(kind=8) function lin_line(x)
    real(kind=8), intent(in)::x
    real(kind=8)::a,b

    !from gnuplot line fit
    a=0.118083
    b=308.859

    lin_line = a*x + b
end function



subroutine stocks()
    integer::i, file_max, array_size
    real(kind=8), dimension(:), allocatable::file_1, time, freq, power, dowAutoCor
    complex(kind=8), dimension(:), allocatable::fft_dat 
    real(kind=8)::dt
    character(len=10)::temp_day
    
    !Dow.txt
    file_max = 1024
    array_size = 1024

    allocate(file_1(array_size), freq(array_size))
    allocate(power(array_size), fft_dat(array_size))
        dt = 1
    open(unit=46, file = "dow.txt", action = "read")
    open(unit=49, file="./Data/dow.txt")
    do i=1,file_max
        read(46,*) file_1(i)
        write(49,*) i, file_1(i)
    end do
    close(46)
    close(49)

    !Calculate and save the DFT
    call fft(file_1, dt, freq, fft_dat)
    call calc_power(fft_dat, power)
    open(unit=47, file="./Data/dow_fft.txt")
    do i=1,size(freq)
        write(47,*) freq(i), power(i)
    end do
    close(47)  

    
    deallocate(freq)
    deallocate(power)
    deallocate(fft_dat)

    !call the auto core functions and write them to file
    allocate(dowAutoCor(size(file_1)))
    call auto_correlation(file_1, dowAutoCor)
    write(*,*) "         Dow Jones Auto Correlation"
    write(*,*) "Auto Correlation for k = 1, stock price:", dowAutoCor(2) 
    write(*,*) "Auto Correlation for k = 2, stock price:", dowAutoCor(3) 
    write(*,*) "Auto Correlation for k = 5, stock price:", dowAutoCor(6)
    write(*,*) "Auto Correlation for k = 20, stock price:", dowAutoCor(21)
    write(*,*) "------------------------------------------------------------------"
    
    !daily DJIA
    file_max = 252
    write(*,*) "          Daily Dow Jones Industrail Average Daily Autocorrelation"
    open(unit = 52, file="DJI_daily.txt")
    call autoCorWrapper(52, file_max)
    close(52)
    write(*,*) "------------------------------------------------------------------------------------"
    

    !weekly DJIA
    file_max = 52
    write(*,*) "          Daily Dow Jones Industrail Average Weekly Autocorrelation"
    open(unit = 51, file="DJI_weekly.txt")
    call autoCorWrapper(51, file_max)
    close(51)
    write(*,*) "------------------------------------------------------------------------------------"
    

    !Monthly DJIA
    file_max = 12
    write(*,*) "          Daily Dow Jones Industrail Average Monthly Autocorrelation"
    open(unit = 50, file="DJI_monthly.txt")
    call autoCorWrapper(50, file_max)
    close(50)
    write(*,*) "------------------------------------------------------------------------------------"

    deallocate(file_1)
end subroutine

subroutine autoCorWrapper(inputFile, file_size)
    integer,intent(in)::inputfile, file_size
    character(len=10)::temp_day
    real(kind=8), dimension(:), allocatable::file_dat, returns, file_auto_cor, returns_auto_cor
    integer::i

    allocate(file_dat(file_size), returns(file_size-1))
    allocate(file_auto_cor(file_size), returns_auto_cor(file_size-1))

    do i=1,file_size
       read(inputFile,*) temp_day, file_dat(i)
    end do
       
    !calculate returns
    do i=2,file_size
        returns(i-1) = (log(file_dat(i)) / file_dat(i-1))*100.0
    end do

    !auto correlations
    call auto_correlation(file_dat, file_auto_cor)
    call auto_correlation(returns, returns_auto_cor)

    write(*,*) "Auto Correlation for k = 1, stock price:", file_auto_cor(2), " returns:", returns_auto_cor(2) 
    write(*,*) "Auto Correlation for k = 2, stock price:", file_auto_cor(3), " returns:", returns_auto_cor(3) 
    write(*,*) "Auto Correlation for k = 5, stock price:", file_auto_cor(6), " returns:", returns_auto_cor(6) 

    if (22 .lt. file_size) then
        write(*,*) "Auto Correlation for k = 20, stock price:", file_auto_cor(21), " returns:", returns_auto_cor(21)
    else
        write(*,*) "Not enough values for an auto correlation of k=20"
    end if

    deallocate(file_dat)
    deallocate(returns)
    deallocate(file_auto_cor)
    deallocate(returns_auto_cor)

end subroutine

subroutine solarActvity()
    integer::i,file_max, time_array_size
    real(kind=8), dimension(:), allocatable::time, dat, freq, real_fft
    complex(kind=8), dimension(:), allocatable::fft_dat
    real(kind=8)::dt

    file_max = 3143
    time_array_size = 4096

    write(*,*) "testing123"

    allocate(time(time_array_size), fft_dat(time_array_size))
    allocate(dat(time_array_size), freq(time_array_size))
    allocate(real_fft(time_array_size))

    open(unit=44,file="sunspots.txt", action="read")
    do i=1,file_max
        read(44,*) time(i), dat(i)
    end do
    do i=file_max+1,time_array_size
        time(i) = i
        dat(i) = 0
    end do
    close (44)

    
    dt = 1.0

    call fft(dat, dt, freq, fft_dat)
    
    open(unit=45, file="./Data/sunspots_fft.txt", action ="write")

    do i=1,size(fft_dat)
        real_fft(i) = abs(fft_dat(i))**2
    end do

    do i=1,size(freq)
        write(45,*) freq(i), log10(real_fft(i))*10
    end do
    
    deallocate(time)
    deallocate(dat)
    deallocate(fft_dat)
    deallocate(freq)
    deallocate(real_fft)
    close(45)

end subroutine


subroutine beats()
    integer::i, file_max
    real(kind=8), dimension(:), allocatable:: beats_array, freq
    complex(kind=8), dimension(:), allocatable::fft_dat
    real(kind=8)::dt

    file_max=4096   !Number of samples
    dt = 1./125.    !sampled at 125Hz
    allocate(beats_array(file_max))
    allocate(fft_dat(file_max), freq(file_max))

    open(unit = 42, file="beats.txt", action="read")
    do i=1,file_max
        read(42,*) beats_array(i)
    end do
    close(42)

    call fft(beats_array, dt, freq, fft_dat)
    
    open(unit = 43, file = "./Data/beats_fft.txt", action = "write")
    do i=1,size(freq)
        write(43,*) freq(i), abs(fft_Dat(i))
    end do
    close(43)
    
    deallocate(beats_array)
    deallocate(fft_dat)
    deallocate(freq)
end subroutine




end program
