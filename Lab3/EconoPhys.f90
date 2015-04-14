program EconoPhys

implicit none
real(kind=8), dimension(21,251)::V
real(kind=8)::dt, ds, t, sigma, r
integer::i,j,k, left, right
    common/global/dt,ds,sigma,r

t = 100.0d0
dt = 0.4d0
ds = 1.0d0
sigma = 0.1d0
r = 0.05d0
left = 1
right = 20

!ASk about boundry conditions for something like this

call initial_conditions(V)

open(unit=42, file="./Data/stock_100.txt", action="write")
open(unit=43, file="./Data/stock_85.txt", action="write")
open(unit=44, file="./Data/stock_75.txt", action="write")
open(unit=45, file="./Data/stock_50.txt", action="write")
open(unit=46, file="./Data/stock_00.txt", action="write")

do i=2,251
    !Each time step
    do j = 2,20
        V(j,i) = point(V,i,j)
        if ((t.lt.100.1).and.(t.gt.99.9)) then
            write(42,*) j, v(j,i-1)
        else if ((t.lt.85.4).and.(t.gt.84.9)) then
            write(43,*) j, v(j,i-1)
        else if ((t.lt.75.4).and.(t.gt.74.9)) then 
            write(44,*) j, v(j,i-1)
        else if ((t.lt.50.3).and.(t.gt.49.9)) then
            write(45,*) j, V(j,i-1)
        else if (t.lt.0.5) then
            write(46,*) j, V(j,i-1)
        end if
    end do
    
    !V(1,j) = V(2,j)
    !V(21,j) = V (20,j)
    t = t - dt
end do




contains

subroutine initial_conditions(V)
real(kind=8), dimension(:,:), intent(inout)::V
integer:: i

do i = 1, 20
    if (i.lt.10) then
        V(i,1) = 0.0d0
    else
        V(i,1) = dble(i) - 10.0d0
    end if
end do
do i=2,251
    V(1,i) = 0
    V(21,i) = 20.0 - 10.0
end do

end subroutine

real(kind=8) function point(V,n,j)
    real(kind=8), dimension(:,:), intent(in)::V
    integer, intent(in)::n,j
    real(kind=8)::alpha, beta, gam, fac1, fac2, fac3
    real(kind=8):: dt, ds, sigma, r
        common/global/dt,ds,sigma,r
    alpha = r*dt
    beta = dt*(sigma**2)/2.0d0
    fac1 = V(j,n-1)
    fac2 = V(j+1,n-1) -2*V(j,n-1)+V(j-1,n-1)
    fac3 = V(j+1,n-1)-V(j-1,n-1)

    point = fac1 + beta*fac2 + alpha*fac3
end function







end program
