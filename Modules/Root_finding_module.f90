module Root_finding_module

    implicit none

    private

    public :: newton_raphson
    public :: newton_raphson_complex
    public :: secant_root

    contains

    subroutine newton_raphson(func, func_prime, guess, root, num_iter, f_tolerance, x_tolerance)
    
        real(8), intent(in) :: guess
        real(8), intent(in), optional :: f_tolerance, x_tolerance
        real(8), intent(out) :: root
        integer, intent(out), optional :: num_iter
        real(8) :: f_tol, x_tol
        real(8) :: last_guess, f_guess, f_guess_prime, current_guess
        integer :: j, iter

        interface 
            real(kind(1.0d0)) pure function func(x)
                real(kind(1.0d0)), intent(in) :: x
            end function

            real(kind(1.0d0)) pure function func_prime(x)
                real(kind(1.0d0)), intent(in) :: x
            end function
        end interface

        f_tol = 1d-6
        x_tol = 1d-6

        if (present(f_tolerance)) f_tol = abs(f_tolerance)
        if (present(x_tolerance)) x_tol = abs(x_tolerance)

        iter = 0
        last_guess = guess
        current_guess = guess + x_tol + 1
        f_guess = func(last_guess)
        do while ((abs(f_guess) >= f_tol) .or. (abs(current_guess - last_guess) >= x_tol))
           f_guess = func(last_guess)
           f_guess_prime = func_prime(last_guess)
           current_guess = last_guess - f_guess/f_guess_prime
           iter = iter + 1
           if (abs(f_guess_prime) <= abs(1.0d-15)) then
              write(*,*) "WARNING in newton_raphson:"
              write(*,*) "    f_prime is very small."
           end if
           if (iter > 1000) then
               write(*,*) "WARNING in newton_raphson:"
               write(*,*) "    Maximum number of iterations exceeded."
               exit
           end if
           last_guess = current_guess
        end do

        root = current_guess
        if (present(num_iter)) num_iter = iter

    end subroutine

    subroutine newton_raphson_complex( &
            func, func_prime, guess, root, num_iter, f_tolerance, &
            z_tolerance, max_iterations, display_warnings)
    
        complex(8), intent(in) :: guess
        real(8), intent(in), optional :: f_tolerance, z_tolerance
        logical, intent(in), optional :: display_warnings
        complex(8), intent(out) :: root
        integer, intent(out), optional :: num_iter
        integer, intent(in), optional :: max_iterations
        real(8) :: f_tol, z_tol
        logical :: warn
        integer :: max_iter
        complex(8) :: last_guess, f_guess, f_guess_prime, current_guess
        integer :: j, iter

        interface 
            complex(kind(1.0d0)) pure function func(x)
                complex(kind(1.0d0)), intent(in) :: x
            end function

            complex(kind(1.0d0)) pure function func_prime(x)
                complex(kind(1.0d0)), intent(in) :: x
            end function
        end interface

        f_tol = 1d-6
        z_tol = 1d-6
        warn = .true.
        max_iter = 1000

        if (present(f_tolerance)) f_tol = abs(f_tolerance)
        if (present(z_tolerance)) z_tol = abs(z_tolerance)
        if (present(display_warnings)) warn = display_warnings
        if (present(max_iterations)) max_iter = max_iterations

        iter = 0
        last_guess = guess
        current_guess = guess + z_tol + 1
        f_guess = func(last_guess)
        do while ((abs(f_guess) >= f_tol) .or. (abs(current_guess - last_guess) >= z_tol))
           f_guess = func(last_guess)
           f_guess_prime = func_prime(last_guess)
           current_guess = last_guess - f_guess/f_guess_prime
           iter = iter + 1
           if (warn .and. (abs(f_guess_prime) <= abs(1.0d-15))) then
              write(*,*) "WARNING in newton_raphson:"
              write(*,*) "    f_prime is very small."
           end if
           if (iter > max_iter) then
               if (warn) then
                   write(*,*) "WARNING in newton_raphson:"
                   write(*,*) "    Maximum number of iterations exceeded."
               end if
               exit
           end if
           last_guess = current_guess
        end do

        root = current_guess
        if (present(num_iter)) num_iter = iter

    end subroutine

    subroutine secant_root(func, guess_0, guess_1, root, num_iter, f_tolerance, x_tolerance)

        real(8), intent(in) :: guess_0, guess_1
        real(8), intent(in), optional :: f_tolerance, x_tolerance
        real(8), intent(out) :: root
        integer, intent(out), optional :: num_iter
        real(8) :: f_tol, x_tol
        real(8) :: last_guess, f_guess, f_guess_prime, current_guess, next_guess
        integer :: j, iter

        interface 
            real(kind(1.0d0)) pure function func(x)
                real(kind(1.0d0)), intent(in) :: x
            end function
        end interface

        f_tol = 1d-6
        x_tol = 1d-6

        if (present(f_tolerance)) f_tol = f_tolerance
        if (present(x_tolerance)) x_tol = x_tolerance

        iter = 0
        last_guess = guess_0
        current_guess = guess_1
        f_guess = func(current_guess)
        do while (abs(f_guess) >= abs(f_tol) .or. (abs(current_guess - last_guess) >= x_tol))
           f_guess = func(current_guess)
           f_guess_prime = (func(current_guess) - func(last_guess))/(current_guess - last_guess)
           next_guess = current_guess - f_guess/f_guess_prime
           iter = iter + 1
           if (abs(f_guess_prime) <= abs(1.0d-15)) then
              write(*,*) "WARNING in secant_root:"
              write(*,*) "    f_prime is very small."
              exit
           endif
           if (iter > 1000) then
               write(*,*) "WARNING in secant_root:"
               write(*,*) "    Maximum number of iterations exceeded."
               exit
            end if
           last_guess = current_guess
           current_guess = next_guess
        enddo
        
        root = current_guess
        if (present(num_iter)) num_iter = iter

    end subroutine

end module

!program test
!    use Root_finding_module
!
!    implicit none
!
!    integer, parameter :: dp = kind(1.0d0)
!    
!    real(dp) :: x_newton, x_secant
!    integer :: n_newton, n_secant
!
!    call newton_raphson(f, f_prime, -1.414d0, x_newton, n_newton, x_tolerance = 1d-15)
!    call secant_root(f, -1.414d0, -1.4142d0, x_secant, n_secant, x_tolerance = 1d-15)
!
!    write(*,*) x_newton, n_newton
!    write(*,*) x_secant, n_secant
!
!    contains
!
!    real(dp) pure function f(x)
!        real(dp), intent(in) :: x
!
!        f = x*x - 2
!    end function
!
!    real(dp) pure function f_prime(x)
!        real(dp), intent(in) :: x
!
!        f_prime = 2*x
!    end function
!end program
