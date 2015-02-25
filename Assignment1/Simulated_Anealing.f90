program Simulated_Anealing
use Ouyed_random_number_module
use Useful_stuff_module
implicit none
real(kind=8) :: Temp, Temp_Decrease, x, xprime, x_min, min, temp_rand, Vx1, Vx2
real(kind=8) :: r, u
real(kind=8), dimension(10) :: T1, T04, T02
real(kind=8), dimension(1000) :: TAll 
real(kind=8), dimension(50) :: hist_Data1, hist_data2, hist_data3, hist_data4
real(kind=8), dimension(50) :: bin_center1, bin_center2, bin_center3, bin_center4
integer :: i, iterations, j

call init_random_seed()

Temp = 1.0
Temp_Decrease = 0.01
iterations = 10
x=1
x_min = 0.0
min = func(x)
j=1

do while (Temp .ge. 0.01)
	do i=1,iterations
		!gather the precious data
		if (Temp .eq. 1.0) then
			T1(i) = x
		else if ((Temp .lt. 0.401) .and. (Temp .gt. 0.399)) then
			T04(i) = x
		else if ((Temp .lt. 0.101) .and. (Temp .gt. 0.099)) then
			T02(i) = x
		end if
		!if (j .ge. 1000)
		TAll(j) = x
		j = j + 1
		!compute things
		temp_rand = random_normal()
		xprime = x + (temp_rand)
		Vx1 = func(x)
		Vx2 = func(xPrime)
		if (Vx2 .lt. Vx1) then
			x = xprime
			if (Vx2 .lt. x_min) then
				x_min = x
				min = Vx2
			end if
		else
			u = exp(-1*(Vx2 - Vx1)/Temp)
			call random_number(r)
			if (u .ge. r) then
				x = xPrime
			end if
		end if
		
		
		
	end do
	Temp = Temp - Temp_Decrease
end do



write(*,*) "Found min of ", min, " at ", x_min

!Write everything to file
open(unit = 42, file="./Data/SA_Temp1.txt", action = "write")
open(unit = 43, file="./Data/SA_Temp04.txt", action = "write")
open(unit = 44, file="./Data/SA_Temp01.txt", action = "write")


do i=1,size(T1)
	write(42,*) T1(i), func(T1(i))
	write(43,*) T04(i), func(T04(i))
	write(44,*) T02(i), func(T02(i))
end do
close(42)
close(43)
close(44)



open(unit = 45, file="./Data/SA_All.txt", action = "write")
do i=1,1000
	write(45,*) TAll(i), func(TALL(i))
end do
close(45)

!Histogram time
call normed_histogram(T1,bin_center1,hist_data1)
call normed_histogram(T04,bin_center2,hist_data2)
call normed_histogram(T02,bin_center3,hist_data3)
call normed_histogram(TAll,bin_center4,hist_data4)

open(unit=46, file="./Data/SA_Hist_T1.txt", action="write")
open(unit=47, file="./Data/SA_Hist_T04.txt", action="write")
open(unit=48, file="./Data/SA_Hist_T01.txt", action="write")
open(unit=49, file="./Data/SA_Hist_TAll.txt", action="write")

do i=1,size(bin_center1)
	write(46,*) bin_center1(i), hist_data1(i)
	write(47,*) bin_center2(i), hist_data2(i)
	write(48,*) bin_center3(i), hist_data3(i)
	write(49,*) bin_center4(i), hist_data4(i)
end do

close(46)
close(47)
close(48)
close(49)


contains

real(8) function func(x)
	real(kind=8), intent(in) :: x
    func = (x**4) - (x**2) + (0.1*x)

end function


end program
