program Markov_chain_Monte_Carlo
    use Useful_stuff_module
    use Ouyed_random_number_module
    use Random_numbers_module

    implicit none

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)

    call simple_random_walk()

    call metropolis_gauss_distribution()

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
        prob = 0.5
        allocate(pdf_x(num_bins))

        file_id = new_file_unit()
        open( unit = file_id, file = "./Data/Simple_random_walk.txt", action = 'write' )

        call init_random_seed()

        pdf_x = 0.0
        do i = 1, num_runs
            x = 0
            do j = 1, num_steps
                call random_number(uni_rand)
                if (uni_rand < prob) then
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

    subroutine metropolis_gauss_distribution()
        real(dp), dimension(5000) :: x, mean
        real(dp), dimension(80) :: pdf_x, bins
        real(dp) :: delta, uni_rand, step, p_last, p_next
        integer :: i, dist_file, mean_file

        dist_file = new_file_unit()
        open( unit = dist_file, file = "./Data/Metropolis_Gauss_distribution.txt", action = 'write' )
        mean_file = new_file_unit()
        open( unit = mean_file, file = "./Data/Metropolis_Gauss_mean.txt", action = 'write' )

        x(1) = 0.0
        mean(1) = 0.0

        delta = 1.0/sqrt(2.0*0.2)   ! Set delta to one half standard deviation
        delta = delta/2.0

        call init_random_seed()

        do i = 2, size(x)
            call random_number(uni_rand)
            step = (2.0*uni_rand - 1.0)*delta
            x(i) = x(i-1) + step
            p_last = exp(-0.2*x(i-1)*x(i-1))
            p_next = exp(-0.2*x(i)*x(i))
            if (p_next < p_last) then
                call random_number(uni_rand)
                if (uni_rand > p_next/p_last) then
                    x(i) = x(i-1)
                end if
            end if 
            mean(i) = ((i-1)*mean(i-1) + x(i))/i
        end do

        call normed_histogram(x, bins, pdf_x)

        do i = 1, size(bins)
            write(dist_file,*) bins(i), pdf_x(i)
        end do
        
        do i = 1, size(x)
            write(mean_file,*) i, mean(i)
        end do

        close(dist_file)
        close(mean_file)
    end subroutine

end program
