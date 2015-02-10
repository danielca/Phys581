program Metropolis
use Ouyed_random_number_module
use Useful_stuff_module

implicit none

integer::k, i, j, accepted_values
real(kind=8), dimension(3)::sigma
real(kind=8)::xn, x_star, unit_rand
integer, dimension(2,3)::file_id
integer, dimension(2)::max_iterations
real(kind=8), allocatable,dimension(:,:)::x1,x2
integer, dimension(3,50):: hist_data1, hist_data2
real(kind=8),dimension(3,50)::bin_center1, bin_center2

max_iterations(1) = 1000
max_iterations(2) = 50000

!allocate the arrays
allocate(x1(3,max_iterations(1)))
allocate(x2(3,max_iterations(2)))

!Intialize the 
sigma(1) = 0.025
sigma(2) = 1.0
sigma(3) = 50.0

!using an array of file ID to write to seperate data files for each senario
file_id(1,1) = 42
file_id(1,2) = 43
file_id(1,3) = 44
file_id(2,1) = 45
file_id(2,2) = 46
file_id(2,3) = 47

!OPEN ALL THE FILES!
open(unit=42, file="./Data/Metropolis_sigma-0.025_1000.txt", action = "write")
open(unit=43, file="./Data/Metropolis_sigma-1_1000.txt", action = "write")
open(unit=44, file="./Data/Metropolis_sigma-50_1000.txt", action = "write")
open(unit=45, file="./Data/Metropolis_sigma-0.025_50000.txt", action = "write")
open(unit=46, file="./Data/Metropolis_sigma-1_50000.txt", action = "write")
open(unit=47, file="./Data/Metropolis_sigma-50_50000.txt", action = "write")

!main loop
do k=1,2 !Change the max iterations
   do j=1,3 !new standard devation
      xn = -1.0
      do i=1,max_iterations(k)
         !find x_star
         unit_rand = random_normal()
         x_star = sigma(j)*unit_rand + xn
         xn = select_new_point(x_star,xn)
         !icrement the accepted_values counter if needed
         if (x_star .ne. xn) then
              accepted_values = accepted_values + 1 
         end if
         
         write(file_id(k,j),*) x_star, xn, i, accepted_values
         
         !write in the arrays
         if (k .eq. 1) then
            x1(j,i) = xn
         else if (k .eq. 2) then
            x2(j,i) = xn
         end if

      end do
   end do
end do
   
!close the files
close(42)
close(43)
close(44)
close(45)
close(46)
close(47)

!reuse the file_id_array
file_id(1,1) = 48
file_id(1,2) = 49
file_id(1,3) = 50
file_id(2,1) = 51
file_id(2,2) = 52
file_id(2,3) = 53

!Open unit files
open(unit=48,file="./Data/hist_data_sigma-0.025_1000",action="write")
open(unit=49,file="./Data/hist_data_sigma-1_1000",action="write")
open(unit=50,file="./Data/hist_data_sigma-50_1000",action="write")
open(unit=51,file="./Data/hist_data_sigma-0.025_50000",action="write")
open(unit=52,file="./Data/hist_data_sigma-1_50000",action="write")
open(unit=53,file="./Data/hist_data_sigma-50_50000",action="write")

!deal with the historgrams
do i =1,3
   call histogram(x1(i,:),bin_center1(i,:),hist_data1(i,:))
   call histogram(x2(i,:),bin_center2(i,:),hist_data2(i,:))
   do j=1,size(bin_center1(i,:))
      write(file_id(1,i),*) bin_center1(i,j), hist_data1(i,j)
      write(file_id(2,i),*) bin_center2(i,j), hist_data2(i,j)
   end do
end do

!close the files
close(48)
close(49)
close(50)
close(51)
close(52)
close(53)

contains 

real(kind=8) function prob_distribution(x)
 !The desired probability distribution
 real(kind=8),intent(in)::x
 real(kind=8)::PI,constant,hard_part, temp
 PI=3.14159265359
 constant = 1/(2.0*sqrt(PI))
 hard_part = (sin(5.0*x) + sin(2.0*x) + 2)*exp(-1.*(x**2))
 temp = constant * hard_part
 prob_distribution = temp
end function prob_distribution

real(kind=8) function select_new_point(x_star,xn)
 !This function determines if the new point is accepted or rejected
 !bassed on the acceptance probability. x_star is the new point, xn is the
 !current point
 real(kind=8), intent(in)::x_star,xn
 real(kind=8)::a, rand_number

 a = prob_distribution(x_star)/prob_distribution(xn)
 call random_number(rand_number)
 !write(*,*) a, rand_number, x_star, xn
 if (a .ge. 1) then
    select_new_point = x_star
 else if (a .lt. rand_number) then
    select_new_point = x_star
 else
    select_new_point = xn
 end if

end function select_new_point


end program
