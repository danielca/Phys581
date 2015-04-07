set terminal pdfcairo enhanced

set output "./Plots/Diffusion.pdf"

set title "Diffusion equation solution"
set xlabel "x"
set ylabel "t"
set xrange [0:1]
set yrange [0:0.0535]
set pm3d map
set palette gray
unset key

splot "./Data/Diffusion.txt" using 1:2:3 palette


reset
