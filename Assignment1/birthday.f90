program birthday
implicit none
integer, dimension(10000):: rand_nums
real::temp_num
integer, dimension(365)::days1, days2
integer::birthday_counter, i, j
integer, dimension(2)::max_iterations

max_iterations(1) = 30
max_iterations(2) = 10000
birthday_counter = 0

!initialize the days array


do j=1,365
	days1(j) = 0
	days2(j) = 0
end do		


do i=1,max_iterations(2)
	call random_number(temp_num)
	temp_num = int(temp_num * (365+1-1)) + 1 
	rand_nums(i) = temp_num
end do

do i=1,max_iterations(1)
	days1(rand_nums(i)) = days1(rand_nums(i)) + 1
end do

do i=1,365
	if (days1(i) .gt. 1) then
		birthday_counter = birthday_counter + days1(i)
	end if
end do 

write(*,*) "Found ", birthday_counter, " are the same out of 30 people"

birthday_counter = 0


do i=1,max_iterations(2)
	days2(rand_nums(i)) = days2(rand_nums(i)) + 1
end do

do i=1,365
	if (days2(i) .gt. 1) then
		birthday_counter = birthday_counter + days2(i)
	end if
end do 

write(*,*) "Found ", birthday_counter, " are the same out of 1000 people"



end program