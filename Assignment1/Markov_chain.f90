program Markov_chain
    use Useful_stuff_module
    use Ouyed_random_number_module
    use Random_numbers_module

    implicit none

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)

    call weather_sim()

    call square_sim()
    
contains

    subroutine weather_sim()
        integer :: last_state, current_state
        integer :: num_sunny, num_cloudy, num_trials, num_burn
        real(dp) :: p_sunny, p_cloudy
        integer :: i, file_id1, file_id2

        call init_random_seed()

        file_id1 = new_file_unit()
        open( unit = file_id1, file = "./Data/Weather_simulation.txt", action = 'write')
        !file_id2 = new_file_unit()
        !open( unit = file_id2, file = "./Data/Weather_simulation_aux.txt", action = 'write')

        ! Start with sunny day
        last_state = 1
        num_trials = 100
        num_burn = 10

        ! Burn in
        do i = 1, num_burn
            current_state = next_state(last_state)
            !write(file_id1,*) i, current_state
            last_state = current_state
        end do

        num_sunny = 0
        num_cloudy = 0

        do i = 1 + num_burn, num_trials + num_burn
            current_state = next_state(last_state)
            !write(file_id1,*) i, current_state
            if (current_state == 1) num_sunny = num_sunny + 1
            if (current_state == 0) num_cloudy = num_cloudy + 1
            last_state = current_state
        end do

        p_sunny = real(num_sunny, kind = dp)/real(num_trials, kind = dp)
        p_cloudy = real(num_cloudy, kind = dp)/real(num_trials, kind = dp)

        !do i = 1, num_trials + num_burn
        !    write(file_id2, *) i, p_sunny
        !end do

        write(file_id1, *) 0, p_cloudy, 1.0/3.0
        write(file_id1, *) 1, p_sunny, 2.0/3.0

        close(file_id1)
        !close(file_id2)

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

    subroutine square_sim()
        integer :: last_state, current_state
        integer :: num_trials, num_burn
        real(dp), dimension(4,4) :: hist
        real(dp), dimension(4) :: theor_prob
        integer :: i, j, file_id1, file_id2

        call init_random_seed()

        file_id1 = new_file_unit()
        open( unit = file_id1, file = "./Data/Square_simulation.txt", action = 'write')

        last_state = 1
        num_trials = 500
        num_burn = 50

        hist = 0
        do j = 1, 4
            
            last_state = j

            ! Burn in
            do i = 1, num_burn
                current_state = square_next_state(last_state)
                last_state = current_state
            end do

            do i = 1, num_trials
                current_state = square_next_state(last_state)
                hist(j,current_state) = hist(j,current_state) + 1
                last_state = current_state
            end do

        end do

        hist = hist/real(num_trials, kind=dp)

        theor_prob(1) = 0.3
        theor_prob(2) = 0.2
        theor_prob(3) = 0.3
        theor_prob(4) = 0.2

        do j = 1, 4
            write(file_id1, *) j, theor_prob(j), hist(1,j), hist(2,j), hist(3,j), hist(4,j)
            write(*,*) "Prob state", j, " = ", hist(1,j)
        end do

        close(file_id1)

    end subroutine


    integer function square_next_state(last_state)
        integer, intent(in) :: last_state
        integer :: next_state
        real(dp) :: uni_rand

        call random_number(uni_rand)

        if (last_state == 1) then
            if (uni_rand < 1.0/3.0) then
                next_state = 2
            else if (uni_rand < 2.0/3.0) then
                next_state = 3
            else
                next_state = 4
            end if
        else if (last_state == 2) then
            if (uni_rand < 0.5) then
                next_state = 1
            else
                next_state = 3
            end if
        else if (last_state == 3) then
            if (uni_rand < 1.0/3.0) then
                next_state = 1
            else if (uni_rand < 2.0/3.0) then
                next_state = 2
            else
                next_state = 4
            end if
        else
            if (uni_rand < 0.5) then
                next_state = 1
            else
                next_state = 3
            end if
        end if

        square_next_state = next_state

    end function
end program
