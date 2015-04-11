set terminal pdfcairo enhanced size 8, 4

set style line 1 linewidth 6

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/AD_combined.pdf"

set multiplot layout 1, 2

set xlabel "x (m)"
set ylabel "t (s)"
set xrange [0:60]
set yrange [0:57]
set colorbox border 101
set pm3d map
unset key
unset grid

set title "Advection-diffusion full solution"
splot "./Data/AD_combined.txt" index 0 using 1:2:3 palette

set xlabel "x (m)"
set ylabel "u"
set xrange [0:60]
set yrange [0:1.2]
set grid
set key inside
unset pm3d

set pointsize 0.6

set title "Advection-diffusion initial and final solution"
plot \
    "./Data/AD_combined.txt" index 1 using 1:2 lt 11 with lines title "t = 0 s", \
    "./Data/AD_combined.txt" index 1 using 1:3 lt 12 with lines title "t = 57 s"

reset

