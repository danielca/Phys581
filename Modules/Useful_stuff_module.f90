module Useful_stuff_module
    implicit none
    private

    public :: calculate_chi2
    public :: linspace
    public :: histogram
    public :: new_file_unit

contains

real(8) function calculate_chi2(obs_freq)
    real(8), dimension(:,:), intent(in) :: obs_freq
    real(8), dimension(:,:), allocatable :: exp_freq
    integer, dimension(2) :: dims
    integer :: n, m
    real(8), dimension(:,:), allocatable :: row_marg_tot
    real(8), dimension(:,:), allocatable :: col_marg_tot
    real(8) :: chi2
    real(8) :: grand_total
    integer :: i, j 

    dims = shape(obs_freq)
    n = dims(1)
    m = dims(2)
    allocate(exp_freq(n,m))
    allocate(row_marg_tot(n,1), col_marg_tot(1,m))

    do i = 1, n
        row_marg_tot(i,1) = 0.0
        do j = 1,m
            row_marg_tot(i,1) = row_marg_tot(i,1) + obs_freq(i,j)
        enddo
    enddo

    do i = 1, m
        col_marg_tot(1,i) = 0.0
        do j = 1,n
            col_marg_tot(1,i) = col_marg_tot(1,i) + obs_freq(j,i)
        enddo
    enddo

    grand_total = 0.0

    do i = 1, n
        do j = 1, m
            grand_total = grand_total + obs_freq(i,j)
        enddo
    enddo

    exp_freq = matmul(row_marg_tot, col_marg_tot)/grand_total

    chi2 = 0.0
    do i = 1, n
        do j = 1, m
            chi2 = chi2 + ((obs_freq(i,j) - exp_freq(i,j))**(2.0))/exp_freq(i,j)
        enddo
    enddo

    calculate_chi2 = chi2

end function


subroutine linspace(array, min_val, max_val)
    !
    ! Similar to MATLAB's linspace function.
    ! 'array' should be an already-allocated array.
    ! Linspace then fills 'array' with values ranging from min_val to max_val
    ! with even spacing between elements.
    !

    real(8), dimension(:), intent(out) :: array
    real(8), intent(in) :: min_val, max_val
    real(8) :: diff_val     ! Difference between adjacent array elements
    integer :: num_val, i

    num_val = size(array)
    diff_val = (max_val - min_val)/(num_val - 1.0)

    do i = 1, num_val
       array(i) = min_val + (i-1)*diff_val
    end do

end subroutine


subroutine histogram(data_array, bin_centres, hist_data)
    !
    ! Counts number of elements of data_array in each bin.
    ! Bin centres stored in bin_centres
    ! Number of elements in each bin stored in hist_data
    !
    ! Number of bins == size(bin_centres) == size(hist_data)
    ! Bins are linearly distributed between min(data_array) and max(data_array)
    ! (i.e., left edge of lowest bin is min(data_array) and right edge of highest
    ! bin is max(data_array)
    !
    ! This isn't the most efficient implementation, but it should work correctly.
    !

    real(8), dimension(:), intent(in) :: data_array
    integer, dimension(:), intent(out) :: hist_data
    real(8), dimension(:), intent(out) :: bin_centres
    real(8) :: max_data, min_data
    real(8) :: bin_spacing
    integer :: num_data, num_bins
    integer :: closest_ind
    integer :: i, j

    num_data = size(data_array)
    num_bins = size(bin_centres)

    if (num_bins /= size(hist_data)) then
        write(*,*) "WARNING in 'histogram':"
        write(*,*) "   Size mismatch between bin_centres and hist_data."
    end if

    max_data = maxval(data_array)
    min_data = minval(data_array)
    bin_spacing = (max_data - min_data)/num_bins

    do j = 1, num_bins
        bin_centres(j) = min_data + (j - 0.5)*bin_spacing
    end do

    hist_data = 0

    do i = 1, num_data
        closest_ind = minloc(abs(data_array(i) - bin_centres), dim = 1)
        hist_data(closest_ind) = hist_data(closest_ind) + 1
    end do

end subroutine


integer function new_file_unit(unit) result(n)
    integer, intent(out), optional :: unit
    logical inuse
    integer, parameter :: n_min = 10
    integer, parameter :: n_max = 999

    do n = n_min, n_max
        inquire(unit = n, opened = inuse)
        if (.not. inuse) then
            if (present(unit)) unit = n
            return
        end if
    end do

    write(*,*) "new_unit ERROR: available unit not found."

end function

end module
