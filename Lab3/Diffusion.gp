set terminal pdfcairo enhanced

set output "./Plots/Diffusion.pdf"

set title "Diffusion equation solution"
set xlabel "x"
set ylabel "t"
set pm3d map
set palette gray

splot "./Data/Diffusion.txt" using 1:2:3 palette


reset
