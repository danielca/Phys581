program no_time
implicit none
real::h, h0

!h0 = 5

!h = h0
!open(unit = 42,file = "../Data/no_time_0_50.txt")
!call box1(42,h)
!close(42)
!
!h = h0 * 0.5
!open(unit = 43,file = "../Data/no_time_0_25.txt")
!call box1(43,h)
!close(43)
!
!h=h0 * 0.25
!open(unit = 44,file = "../Data/no_time_0_12.txt")
!call box1(44,h)
!close(44)
!
!h=h0/8.0
!open(unit = 45,file = "../Data/no_time_0_06.txt")
!call box1(45,h)
!close(45)
!
!h=h0/16.0
!open(unit = 46,file = "../Data/no_time_0_03.txt")
!call box1(46,h)
!close(46)



open(unit=47, file = "../Data/no_time_100.txt")
call box2(47)
close(47)




contains

subroutine box1(fid, dl)
    integer,intent(in)::fid
    real, intent(in)::dl
    real,dimension(:,:), allocatable:: old_grid, new_grid
    integer::i,j,k, max_iterations, x_size, y_size

    x_size = int(20.0/dl)
    y_size = int(10.0/dl)
    max_iterations=10000
    allocate(old_grid(x_size,y_size), new_grid(x_size, y_size))

    !intialize the matrix
    call init_arrays1(old_grid, new_grid, x_size, y_size)

    !ITERATE ALL OF THE THINGS
    do k=1,max_iterations
        do i= 2, x_size-1
            do j=2, y_size-1
                new_grid(i,j) = point1(old_grid,i,j)
            end do
        end do
        old_grid = new_grid
    end do

    !writer in the the....... file
    do i=1,x_size
        do j=1, y_size
            write(fid,*) real(i)*dl, real(j)*dl, new_grid(i,j)
        end do
        write(fid,*) ""
    end do



end subroutine

subroutine init_arrays1(array1, array2, x, y)
    real, dimension(:,:), intent(inout):: array1, array2
    integer, intent(in):: x,y
    integer:: i,j
    do i=1,x
        do j=1,y
            if ((i.eq.0) .or. (j.eq.0) .or. (j.eq.y)) then 
                array1(i,j) = 0.0
                array2(i,j) = 0.0
            else if (i.eq.x) then
                array1(i,j) = 100.0
                array2(i,j) = 100.0
            else
                array1(i,j) = 1.0
                array2(i,j) = 1.0
            end if
        end do
    end do
end subroutine

real function point1(grid, n, m)
    real, dimension(:,:), intent(in)::grid
    integer, intent(in)::n,m
    real::summ
    summ = grid(n+1,m) + grid(n-1,m) + grid(n,m+1) + grid(n,m-1)
    point1= (summ/4.0)
end function

!____________________________DIFFRENT CASSES________________________________

subroutine box2(fid)
    integer,intent(in)::fid
    real,dimension(:,:), allocatable:: old_grid, new_grid
    integer::i,j,k, max_iterations, matrix_size
    real::dl, s, fact, prec
    logical::flag

    dl = 1./50.
    s = 100.0
    fact = (dl**2)*s
    matrix_size = int(1./dl)
    max_iterations=10000
    prec = 10.0**(-3) 
    allocate(old_grid(matrix_size,matrix_size), new_grid(matrix_size, matrix_size))

    !intialize the matrix
    call init_arrays2(old_grid, new_grid, matrix_size)

    do i=1,matrix_size
        do j=1, matrix_size
            write(fid,*) real(i)*dl, real(j)*dl, new_grid(i,j)
        end do
        write(fid,*) ""
    end do
    write(*,*) ""

    !ITERATE ALL OF THE THINGS
    flag = .false.
    do k=1,max_iterations
        do i= 2, matrix_size-1
            do j=2, matrix_size-1
                new_grid(i,j) = point2(old_grid,i,j, fact)
                if ((abs(new_grid(i,j) - old_grid(i,j))) .lt. prec ) then
                    flag = .true.
                end if
            end do
        end do
        old_grid = new_grid
        if (flag) then
            exit
        end if
    end do
    
    write(*,*) "Exited in ", k, " iterations"

    !writer in the the....... file
    do i=1,matrix_size
        do j=1, matrix_size
            write(fid,*) real(i)*dl, real(j)*dl, new_grid(i,j)
        end do
        write(fid,*) ""
    end do



end subroutine

subroutine init_arrays2(array1, array2, matrix_size)
    real, dimension(:,:), intent(inout):: array1, array2
    integer, intent(in):: matrix_size
    integer:: i,j
    do i=1,matrix_size
        do j=1,matrix_size
            if ((i.eq.1) .or. (i.eq.matrix_size) .or. (j.eq.1) .or. (j.eq.matrix_size)) then
                array1(i,j) = 0.0
                array2(i,j) = 0.0
            else
                array1(i,j) = 1.0
                array2(i,j) = 1.0
            end if
        end do
    end do
end subroutine

real function point2(grid, n, m, fact)
    real, dimension(:,:), intent(in)::grid
    integer, intent(in)::n,m
    real, intent(in)::fact
    real::summ
    summ = grid(n+1,m) + grid(n-1,m) + grid(n,m+1) + grid(n,m-1) - fact
    point2= (summ/4.0)
end function


end program

