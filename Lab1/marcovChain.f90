program marcovChain
implicit none

call SunnyRainyCalculation()


contains

subroutine SunnyRainyCalculation()
  !This subroutine is meant to calculate the sunny ranny day senerio
  !There is a subroutine in the marcov_chain_module, however things needed
  !to be written to file, so here is the hardcoded situation for the lab
  real(kind=8),dimension(2,2)::prob_mat,pn
  real(kind=8),dimension(2)::init_vec,fin_vec
  integer::i,iterations=100
  prob_mat = reshape((/ 0.9, 0.1, 0.5, 0.5 /),shape(prob_mat))

  !for the first initial vec
  init_vec = (1,0)
  open(unit=42, file="./Data/MarcovSunny1.txt", action="write")
  open(unit=43, file="./Data/MarcovRainy1.txt", action="write")
  !write the initial values
  write(42,*) init_vec(1), 0
  write(43,*) fin_vec(2), 0

  !multiply the probability matrix
  !initial muliplication
  pn=matmul(prob_mat,prob_mat)
  fin_vec=matmul(pn,init_vec)
  write(42,*) fin_vec(1), 1
  write(43,*) fin_vec(2), 1
  !FINISH IT
  do i=2,iterations
     pn=matmul(pn,prob_mat)
     fin_vec=matmul(pn,fin_vec)
     write(42,*) fin_vec(1), i
     write(43,*) fin_vec(2), i
  enddo

  close(42)
  close(43)


  !second set of initial values
  init_vec = (0,1)
  open(unit=42, file="./Data/MarcovSunny2.txt", action="write")
  open(unit=43, file="./Data/MarcovRainy2.txt", action="write")
  !write the initial values
  write(42,*) init_vec(1), 0
  write(43,*) fin_vec(2), 0

  !multiply the probability matrix
  !initial muliplication
  pn=matmul(prob_mat,prob_mat)
  fin_vec=matmul(pn,init_vec)
  write(42,*) fin_vec(1), 1
  write(43,*) fin_vec(2), 1
  !FINISH IT
  do i=2,iterations
     pn=matmul(pn,prob_mat)
     fin_vec=matmul(pn,fin_vec)
     write(42,*) fin_vec(1), i
     write(43,*) fin_vec(2), i
  enddo

  close(42)
  close(43)

end subroutine

end program
