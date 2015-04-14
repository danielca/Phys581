program Quantum
use nr
implicit none
real::alpha, w

alpha = 1.0
open(unit=42, file = "./Data/Direct1.txt", action="write")
call direct(alpha, 42)
close(42)
w=0.1
open(unit=44, file = "./Data/weight_lax_1_01.txt", action = "write")
call lax(alpha, w, 44)
close(44)

w=0.25
open(unit=45, file = "./Data/weight_lax_1_25.txt", action = "write")
call lax(alpha, w, 45)
close(45)

w=0.5
open(unit=46, file = "./Data/weight_lax_1_50.txt", action = "write")
call lax(alpha, w, 46)
close(46)

w=0.75
open(unit=47, file = "./Data/weight_lax_1_75.txt", action = "write")
call lax(alpha, w, 47)
close(47)

w=0.9
open(unit=48, file = "./Data/weight_lax_1_90.txt", action = "write")
call lax(alpha, w, 48)
close(48)

open(unit = 43, file="./Data/Direct100.txt")
alpha = 1000.0
call direct(alpha,43)
close(43)

w=0.1
open(unit=49, file = "./Data/weight_lax_1000_01.txt", action = "write")
call lax(alpha, w, 49)
close(49)

w=0.25
open(unit=50, file = "./Data/weight_lax_1000_25.txt", action = "write")
call lax(alpha, w, 50)
close(50)

w=0.5
open(unit=51, file = "./Data/weight_lax_1000_50.txt", action = "write")
call lax(alpha, w, 51)
close(51)

w=0.75
open(unit=52, file = "./Data/weight_lax_1000_75.txt", action = "write")
call lax(alpha, w, 52)
close(52)

w=0.9
open(unit=53, file = "./Data/weight_lax_1000_90.txt", action = "write")
call lax(alpha, w, 53)
close(53)




contains


subroutine lax(alpha, w, fileID)
real, intent(in)::alpha, w
integer, intent(in)::fileID
real, dimension(:,:), allocatable::Unew, Uold
real::e, dl
integer::i,j,k, matrix_size, iterations

matrix_size = 50
iterations = 10000
dl=(1./(matrix_size+1))**2
e = -4 - dl*alpha
allocate(Unew(matrix_size,matrix_size), Uold(matrix_size, matrix_size))

!initialize the matrix
do i=1,matrix_size
    do j=1,matrix_size
        Uold(i,j) = 1.0
        Unew(i,j) = 1.0
    end do
end do

!Iterate a bunch
do k=1, iterations
    do i=2,(matrix_size-1)
        do j=2,(matrix_size-1)
            Unew(i,j) = point(Uold, e, i, j, w)
        end do
    end do
    Uold = Unew
end do

!write to file
do i=1,matrix_size
    do j=1,matrix_size
        write(fileID,*) i, j, Unew(i,j)
    end do
    write(fileID,*)
end do

deallocate(Unew)
deallocate(Uold)

end subroutine

real function point(U, e, j, l, w)
real, dimension(:,:), intent(in)::U
real, intent(in)::e,w
integer, intent(in)::j,l
real::summ

summ = U(j+1,l) + U(j-1,l) + U(j,l+1) + U(j,l-1) + e*U(j,l)

point = U(j,l) - w*(summ/e)
end function





subroutine direct(alpha, fileID)
    real, intent(in):: alpha
    integer, intent(in)::fileID
    real, dimension(:,:), allocatable::A, ans
    real, dimension(:), allocatable::B
    real:: dl, d
    integer::i,j,k,matrix_size, loop_size
    integer, dimension(:), allocatable::indx

    matrix_size = 50
    
    loop_size = (matrix_size)**2
    dl = (1./(matrix_size+1))**2
    write(*,*) "dl ", dl

    allocate(A(loop_size,loop_size), B(loop_size))
    allocate(indx(loop_size))

    do i=1,loop_size
        do k=1, loop_size
            if (i .eq. k) then
                A(i,k) = -4.0d0-(dl*alpha)
            else if ((i .eq. (k+1)) .or. (i.eq.(k-1)).or.(i.eq.(k+matrix_size)).or.(i.eq.(k-matrix_size))) then
                A(i,k) = 1.0d0
            else
                A(i,k) = 0.0d0
            end if
            
        end do
        B(i) = 0.0d0
    end do


    do i=1,loop_size
        if ( (mod(i,matrix_size).eq.0) .or. &
        (mod(i-1,matrix_size).eq.0) .or. &
        (i.le.matrix_size) .or. &
        (i.ge.((Matrix_size-1)*matrix_size)) ) then
            do k=1,loop_size
                if (i.eq.k) then
                    A(i,k) = 1.0d0
                else
                    A(i,k) = 0.0d0
                end if
            end do
            B(i) = 1.0d0
        end if
    end do

    call ludcmp(A,indx,d)
    call lubksb(A,indx,B)

    ans = reshape(B, (/matrix_size,matrix_size/))

    do i=1,matrix_size
        do j=1,matrix_size
            write(fileID,*) i, j, ans(i,j)
        end do
        write(fileID,*) ""
    end do

end subroutine




end program
