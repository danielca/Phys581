program ising
    use Useful_stuff_module
    use Ouyed_random_number_module
    use Random_numbers_module

    implicit none

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)

    call ising_simulation(3.0d0, 100, 32)

contains

    subroutine ising_simulation(temperature, num_sweeps, num_pts)
        real(dp), intent(in) :: temperature
        integer, intent(in) :: num_sweeps, num_pts
        real(dp), dimension(num_pts, num_pts) :: spins
        real(dp), dimension(num_sweeps) :: total_energy, mean_energy
        real(dp), dimension(num_sweeps) :: magnetization, mean_magnetization
        real(dp) :: ran_x, ran_y, ran_p
        real(dp) :: delta, above, below, right, left, proposed
        integer :: i, j, x_ind, y_ind, num_per_sweep

        call init_random_seed()

        spins = +1.0

        num_per_sweep = num_pts*num_pts - 1

        total_energy(1) = calculate_total_energy(spins, num_pts)
        mean_energy(1) = total_energy(1)
        magnetization(1) = calculate_magnetization(spins, num_pts)
        mean_magnetization(1) = magnetization(1)

        do i = 2, num_sweeps
            do j = 1, num_per_sweep
                call random_number(ran_x)
                call random_number(ran_y)

                x_ind = int(ran_x*num_pts) + 1
                y_ind = int(ran_y*num_pts) + 1

                delta = -4.0*calculate_partial_energy(spins, x_ind, y_ind, num_pts)

                call random_number(ran_p)

                if (ran_p < exp(-delta/temperature)) then
                    spins(x_ind, y_ind) = -spins(x_ind, y_ind)
                end if
            end do

            total_energy(i) = calculate_total_energy(spins, num_pts)
            mean_energy(i) = (mean_energy(i-1)*(i-1) + total_energy(i))/real(i, kind=dp)
            magnetization(i) = calculate_magnetization(spins, num_pts)
            mean_magnetization(i) = (mean_magnetization(i-1)*(i-1) + magnetization(i))/real(i, kind=dp)
        end do

        do i = 1, num_sweeps
            write(*,*) i, total_energy(i), mean_energy(i), magnetization(i), mean_magnetization(i)
        end do

    end subroutine

    real(dp) function periodic_spin(spins, x_ind, y_ind, num_pts)
        real(dp), dimension(:,:), intent(in) :: spins
        integer, intent(in) :: x_ind, y_ind, num_pts
        integer :: x_ind_per, y_ind_per

        x_ind_per = modulo((x_ind - 1), num_pts) + 1
        y_ind_per = modulo((y_ind - 1), num_pts) + 1

        periodic_spin = spins(x_ind_per, y_ind_per)
    end function

    real(dp) function calculate_partial_energy(spins, x_ind, y_ind, num_pts)
        real(dp), dimension(:,:), intent(in) :: spins
        integer, intent(in) :: x_ind, y_ind, num_pts
        real(dp) :: proposed, above, below, right, left

        proposed = periodic_spin(spins, x_ind, y_ind, num_pts)
        above = periodic_spin(spins, x_ind, y_ind+1, num_pts)
        below = periodic_spin(spins, x_ind, y_ind-1, num_pts)
        right = periodic_spin(spins, x_ind+1, y_ind, num_pts)
        left = periodic_spin(spins, x_ind-1, y_ind, num_pts)

        calculate_partial_energy = -0.5*proposed*(left + right + above + below)

    end function

    real(dp) function calculate_total_energy(spins, num_pts)
        real(dp), dimension(:,:), intent(in) :: spins
        integer, intent(in) :: num_pts
        real(dp) :: total_energy
        integer :: x_ind, y_ind

        total_energy = 0.0

        do x_ind = 1, num_pts
            do y_ind = 1, num_pts
                total_energy = total_energy + calculate_partial_energy(spins, x_ind, y_ind, num_pts)
            end do
        end do

        calculate_total_energy = total_energy

    end function

    real(dp) function calculate_magnetization(spins, num_pts)
        real(dp), dimension(:,:), intent(in) :: spins
        integer, intent(in) :: num_pts
        real(dp) :: mag
        integer :: i, j

        mag = 0.0
        do i = 1, num_pts
            do j = 1, num_pts
                mag = mag + spins(i, j)
            end do
        end do
        
        calculate_magnetization = mag/real(num_pts**2, kind=dp)

    end function

end program
