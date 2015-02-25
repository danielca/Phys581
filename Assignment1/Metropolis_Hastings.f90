program Metropolis_Hastings
    use Useful_stuff_module
    use Ouyed_random_number_module
    use Metropolis_Hastings_module

    implicit none

    integer, parameter :: iqp = kind(1_16)
    integer, parameter :: dp  = kind(1.0d0)

    real(dp) :: target_mean, target_std_dev
    real(dp) :: prop_mean, prop_std_dev
    real(dp) :: nu, chi2_centre
    real(dp), dimension(4) :: prop_box
    real(dp), dimension(1000000) :: samples
    real(dp), dimension(500) :: samples2
    real(dp), dimension(100) :: bins, hist
    real(dp), dimension(100) :: bins2, hist2
    integer :: i, file_id

    call init_random_seed()

    target_mean = 5.0
    target_std_dev = 1.0
    prop_mean = -5.0
    prop_std_dev = 1.0

    call generate_mh_samples( target_normal, prop_normal, normal_box, 0.0d0, 0, samples)

    call normed_histogram(samples, bins, hist)

    file_id = new_file_unit()
    open( unit = file_id, file = "./Data/MH_hist_1.txt", action = 'write')

    do i = 1, size(bins)
        write(file_id,*) bins(i), hist(i)
    end do

    close(file_id)

    target_mean = 0.0
    target_std_dev = 5.0
    prop_mean = -0.0
    prop_std_dev = 0.5

    call generate_mh_samples( target_normal, prop_normal, normal_box, 0.0d0, 0, samples)

    call normed_histogram(samples, bins, hist)

    file_id = new_file_unit()
    open( unit = file_id, file = "./Data/MH_hist_2.txt", action = 'write')

    do i = 1, size(bins)
        write(file_id,*) bins(i), hist(i)
    end do

    close(file_id)


    nu = 1.0
    prop_mean = 0
    prop_std_dev = 1.0

    call generate_mh_samples( student_t, prop_normal, normal_box, 0.0d0, 0, samples)

    call normed_histogram(samples, bins, hist)

    file_id = new_file_unit()
    open( unit = file_id, file = "./Data/MH_hist_3.txt", action = 'write')

    do i = 1, size(bins)
        write(file_id,*) bins(i), hist(i)
    end do

    close(file_id)

    prop_mean = 0.0
    prop_std_dev = 100.0

    call generate_mh_samples( crazy_target_dist, prop_normal, normal_box, 1.0d0, 0, samples2)

    call normed_histogram(samples2, bins2, hist2)

    file_id = new_file_unit()
    open( unit = file_id, file = "./Data/MH_mixing_normal_hist.txt", action = 'write')

    do i = 1, size(bins2)
        write(file_id,*) bins2(i), hist2(i)
    end do

    close(file_id)

    file_id = new_file_unit()
    open( unit = file_id, file = "./Data/MH_mixing_normal.txt", action = 'write')

    do i = 1, size(samples2)
        write(file_id,*) i, samples2(i)
    end do

    close(file_id)

    chi2_centre = 1.0d0

    call generate_mh_samples( crazy_target_dist, chi2, chi_box, 1.0d0, 0, samples2)

    call normed_histogram(samples2, bins2, hist2)

    file_id = new_file_unit()
    open( unit = file_id, file = "./Data/MH_mixing_chi2_hist.txt", action = 'write')

    do i = 1, size(bins2)
        write(file_id,*) bins2(i), hist2(i)
    end do

    close(file_id)

    file_id = new_file_unit()
    open( unit = file_id, file = "./Data/MH_mixing_chi2.txt", action = 'write')

    do i = 1, size(samples2)
        write(file_id,*) i, samples2(i)
    end do

    close(file_id)


contains

    real(dp) pure function target_normal(x)
        real(dp), intent(in) :: x

        target_normal = normal(x, target_mean, target_std_dev)
    end function

    real(dp) pure function prop_normal(x, y)
        real(dp), intent(in) :: x, y

        prop_normal = normal(x, prop_mean + y, prop_std_dev)
    end function

    real(dp) pure function normal(x, mean, std_dev)
        real(dp), intent(in) :: x, mean, std_dev

        normal = exp(-((x-mean)**2)/(2.0*std_dev**2))/(std_dev*2.50662827463)
    end function

    real(dp) pure function student_t(x)
        real(dp), intent(in) :: x

        student_t = (1.0 + x*x/nu)**(-(nu+1.0)/2.0)
    end function

    subroutine normal_box(y, box)
        real(dp), intent(in) :: y
        real(dp), dimension(4), intent(out) :: box

        box(1) = y + prop_mean - 4.0*prop_std_dev
        box(2) = y + prop_mean + 4.0*prop_std_dev
        box(3) = 0.0
        box(4) = 1.1*prop_normal(0.0d0, -prop_mean)
    end subroutine

    real(dp) pure function crazy_target_dist(x)
        real(dp), intent(in) :: x

        crazy_target_dist = (x**(-2.5))*exp(-2.0/x)
    end function

    real(dp) pure function chi2(x, y)
        real(dp), intent(in) :: x, y
        real(dp) :: shifted

        !shifted = x + 0.47050754458 - y
        shifted = x + chi2_centre - y

        if (shifted .le. 0) then
            chi2 = 1d-20    ! Use small number to avoid divide-by-zero errors
        else
            chi2 = (shifted**(-0.5))*exp(-shifted/2.0)
        end if 

    end function

    subroutine chi_box(y, box)
        real(dp), intent(in) :: y
        real(dp), dimension(4), intent(out) :: box

        !box(1) = y - 0.47050754458
        box(1) = y - chi2_centre
        box(2) = y + 15.0 - chi2_centre
        box(3) = 0.0
        box(4) = 1.1*chi2(1.0d-1, -1.0d0)
    end subroutine

end program
