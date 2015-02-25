module Metropolis_Hastings_module
    use Useful_stuff_module
    use Ouyed_random_number_module
    use Random_numbers_module
    implicit none

    private
    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)

    public :: generate_mh_samples

contains
    subroutine generate_mh_samples( target_pdf, proposal_pdf, proposal_box, &
                                    start_point, num_burn, out_samples)

        real(dp), dimension(:), intent(out) :: out_samples
        real(dp), intent(in) :: start_point
        integer, intent(in) :: num_burn
        real(dp) :: last_x
        integer :: num_pts, num_iter, i, num_accepted

        interface
            real(kind(1.0d0)) pure function target_pdf(x)
                real(kind(1.0d0)), intent(in) :: x
            end function
            real(kind(1.0d0)) pure function proposal_pdf(x, y)
                real(kind(1.0d0)), intent(in) :: x, y
            end function
            subroutine proposal_box(y, box)
                real(kind(1.0d0)), intent(in) :: y
                real(kind(1.0d0)), dimension(4), intent(out) :: box
            end subroutine
        end interface

        num_pts = size(out_samples)
        num_iter = num_pts + num_burn

        last_x = start_point

        do i = 1, num_burn
            last_x = mh_sample(target_pdf, proposal_pdf, proposal_box, last_x)
        end do

        num_accepted = 0
        do i = 1, num_pts
            out_samples(i) = mh_sample(target_pdf, proposal_pdf, proposal_box, last_x)
            if ( abs(out_samples(i) - last_x) > 1.0e-30 ) then
                num_accepted = num_accepted + 1
            end if
            last_x = out_samples(i)
        end do
        
        write(*,*) "Fraction accepted = ", num_accepted/real(num_pts, kind=8)

    end subroutine

    real(dp) function mh_sample( target_pdf, proposal_pdf, proposal_box, last_x)

        real(dp), intent(in) :: last_x
        real(dp), dimension(4) :: box
        real(dp) :: next_x, uni_rand, t_num, p_num, t_den, p_den, acc_prob

        interface
            real(kind(1.0d0)) pure function target_pdf(x)
                real(kind(1.0d0)), intent(in) :: x
            end function
            real(kind(1.0d0)) pure function proposal_pdf(x, y)
                real(kind(1.0d0)), intent(in) :: x, y
            end function
            subroutine proposal_box(y, box)
                real(kind(1.0d0)), intent(in) :: y
                real(kind(1.0d0)), dimension(4), intent(out) :: box
            end subroutine
        end interface

        call proposal_box(last_x, box)

        next_x = proposal_sample( proposal_pdf, last_x, box )

        call random_number(uni_rand)

        t_num = target_pdf(next_x)
        p_num = proposal_pdf(next_x, last_x)

        t_den = target_pdf(last_x)
        p_den = proposal_pdf(last_x, next_x)

        !if (p_den < 1d-16) then
        !    acc_prob = t_num/t_den
        !else
            acc_prob = t_num*p_num/(t_den*p_den)
        !end if


        if (uni_rand < acc_prob) then
            mh_sample = next_x
        else
            mh_sample = last_x
        end if

        !write(*,*) last_x - next_x, acc_prob, mh_sample - last_x

    end function

    real(dp) function proposal_sample(pdf, y_val, box)
        real(dp), intent(in) :: y_val
        real(dp), dimension(:), intent(in) :: box
        real(dp) :: x_min, x_max, y_min, y_max
        real(dp) :: ran_x, ran_y
        integer :: counter

        interface
            real(kind(1.0d0)) pure function pdf(x, y)
                real(kind(1.0d0)), intent(in) :: x, y
            end function
        end interface

        x_min = box(1)
        x_max = box(2)
        y_min = box(3)
        y_max = box(4)

        counter = 0

        do while (.true.)
            counter = counter + 1
            call random_number(ran_x)
            call random_number(ran_y)
            ran_x = x_min + (x_max - x_min)*ran_x
            ran_y = y_min + (y_max - y_min)*ran_y

            if (ran_y < pdf(ran_x, y_val)) then
                proposal_sample = ran_x
                return
            end if
        end do
    end function

end module
