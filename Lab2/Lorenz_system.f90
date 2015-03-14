program Lorenz_system

    use ODE_system_module
    use Differential_equations_module

    implicit none

    real(8), dimension(:,:), allocatable :: funcs, funcs2, funcs3
    real(8), dimension(:), allocatable :: time, time2, time3
    real(8), dimension(3) :: temp
    real(8) :: time_step, time_step2, time_step3
    integer :: i, num_time, num_time2, num_time3
    
    open(unit = 7, file = "Initial_conditions_555.txt")
    open(unit = 8, file = "Initial_conditions_000.txt")
    open(unit = 9, file = "Initial_conditions_111.txt")
    open(unit = 10, file = "Initial_conditions_0020.txt")
    open(unit = 11, file = "Initial_conditions_100100100.txt")
    open(unit = 12, file = "Initial_conditions_858527.txt")
    open(unit = 13, file = "R_val_2.txt")
    open(unit = 14, file = "R_val_10.txt")
    open(unit = 15, file = "R_val_33.txt")
    open(unit = 16, file = "R_val_88.txt")
    
    num_time = 10000
    num_time2 = 10000
    num_time3 = 40000
    allocate(funcs(3,num_time), time(num_time))
    allocate(funcs2(3,num_time2), time2(num_time2))
    allocate(funcs3(3,num_time3), time3(num_time3))

    !time_step = 0.12 !---> Goes to stationary point
    !time_step = 0.1  !---> Stable
    !time_step = 0.15  !---> Unstable
    time_step = 0.01
    time(1) = 0.0
    do i = 2, num_time
       time(i) = (i-1)*time_step
    end do
    time_step3 = 0.0025
    time3(1) = 0.0
    do i = 2, num_time3
       time3(i) = (i-1)*time_step3
    end do

    call set_sigma(10.0d0)
    call set_b(8.0d0/3.0d0)
    call set_r(28.0d0)
    
    funcs(:,1) = (/ 5.0, 5.0, 5.0 /)
    do i = 1, num_time-1 
        call ODE_system_RK4(funcs(:,i), ODE_system, time(i), time_step, 1, temp)
        funcs(:, i+1) = temp
    end do
    
    do i = 1, num_time
       write(7,*) time(i), funcs(1,i), funcs(2,i), funcs(3,i)
    end do

    !============================================================    
    ! Different initial conditions
    !============================================================    
   
    time_step2 = 0.01
    time2(1) = 0.0
    do i = 2, num_time2
       time2(i) = (i-1)*time_step2
    end do
    
    funcs2(:,1) = (/0.0,0.0,0.0/)
    do i = 1, num_time2 - 1
       call ODE_system_RK4(funcs2(:,i), ODE_system, time2(i), time_step2, 1, temp)
        funcs2(:, i+1) = temp
    end do
    
    do i = 1, num_time2
        write(8,*) time2(i), funcs2(1,i), funcs2(2,i), funcs2(3,i)
    end do

    funcs2(:,1) = (/0.1,0.1,0.1/)
    do i = 1, num_time2 - 1
       call ODE_system_RK4(funcs2(:,i), ODE_system, time2(i), time_step2, 1, temp)
        funcs2(:, i+1) = temp
    end do
    
    do i = 1, num_time2
        write(9,*) time2(i), funcs2(1,i), funcs2(2,i), funcs2(3,i)
    end do

    funcs2(:,1) = (/0.0,0.0,20.0/)
    do i = 1, num_time2 - 1
       call ODE_system_RK4(funcs2(:,i), ODE_system, time2(i), time_step2, 1, temp)
        funcs2(:, i+1) = temp
    end do
    
    do i = 1, num_time2
        write(10,*) time2(i), funcs2(1,i), funcs2(2,i), funcs2(3,i)
    end do

    funcs3(:,1) = (/100.0,100.0,100.0/)
    do i = 1, num_time3 - 1
       call ODE_system_RK4(funcs3(:,i), ODE_system, time3(i), time_step3, 1, temp)
        funcs3(:, i+1) = temp
    end do
    
    do i = 1, num_time3
        write(11,*) time3(i), funcs3(1,i), funcs3(2,i), funcs3(3,i)
    end do

    funcs2(:,1) = (/8.5,8.5,27.0/)
    do i = 1, num_time2 - 1
       call ODE_system_RK4(funcs2(:,i), ODE_system, time2(i), time_step2, 1, temp)
        funcs2(:, i+1) = temp
    end do
    
    do i = 1, num_time2
        write(12,*) time2(i), funcs2(1,i), funcs2(2,i), funcs2(3,i)
    end do

    !============================================================    
    ! Different r values
    !============================================================    

    
    call set_sigma(10.0d0)
    call set_b(8.0d0/3.0d0)

    call set_r(2.0d0)
    
    funcs3(:,1) = (/ 5.0, 5.0, 5.0 /)
    do i = 1, num_time3-1 
        call ODE_system_RK4(funcs3(:,i), ODE_system, time3(i), time_step3, 1, temp)
        funcs3(:, i+1) = temp
    end do
    
    do i = 1, num_time3
       write(13,*) time3(i), funcs3(1,i), funcs3(2,i), funcs3(3,i)
    end do

    call set_r(10.0d0)
    
    do i = 1, num_time3-1 
        call ODE_system_RK4(funcs3(:,i), ODE_system, time3(i), time_step3, 1, temp)
        funcs3(:, i+1) = temp
    end do
    
    do i = 1, num_time3
       write(14,*) time3(i), funcs3(1,i), funcs3(2,i), funcs3(3,i)
    end do

    call set_r(33.0d0)
    
    do i = 1, num_time3-1 
        call ODE_system_RK4(funcs3(:,i), ODE_system, time3(i), time_step3, 1, temp)
        funcs3(:, i+1) = temp
    end do
    
    do i = 1, num_time3
       write(15,*) time3(i), funcs3(1,i), funcs3(2,i), funcs3(3,i)
    end do

    call set_r(88.0d0)
    
    do i = 1, num_time3-1 
        call ODE_system_RK4(funcs3(:,i), ODE_system, time3(i), time_step3, 1, temp)
        funcs3(:, i+1) = temp
    end do
    
    do i = 1, num_time3
       write(16,*) time3(i), funcs3(1,i), funcs3(2,i), funcs3(3,i)
    end do

    close(7)
    close(8)
    close(9)
    close(10)
    close(11)
    close(12)

    deallocate(funcs, time)

end program
