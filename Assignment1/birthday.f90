program birthday

use Ouyed_random_number_module

implicit none
real::temp_num
integer, dimension(365)::days
integer::birthday_counter, i, j,k, max_iterations, trails, found_birthdays, index
max_iterations = 10000
trails = 30
found_birthdays = 0


!initialize the days array
do k=1,max_iterations

   birthday_counter = 0
   call init_random_seed()
 
   do j=1,365
      days(j) = 0
   end do


   do i=1,trails
      call random_number(temp_num)
      index = int(temp_num * (365+1-1)) + 1 
      days(index) = days(index) + 1
   end do

   do i=1,365
      if (days(i) .gt. 1) then
         birthday_counter = birthday_counter + days(i)
      end if
   end do
   if (birthday_counter .gt. 0) then
      found_birthdays = found_birthdays + 1
   end if
end do
write(*,*) "Found ", found_birthdays, " out of ", max_iterations, " trials"






end program
