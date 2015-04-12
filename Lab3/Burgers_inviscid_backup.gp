set terminal pdfcairo enhanced

set style line 1 linewidth 6

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Burgers_inviscid.pdf"

set xlabel "x"
set ylabel "t"
set xrange [*:*]
set yrange [*:*]
set colorbox border 101
set pm3d map
unset key
unset grid

set title "Burger's equation"
splot "./Data/Burgers_inviscid.txt" index 0 using 1:2:3 palette title "stuff"

reset

