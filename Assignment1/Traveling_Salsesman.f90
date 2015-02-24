program Traveling_Salesman
use Ouyed_random_number_module
implicit none
real(kind=8),dimension(5,5)::distanceArray

distanceArray = reshape((/0.0, 3.0, 4.0, 2.0, 2.0, &
						 3.0, 0.0, 4.0, 6.0, 3.0, &
						 4.0, 4.0, 0.0, 5.0, 8.0, & 
						 2.0, 6.0, 5.0, 0.0, 6.0, & 
						 7.0, 3.0, 8.0, 6.0, 0.0/), shape(distanceArray))

call init_random_seed()
call SimulatedAnealing(distanceArray)
call BruteForce(distanceArray)
call ClosestNeighbour(distanceArray)



contains

subroutine SimulatedAnealing(distanceArray)
real(kind=8), dimension(:,:), intent(in) :: distanceArray
integer, dimension(5) :: points, points2, minPoints
real(kind=8) :: minDistance, T, increments, distance1, distance2
integer :: i, arbitrary_max, flip
real :: time_begin, time_end

call cpu_time(time_begin)

points = (/1, 2, 3, 4, 5/)
minPoints = points
minDistance = distance(points, distanceArray)
arbitrary_max = 100

T = 3.0 
increments = -0.5

do i=1,arbitrary_max
	call swapPoints(points, points2)
	distance1 = distance(points, distanceArray)
	distance2 = distance(points2, distanceArray)
	if (distance2 .lt. distance1) then 
		points = points2
		if (distance2 .lt. minDistance) then
			minDistance = distance2
			minPoints = points
		end if
	else
		flip = coinFlip(points2, points2, T, distanceArray)
		if (flip .eq. 0) then
			points = points2
		end if
	end if
end do
call cpu_time(time_end)
write(*,*) "-----------------------------------------------------"
write(*,*) "           Simulated Annealing"
write(*,*) "The shortets distance found was ", minDistance
write(*,*) "Via the path ", points
write(*,*) "Completed in ", time_end-time_begin, " Seconds"
write(*,*) "-----------------------------------------------------"


end subroutine

subroutine swapPoints(points, points2)
integer, dimension(:), intent(inout) :: points
integer, dimension(:), intent(out) :: points2
real :: rand
integer :: swap1, swap2, max_value, temp1, temp2
max_value = size(points)

call random_number(rand)
swap1 = int(rand * (max_value+1-1)) + 1

call random_number(rand)
swap2 = int(rand * (max_value+1-1)) + 1

temp1 = points(swap1)
temp2 = points(swap2)

points(swap1) = temp2
points(swap2) = temp1
points2 = points
end subroutine

integer function CoinFlip(points1, points2, T, distanceArray)
integer, dimension(:), intent(in) :: points1, points2
real(kind=8) :: distance1, distance2
real(kind=8), intent(in) :: T
real(kind=8), dimension(:,:), intent(in) :: distanceArray
real(kind=8) :: p, u

distance1 = distance(points1, distanceArray)
distance2 = distance(points2, distanceArray)

p = exp((-1*(distance2) - distance1)/T)
call random_number(u)
if (u .lt. p) then
	CoinFlip = 0
else
	CoinFlip = 1
end if

end function

real(kind=8) function distance(points, distanceArray)
integer, dimension(:), intent(in) :: points
real(kind=8), dimension(:,:), intent(in) :: distanceArray
integer :: i
real(kind=8) :: total_distance

total_distance = 0

do i=2,size(points)
	total_distance = total_distance + distanceArray(i-1,i)
end do
distance = total_distance
end function

subroutine BruteForce(distanceArray)
real(kind=8), dimension(:,:), intent(in) :: distanceArray
integer :: i, j, k, l, m
real(kind=8) :: shortest_distance, current_distance
integer, dimension(4) :: points
real :: begin_time, end_time
call cpu_time(begin_time)
shortest_distance = 1000.0 !arbitrarily large to get the ball rolling
do i=2,5
	do j=2,5
		do k=2,5
			do l=2,5
				!Current path is 0-i-j-k-l
				if ((i .ne. j) .and. (i .ne. k) .and. (i .ne. l) .and. (j .ne. k) .and. (j .ne. l) .and. (k .ne. l)) then
					current_distance = distanceArray(1,i) + distanceArray(i,j) + distanceArray(j,k) + distanceArray(k,l)
					if (current_distance .lt. shortest_distance) then
						shortest_distance = current_distance
						points = (/i, j, k,l/)
					end if
				end if
			end do
		end do
	end do
end do
call cpu_time(end_time)
write(*,*) "-----------------------------------------------------"
write(*,*) "              Brute Force"
write(*,*) "The shortest distance was ", shortest_distance
write(*,*) "Via the path 1 ", points
write(*,*) "Completed in ", end_time-begin_time, " Seconds"
write(*,*) "-----------------------------------------------------"
					

end subroutine

subroutine ClosestNeighbour(distanceArray)
real(kind=8), dimension(:,:), intent(in) :: distanceArray
integer :: i,j, loc, k
integer, dimension(2) :: max_iterations
real(kind=8), dimension(5) :: distances, totalDistance
integer, dimension(5) :: avalilLocations, locations
real :: time_begin, time_end
call cpu_time(time_begin)
k=1
max_iterations = shape(distanceArray)
avalilLocations = (/1,2,3,4,5/)
do i =1,max_iterations(1)-1
	!distances is an array of distance from the current point to the next possissible locations
	!Distance are set to 10 so when a min search is done, they don't get selected, and only values entered are.
	distances = (/10.0, 10.0, 10.0, 10.0, 10.0/)
	do j = 1,max_iterations(2)
		!our current location doesnt count
		if (k .eq. j) then
			continue
		else
		
			if ( avalilLocations(j) .gt. 0 ) then
				distances(j) = distanceArray(k,j)
			end if 
		end if 
	end do
	!Find the shortest distance, add it to the total distance, and remove the location from the pool
	loc = minloc(distances, DIM=1)
	avalilLocations(loc) = 0
	avalilLocations(1) = 0
	k=loc
	totalDistance = totalDistance + distances(loc)
	locations(i) = loc

end do
call cpu_time(time_end)
write(*,*) "-----------------------------------------------------"
write(*,*) "           Shortest Distance Algoritm"
write(*,*) "The shortets distance found was ", totalDistance(1)
write(*,*) "Via the path 0, ", locations
write(*,*) "Completed in ", time_end-time_begin, " Seconds"
write(*,*) "-----------------------------------------------------"



end subroutine

end program