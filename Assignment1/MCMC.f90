program Markov_chain_Monte_Carlo
    use Useful_stuff_module
    use Ouyed_random_number_module
    use Random_numbers_module

    implicit none

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)

    call simple_random_walk()

contains

    subroutine simple_random_walk()
        integer :: x
        real(dp), dimension(:), allocatable :: pdf_x
        real(dp) :: prob, uni_rand
        integer :: num_steps, num_bins, num_runs
        integer :: i, j, file_id

        num_runs = 10000
        num_steps = 200
        num_bins = 2*num_steps + 1
        allocate(pdf_x(num_bins))

        file_id = new_file_unit()
        open( unit = file_id, file = "./Data/Simple_random_walk.txt", action = 'write' )

        call init_random_seed()

        pdf_x = 0.0
        do i = 1, num_runs
            x = 0
            do j = 1, num_steps
                call random_number(uni_rand)
                if (uni_rand < p) then
                    x = x + 1
                else
                    x = x - 1
                end if
            end do
            pdf_x(x + num_steps + 1) = pdf_x(x + num_steps + 1) + 1.0
        end do

        pdf_x = pdf_x/real(num_runs, kind = 8)

        do i = 1, num_bins
            write(file_id, *) i - num_steps - 1, pdf_x(i)
        end do

        deallocate(pdf_x)

    end subroutine

end program
