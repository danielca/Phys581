module Markov_chain_module
implicit none

private

public calculate_system
contains 


subroutine calculate_system(intial_vec, prob_mat, num_of_states, final_state)
!calculates the marcov chain, given the intial state, the probability matrix, and the number of calculations
integer, intent(in)::num_of_states
real(kind=8), dimension(:), intent(in)::intial_vec,final_state
real(kind=8), dimension(:), intent(in)::prob_mat
integer, dimension(2)::dimensions
real(kind=8),dimension(:,:), allocatable::pn
integer::i

write(*,*) "test"
!dimesnions = shape(prob_mat)
!allocate(pn(dimensions(1),dimensions(2)))


!intial mulitplication
!pn=matmul(p,p)
!!compute n multiplications
!do i=2,num_of_states
!   pn=matmul(pn,p)
!enddo

!mulitply the vector
!final_state=matmul(intial_vec,pn)

!deallocate(pn)

end subroutine calculate_system

end module
