set terminal pdfcairo enhanced size 8, 4

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Laplace.pdf"

set multiplot layout 1, 2

set xlabel "x"
set ylabel "y"
set xrange [0:1]
set yrange [0:1]
set colorbox border 101
set pm3d map
unset key

set size square

set title "Jacobi method for Laplace equation"

splot "./Data/Laplace.txt" index 0 using 1:2:3 palette

set title "Gauss-Seidel method for Laplace equation"

splot "./Data/Laplace.txt" index 1 using 1:2:3 palette

reset
