module Differential_equations_module
    implicit none
    
    private
    
    public :: modified_euler, midpoint, runge_kutta_4, ODE_system_RK4, ODE_system_euler

    contains

    subroutine modified_euler(y0, y_prime, x0, step_size, num_steps, y_sol)
        real(8), intent(in) :: x0, y0, step_size
        real(8), external :: y_prime
        integer, intent(in) :: num_steps
        real(8), intent(out) :: y_sol
        real(8) :: x_next, x_last
        real(8) :: y_next, y_last
        real(8) :: half_step_size
        real(8) :: temp
        integer :: i
        
        interface
            pure function y_prime(x, y)
                real(8), intent(in) :: x, y
            end function
        end interface

        x_last = x0
        y_last = y0
        half_step_size = step_size/2.0        

        do i = 1, num_steps
            y_next = y_last + step_size*y_prime(x_last, y_last)
            x_next = x_last + step_size
            temp = (y_prime(x_last, y_last) + y_prime(x_next, y_next))
            y_next = y_last + half_step_size*temp
            y_last = y_next
            x_last = x_next
        end do
        
        y_sol = y_next
    end subroutine
    
    subroutine midpoint(y0, y_prime, x0, step_size, num_steps, y_sol)
        real(8), intent(in) :: x0, y0, step_size
        real(8), external :: y_prime
        integer, intent(in) :: num_steps
        real(8), intent(out) :: y_sol
        real(8) :: x_next, x_last
        real(8) :: y_next, y_last
        real(8) :: half_step_size
        integer :: i
        
        interface
            pure function y_prime(x, y)
                real(8), intent(in) :: x, y
            end function
        end interface

        x_last = x0
        y_last = y0
        half_step_size = step_size/2.0        

        do i = 1, num_steps
            y_next = y_last + half_step_size*y_prime(x_last, y_last)
            x_next = x_last + half_step_size
            y_next = y_last + step_size*y_prime(x_next, y_next)
            y_last = y_next
            x_last = x_last + step_size
        end do
        
        y_sol = y_next
    end subroutine

    subroutine runge_kutta_4(y0, y_prime, x0, step_size, num_steps, y_sol)
        real(8), intent(in) :: x0, y0, step_size
        real(8), external :: y_prime
        integer, intent(in) :: num_steps
        real(8), intent(out) :: y_sol
        real(8) :: x
        real(8) :: y_next, y_last
        real(8) :: half_step_size
        real(8) :: k1, k2, k3, k4
        integer :: i
        
        interface
            pure function y_prime(x, y)
                real(8), intent(in) :: x, y
            end function
        end interface

        x = x0
        y_last = y0
        half_step_size = step_size/2.0        

        do i = 1, num_steps
            k1 = step_size*y_prime(x, y_last)
            k2 = step_size*y_prime(x + half_step_size, y_last + k1/2.0)
            k3 = step_size*y_prime(x + half_step_size, y_last + k2/2.0)
            k4 = step_size*y_prime(x + step_size, y_last + k3)
            
            y_next = y_last + (1.0/6.0)*(k1 + 2*k2 + 2*k3 + k4)
            
            y_last = y_next
            x = x + step_size
        end do
        
        y_sol = y_next
    end subroutine

    subroutine ODE_system_RK4(y0, y_prime, x0, step_size, num_steps, y_sol)
        real(8), intent(in), dimension(:) :: y0
        real(8), intent(in) :: x0, step_size
        external :: y_prime
        integer, intent(in) :: num_steps
        real(8), intent(out), dimension(:) :: y_sol
        integer :: dim_system
        real(8) :: x
        real(8), dimension(:), allocatable :: y_next, y_last
        real(8) :: half_step_size
        real(8), dimension(:), allocatable :: k1, k2, k3, k4
        real(8), dimension(:), allocatable :: temp
        real(8) :: temp2
        integer :: i

        interface
            subroutine y_prime(x, y, f)
                real(8), dimension(:), intent(in) :: y
                real(8), dimension(:), intent(out) :: f
                real(8), intent(in) :: x
            end subroutine
        end interface

       
        dim_system = size(y0)

        if (size(y0) /= size(y_sol)) then
            write(*,*) "ERROR in ODE_system_RK4:"
            write(*,*) "    Size mismatch between inputs."
        end if
        
        allocate(k1(dim_system), k2(dim_system), k3(dim_system), k4(dim_system))
        allocate(y_next(dim_system), y_last(dim_system), temp(dim_system))
        
        x = x0
        y_last = y0
        half_step_size = step_size/2.0        

        !write(*,*) "x is" , x
        !write(*,*) y_last(1), y_last(2), y_last(3)
        do i = 1, num_steps
            call y_prime( x = x, y = y_last, f = k1)
            call y_prime( x = x + half_step_size, &
                          y = y_last + step_size*k1/2.0, &
                          f = k2 )
            call y_prime( x = x + half_step_size, &
                          y = y_last + step_size*k2/2.0, &
                          f = k3 )
            call y_prime( x = x + step_size, &
                          y = y_last + step_size*k3, &
                          f = k4 )

            y_next = y_last + (step_size/6.0)*(k1 + 2*k2 + 2*k3 + k4)
            
            y_last = y_next
            x = x + step_size
        end do
        
        y_sol = y_next
        
        deallocate(k1, k2, k3, k4)
        deallocate(y_next, y_last)
    end subroutine 

    subroutine ODE_system_euler(y0, y_prime, x0, step_size, num_steps, y_sol)
        real(8), intent(in), dimension(:) :: y0
        real(8), intent(in) :: x0, step_size
        external :: y_prime
        integer, intent(in) :: num_steps
        real(8), intent(out), dimension(:) :: y_sol
        integer :: dim_system
        real(8) :: x
        real(8), dimension(:), allocatable :: y_next, y_last
        real(8) :: half_step_size
        real(8), dimension(:), allocatable :: derivs
        real(8) :: temp2
        integer :: i

        interface
            subroutine y_prime(x, y, f)
                real(8), dimension(:), intent(in) :: y
                real(8), dimension(:), intent(out) :: f
                real(8), intent(in) :: x
            end subroutine
        end interface

       
        dim_system = size(y0)

        if (size(y0) /= size(y_sol)) then
            write(*,*) "ERROR in ODE_system_euler:"
            write(*,*) "    Size mismatch between inputs."
        end if
        
        allocate(derivs(dim_system))
        allocate(y_next(dim_system), y_last(dim_system))
        
        x = x0
        y_last = y0
        half_step_size = step_size/2.0        

        do i = 1, num_steps
            call y_prime( x = x, y = y_last, f = derivs)

            y_next = y_last + step_size*derivs
            
            y_last = y_next
            x = x0 + i*step_size
        end do
        
        y_sol = y_next
        
        deallocate(derivs, y_next, y_last)
    end subroutine

end module
