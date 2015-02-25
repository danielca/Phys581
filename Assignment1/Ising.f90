program ising

use Useful_stuff_module
use Ouyed_random_number_module
use Random_numbers_module

implicit none

integer, parameter :: iqp = kind(1_16)
integer, parameter :: dp  = kind(1.0d0)

call ising_simulation(num_sweeps = 12000, num_pts = 32, num_burn = 500)



contains



subroutine ising_simulation(num_sweeps, num_pts, num_burn)
    integer, intent(in) :: num_sweeps, num_pts, num_burn
    real(dp), dimension(4) :: temperature
    real(dp), dimension(num_pts, num_pts) :: spins
    real(dp), dimension(4, num_sweeps) :: energy, magnet
    real(dp), dimension(4, num_sweeps-num_burn) :: mean_energy, mean_magnet
    real(dp) :: ran_x, ran_y, ran_p, delta, theor_magnet
    integer :: x_ind, y_ind, num_per_sweep
    integer :: energy_file, mag_file
    integer :: mean_energy_file, mean_mag_file, other_file
    integer :: i, j, k

    temperature = (/1.0, 2.25, 2.5, 3.0/)
    !call linspace(temperature, 0.1d0, 6.0d0)

    spins = +1.0

    call init_random_seed()

    num_per_sweep = num_pts*num_pts - 1

    energy(:,1) = calculate_total_energy(spins, num_pts)
    magnet(:,1) = calculate_magnetization(spins, num_pts)

    do k = 1, size(temperature)
        do i = 2, num_sweeps
            do j = 1, num_per_sweep
                call random_number(ran_x)
                call random_number(ran_y)

                x_ind = int(ran_x*num_pts) + 1
                y_ind = int(ran_y*num_pts) + 1

                delta = -4.0*calculate_partial_energy(spins, x_ind, y_ind, num_pts)

                call random_number(ran_p)

                if (ran_p < exp(-delta/temperature(k))) then
                    spins(x_ind, y_ind) = -spins(x_ind, y_ind)
                end if
            end do

            energy(k,i) = calculate_total_energy(spins, num_pts)
            magnet(k,i) = calculate_magnetization(spins, num_pts)
        end do
    end do

    do k = 1, size(temperature)
        do i = 1, num_sweeps - num_burn
            mean_energy(k,i) = sum(energy(k,num_burn+1:i+num_burn))/i
            mean_magnet(k,i) = sum(magnet(k,num_burn+1:i+num_burn))/i
        end do
    end do

    open( unit = new_file_unit(energy_file),                &
          file = "./Data/Ising_energy.txt",                 &
          action = 'write' )
    open( unit = new_file_unit(mag_file),                   &
          file = "./Data/Ising_magnetization.txt",          &
          action = 'write' )
    open( unit = new_file_unit(mean_energy_file),           &
          file = "./Data/Ising_mean_energy.txt",            & 
          action = 'write' )
    open( unit = new_file_unit(mean_mag_file),              &
          file = "./Data/Ising_mean_magnetization.txt",     &
          action = 'write' )
    open( unit = new_file_unit(other_file),                 &
          file = "./Data/Ising_other.txt",                  &
          action = 'write' )

    do i = 1, num_sweeps
        write(energy_file, *) i, energy(1,i), energy(2,i), energy(3,i), energy(4,i)
        write(mag_file, *) i, magnet(1,i), magnet(2,i), magnet(3,i), magnet(4,i)
    end do

    do i = 1, num_sweeps - num_burn
        write(mean_energy_file, *) i + num_burn,        &
                                   mean_energy(1,i),    &
                                   mean_energy(2,i),    &
                                   mean_energy(3,i),    &
                                   mean_energy(4,i)               

        write(mean_mag_file, *)    i+num_burn,          &
                                   mean_magnet(1,i),    &
                                   mean_magnet(2,i),    &
                                   mean_magnet(3,i),    &
                                   mean_magnet(4,i)
    end do

    do i = 1, size(temperature)
        write(other_file, *) temperature(i), &
                             mean_energy(i,num_sweeps-num_burn), &
                             mean_magnet(i,num_sweeps-num_burn), &
                             calculate_theor_magnetization(temperature(i))
    end do

    close(energy_file)
    close(mag_file)
    close(other_file)

end subroutine


real(dp) function periodic_spin(spins, x_ind, y_ind, num_pts)
    ! Returns spin(x_ind, y_ind), but enforces periodic indexing if 
    ! x_ind or y_ind is out of bounds
    real(dp), dimension(:,:), intent(in) :: spins
    integer, intent(in) :: x_ind, y_ind, num_pts
    integer :: x_ind_per, y_ind_per

    ! Periodic indices: num_pts+1 becomes 1, 0 becomes num_pts, etc.
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
            total_energy = total_energy + &
                           calculate_partial_energy(spins, x_ind, y_ind, num_pts)
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


real(dp) function calculate_theor_magnetization(temperature)
    real(dp), intent(in) :: temperature
    real(dp) :: mag, crit_temp

    crit_temp = 2.2692

    if (temperature > crit_temp) then
        mag = 0.0
    else
        mag = (1.0 - (sinh(2.0/temperature))**(-4))**(0.125)
    end if

    calculate_theor_magnetization = mag

end function

end program
