program Markov_chain
    use Useful_stuff_module
    use Ouyed_random_number_module
    use Random_numbers_module

    implicit none

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)

    call weather_sim()
    
contains

    subroutine weather_sim()
        integer :: last_state, current_state
        integer :: num_sunny, num_cloudy, num_trials, num_burn
        real(dp) :: p_sunny, p_cloudy
        integer :: i, file_id1, file_id2

        call init_random_seed()

        file_id1 = new_file_unit()
        open( unit = file_id1, file = "./Data/Weather_simulation.txt", action = 'write')
        file_id2 = new_file_unit()
        open( unit = file_id2, file = "./Data/Weather_simulation_aux.txt", action = 'write')

        ! Start with sunny day
        last_state = 1
        num_trials = 100
        num_burn = 10

        ! Burn in
        do i = 1, num_burn
            current_state = next_state(last_state)
            write(file_id1,*) i, current_state
            last_state = current_state
        end do

        num_sunny = 0
        num_cloudy = 0

        do i = 1 + num_burn, num_trials + num_burn
            current_state = next_state(last_state)
            write(file_id1,*) i, current_state
            if (current_state == 1) num_sunny = num_sunny + 1
            if (current_state == 0) num_cloudy = num_cloudy + 1
            last_state = current_state
        end do

        p_sunny = real(num_sunny, kind = dp)/real(num_trials, kind = dp)
        p_cloudy = real(num_cloudy, kind = dp)/real(num_trials, kind = dp)

        do i = 1, num_trials + num_burn
            write(file_id2, *) i, p_sunny
        end do

        write(*,*) "Prob. sunny day = ", p_sunny
        write(*,*) "Prob. cloudy day = ", p_cloudy

        close(file_id1)
        close(file_id2)

    end subroutine

    integer function next_state(last_state)
        integer, intent(in) :: last_state
        real(dp) :: uni_rand

        call random_number(uni_rand)

        if (last_state == 1) then
            if (uni_rand < 0.75) then
                next_state = 1
            else
                next_state = 0
            end if
        else
            if (uni_rand < 0.5) then
                next_state = 1
            else
                next_state = 0
            end if
        end if

    end function
end program
