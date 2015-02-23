program Finance
use Ouyed_random_number_module
implicit none
real(kind=8)::r,v,s0,dTime,dStockPrice, timeStep
real(kind=8), dimension(122)::Days
real(kind=8), dimension(457)::hours
integer::i



r=0.14
v=0.2

open(unit=42, file="./Data/StockPrices3Day.txt", action = "write")
s0=10
dTime=1/122
write(42,*) 0, s0
do i=1,122
	call StepInTime(dTime,r,v,s0,dStockPrice)
	s0 = s0 + dStockPrice
	write(42,*) i, s0
end do 
close(42)


open(unit=43, file="./Data/StockPrices8Hour.txt", action="write")
s0 = 10
dTime = 1/457
write(43,*) 0, s0
do i=1,457
	call StepInTime(dTime, r, v, s0, dStockPrice)
	s0 = s0 + dStockPrice
	write(43,*) i, s0
end do

close(43)


contains

subroutine StepInTime(dTime, r, v, s0, dStockPrice)
	real(kind=8),intent(in)::dTime,r,v,s0
	real(kind=8),intent(out)::dStockPrice
	real(kind=8)::e 

	e = random_normal()
	write(*,*) "random is ", e

	dStockPrice = (r*s0*dTime) + (v+s0*e*sqrt(dTime))
end subroutine 

end program Finance