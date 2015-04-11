set terminal pdfcairo enhanced size 8, 4

set style line 1 linewidth 6

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Diffusion.pdf"

set multiplot layout 1, 2

set xlabel "x"
set ylabel "t"
set xrange [0:1]
set yrange [0:0.0535]
set colorbox border 101
set pm3d map
unset key
unset grid

set title "Diffusion equation finite-difference solution"
splot "./Data/Diffusion.txt" using 1:2:3 palette title "stuff"

set title "Diffusion equation analytical solution"
splot "./Data/Diffusion.txt" using 1:2:4 palette title "stuff"

reset

