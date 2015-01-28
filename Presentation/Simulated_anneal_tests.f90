program Simulated_anneal_tests

    use Simulated_anneal_module

    implicit none

    integer :: test_num
    real(8) :: temperature, f_opt
    real(8), dimension(2) :: step_vector, vect, vect_opt
    integer :: num_accepted, num_func_evals, num_out_bounds, error_code
    logical :: find_max


    do test_num = 0, 2

        write(*,*) "-------------------------------"
        write(*,*) "Begin test ", test_num
        write(*,*) "-------------------------------"
        step_vector = (/ 2.0, 2.0 /)
        temperature = 1.0d0
        vect = (/ 1.0d0, 1.0d0 /)
        if (test_num == 2) then
            find_max = .false.
        else
            find_max = .true.
        end if

        call sa( n = 2,                              &
                 x = vect,                           &
                 fcn = func,                         &
                 max = find_max,                     &
                 rt = 0.85d0,                        &
                 eps = 1.0d-06,                      &
                 Ns = 20,                            &
                 Nt = max(100, 5*2),                 &
                 Neps = 4,                           &
                 maxevl = 10000000,                  &
                 lb = (/ -1.0d20, -1.0d20 /),        &
                 ub = (/ +1.0d20, +1.0d20 /),        &
                 c = (/ 2.0d0, 2.0d0 /),             &
                 iprint = 1,                         &
                 iseed1 = 12047,                     &
                 iseed2 = 21013,                     &
                 t = temperature,                    &
                 vm = step_vector,                   &
                 xopt = vect_opt,                    &
                 fopt = f_opt,                       &
                 nacc = num_accepted,                &
                 nfcnev = num_func_evals,            &
                 nobds = num_out_bounds,             &
                 ier = error_code )

        write(*,*) "-------------------------------"
        write(*,*) "End test ", test_num
        write(*,*) "-------------------------------"
    end do

contains

    real(8) function func(n, vect)

        integer, intent(in) :: n
        real(8), intent(in), dimension(:) :: vect

        real(8) :: x, y

        x = vect(1)
        y = vect(2)

        if (test_num == 0) then
            func = exp( -(x**2 + y**2) )
        else if (test_num == 1) then
            func = exp( -(x**2 + y**2) ) + 2*exp( -( (x-1.7)**2 + (y-1.7)**2 ) )
        else if (test_num == 2) then
            func = (1.0 - x)**2 + 100.0*(y - x**2)**2
        else
            func = 0.0
        end if

    end function

end program
