module marcov_chain_module
implicit none

private

public calculate_system

subroutine calcualte_system(intial_vec, prob_mat, num_of_states, final_state)
!calculates the marcov chain, given the intial state, the probability matrix, and the number of calculations
integer, intent(in)::num_of_states
real(kind=8), dimension(:), intent(in)::intial_vec,final_state
real(kind=8), dimension(:), intent(in)::prob_mat
real::dimensions=shape(prob_mat)
real(kind=8),dimension(dimensions(1),dimensions(2))::pn
integer::i


!intial mulitplication
pn=matmul(p,p)
!compute n multiplications
do i=2,num_of_states
   pn=matmul(pn,p)
enddo

!mulitply the vector
final_state=matmul(intial_vec,pn)

end subroutine calculate_system







end module
