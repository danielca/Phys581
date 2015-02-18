module Beta_func
    implicit none

    private 
    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)
    
    real(dp) :: u

    public :: beta, beta_prime, set_u

contains

    real(dp) pure function beta(x)
        real(dp), intent(in) :: x
        beta = 4.0*(x**3) - 3.0*(x**4) - u
    end function

    real(dp) pure function beta_prime(x)
        real(dp), intent(in) :: x
        beta_prime = 12.0*(x**2) - 12.0*(x**3)
    end function

    subroutine set_u(u_val)
        real(dp), intent(in) :: u_val
        u = u_val
    end subroutine
   
end module

program PDF_and_Monte_Carlo
    use Beta_func
    use Useful_stuff_module
    use Ouyed_random_number_module
    use Random_numbers_module
    use Root_finding_module
    
    implicit none

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)
    
    real(dp) :: time_begin, time_end

    call cpu_time(time_begin)
    call beta_fundamental_princ()
    call cpu_time(time_end)

    write(*,*) "Fundamental principle time: ", time_end - time_begin

    call cpu_time(time_begin)
    call beta_acc_rej()
    call cpu_time(time_end)

    write(*,*) "Accept/reject time: ", time_end - time_begin

    call gauss_test()

contains

    subroutine beta_fundamental_princ()
        real(dp), dimension(100000) :: x
        real(dp) :: uni_rand, mean, var
        integer :: i, file_id

        file_id = new_file_unit()
        open( unit = file_id, file = "./Data/Beta_fundamental_princ.txt", action = 'write' )

        call init_random_seed()

        do i = 1, 100000
            call random_number(uni_rand)
            call set_u(uni_rand)
            call newton_raphson( func = beta, &
                                 func_prime = beta_prime, &
                                 guess = 0.5d0, &
                                 root = x(i) )
            if (abs(x(i) - 0.5) > 0.5) then
                write(*,*) "X is out of range!"
            end if
            write(file_id, *) i, x(i)
        end do

        mean = sum(x)/real(size(x), kind = dp)

        var = 0.0
        do i = 1, 100000
            var = var + (x(i) - mean)**2
        end do
        var = var/real(size(x) - 1, kind = dp)

        write(*,*) "Funamental princ. mean = ", mean
        write(*,*) "Funamental princ. std dev = ", var

        close(file_id)
    end subroutine

    subroutine beta_acc_rej()
        real(dp), dimension(100000) :: x
        real(dp) :: ran_x, ran_y, mean, var
        integer :: i, file_id
        logical :: success

        file_id = new_file_unit()
        open( unit = file_id, file = "./Data/Beta_accept_reject.txt", action = 'write' )

        call init_random_seed()

        do i = 1, 100000
            success = .false.
            do while (.not. success) 
                call random_number(ran_x) 
                call random_number(ran_y) 
                ran_y = 1.8*ran_y
                if (ran_y < 12.0*(1-ran_x)*ran_x*ran_x) then
                    x(i) = ran_x
                    success = .true.
                end if
            end do
            write(file_id, *) i, x(i)
        end do

        mean = sum(x)/real(size(x), kind = dp)

        var = 0.0
        do i = 1, 100000
            var = var + (x(i) - mean)**2
        end do
        var = var/real(size(x) - 1, kind = dp)

        write(*,*) "Accept/reject mean = ", mean
        write(*,*) "Accept/reject std dev = ", var

        close(file_id)
    end subroutine

    subroutine gauss_test()
        real(dp), dimension(1000000) :: x_ar
        real(dp), dimension(10000) :: x_cl
        real(dp), dimension(100) :: bins_ar, bins_cl, pdf_ar, pdf_cl
        real(dp) :: mean, var, uni_rand, a, b
        integer :: i, j, file_id, num
        logical :: success

        file_id = new_file_unit()
        open( unit = file_id, file = "./Data/Gauss_generation.txt", action = 'write' )

        call init_random_seed()

        do i = 1, 1000000
            x_ar(i) = gauss_random(5.0d0, 1.25d0)
        end do

        num = 10
        ! Desired mean and variance of the uniform distribution so that the central 
        ! limit theorem gives a Gaussian with mean = 5.0 and std_dev = 1.25
        mean = 5.0/real(num, kind = dp)
        var = 1.25*1.25/real(num, kind = dp)

        a = mean - sqrt(3.0)*sqrt(var)
        b = mean + sqrt(3.0)*sqrt(var)

        x_cl = 0.0
        do i = 1, 10000
            do j = 1, num 
                call random_number(uni_rand)
                x_cl(i) = x_cl(i) + uni_rand*(b-a) + a
            end do
            x_cl(i) = x_cl(i)
        end do

        call normed_histogram(x_ar, bins_ar, pdf_ar)
        call normed_histogram(x_cl, bins_cl, pdf_cl)

        do i = 1, 100
            write(file_id, *) bins_ar(i), pdf_ar(i), bins_cl(i), pdf_cl(i)
        end do

        close(file_id)
    end subroutine

end program
