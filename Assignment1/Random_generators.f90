program Radiative_transfer
    use Useful_stuff_module
    use Random_numbers_module
    use Ouyed_random_number_module

    implicit none

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)
    integer :: i

    do i = 0, 4
    !    call random_generator_test(i)
    end do

    call white_noise()

contains

    subroutine random_generator_test(test_num)
        integer, intent(in) :: test_num
        character(len = 1024) :: test_filename, ac_filename
        integer :: test_file, ac_file
        integer, dimension(6) :: num_trials
        real(dp) :: mean, std_dev, theor_mean, theor_std_dev
        real(dp), dimension(:), allocatable :: ran_nums, auto_corr, auto_corr_sm
        integer(iqp) :: seed
        integer :: i, j

        num_trials = (/ 10, 10**2, 10**3, 10**4, 10**6, 10**9 /)

        theor_mean = 0.5
        theor_std_dev = 1.0/sqrt(12.0)

        write(test_filename, "(a15,i1.1,a4)") "./Data/Test_ran", test_num, ".txt"
        test_file = new_file_unit()
        open(unit = test_file, file = test_filename, action = 'write')

        write(ac_filename, "(a20,i1.1,a4)") "./Data/Auto_corr_ran", test_num, ".txt"
        ac_file = new_file_unit()
        open(unit = ac_file, file = ac_filename, action = 'write')

        call init_random_seed()

        do i = 1, 6
            write(*,*) "Starting trial ", i, " on test number ", test_num
            allocate(ran_nums(num_trials(i)))
            seed = -1
            do j = 1, num_trials(i)
                if (test_num == 0) ran_nums(j) = nr_ran0(seed)
                if (test_num == 1) ran_nums(j) = nr_ran1(seed)
                if (test_num == 2) ran_nums(j) = nr_ran2(seed)
                if (test_num == 3) ran_nums(j) = nr_ran3(seed)
                if (test_num == 4) call random_number(ran_nums(j))
            end do

            mean = sum(ran_nums)/real(num_trials(i), kind = 8)

            std_dev = 0.0
            do j = 1, num_trials(i)
                std_dev = std_dev + (ran_nums(j) - mean)**2
            end do
            std_dev = std_dev/real(num_trials(i), kind = 8)
            std_dev = sqrt(std_dev)

            write(test_file, *) num_trials(i), abs(mean - theor_mean), abs(std_dev - theor_std_dev)

            if (i == 5) then
                allocate(auto_corr(num_trials(i)), auto_corr_sm(num_trials(i)))
                call auto_correlation(ran_nums, auto_corr)
                call avg_filter(abs(auto_corr), 10, auto_corr_sm)
                do j = 1, num_trials(i)
                    write(ac_file, *) j, abs(auto_corr(j)), abs(auto_corr_sm(j))
                end do
                deallocate(auto_corr, auto_corr_sm)
            end if

            deallocate(ran_nums)
        end do

        close(test_file)
        close(ac_file)

    end subroutine

    subroutine avg_filter(x, filter_size, x_sm)
        real(dp), dimension(:), intent(in) :: x 
        integer, intent(in) :: filter_size
        real(dp), dimension(:), intent(out) :: x_sm
        real(dp) :: factor
        integer :: num_pts, i, j

        num_pts = size(x)
        factor = 1.0/(filter_size*2.0)

        do i = 1, num_pts
            x_sm(i) = 0.0
            if (i .le. filter_size) then
                do j = 1, 2*filter_size + 1
                    x_sm(i) = x_sm(i) + x(j)
                end do
            else if (i .ge. num_pts - filter_size + 1) then
                do j = num_pts - 2*filter_size, num_pts
                    x_sm(i) = x_sm(i) + x(j)
                end do
            else
                do j = i - filter_size, i + filter_size
                    x_sm(i) = x_sm(i) + x(j)
                end do
            end if
            x_sm(i) = x_sm(i)*factor
        end do

    end subroutine

    subroutine white_noise()
        real(dp), dimension(100) :: x, ac, x_norm, ac_norm
        real(dp) :: uni_rand
        integer :: file_id, i

        file_id = new_file_unit()
        open( unit = file_id, file = "./Data/White_noise.txt", action = 'write')

        call init_random_seed()

        do i = 1, 100
            call random_number(uni_rand)
            x(i) = 2.0*sqrt(3.0)*uni_rand - sqrt(3.0)
            x_norm(i) = random_normal()
        end do

        call auto_correlation(x, ac)
        call auto_correlation(x_norm, ac_norm)

        do i = 1, 100
            write(file_id, *) i, x(i), abs(ac(i)), x_norm(i), abs(ac_norm(i))
        end do

        close(file_id)
    end subroutine

end program
