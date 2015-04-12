set terminal pdfcairo enhanced size 8, 12
#set terminal pngcairo enhanced size 1200, 1800

set style line 1 linewidth 6

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Burgers_inviscid.pdf"

set multiplot layout 4, 2

set xlabel "x (m)"
set ylabel "t (s)"
set xrange [-1:1]
set yrange [0:1]
set colorbox border 101
set pm3d map
unset key
unset grid

set title "Burger's full solution"
splot "./Data/Burgers_inviscid.txt" index 1 using 1:2:3 palette

set xlabel "x (m)"
set ylabel "u"
set xrange [-1:1]
set yrange [0:0.75]
set grid
set key inside left
unset pm3d

set pointsize 0.6

set title "Burger's initial and final"
plot \
    "./Data/Burgers_inviscid.txt" index 0 using 1:3 lt 11 with lines title "Initial", \
    "./Data/Burgers_inviscid.txt" index 2 using 1:3 lt 12 with lines title "Final"

set xlabel "x (m)"
set ylabel "t (s)"
set xrange [-1:1]
set yrange [0:1]
set colorbox border 101
set pm3d map
unset key
unset grid

set title "Burger's full solution"
splot "./Data/Burgers_inviscid.txt" index 4 using 1:2:3 palette

set xlabel "x (m)"
set ylabel "u"
set xrange [-1:1]
set yrange [0:0.75]
set grid
set key inside
unset pm3d

set pointsize 0.6

set title "Burger's initial and final"
plot \
    "./Data/Burgers_inviscid.txt" index 3 using 1:3 lt 11 with lines title "Initial", \
    "./Data/Burgers_inviscid.txt" index 5 using 1:3 lt 12 with lines title "Final"

set xlabel "x (m)"
set ylabel "t (s)"
set xrange [-1:1]
set yrange [0:1]
set colorbox border 101
set pm3d map
unset key
unset grid

set title "Burger's full solution"
splot "./Data/Burgers_inviscid.txt" index 7 using 1:2:3 palette

set xlabel "x (m)"
set ylabel "u"
set xrange [-1:1]
set yrange [0:0.75]
set grid
set key inside
unset pm3d

set pointsize 0.6

set title "Burger's initial and final"
plot \
    "./Data/Burgers_inviscid.txt" index 6 using 1:3 lt 11 with lines title "Initial", \
    "./Data/Burgers_inviscid.txt" index 8 using 1:3 lt 12 with lines title "Final"

set xlabel "x (m)"
set ylabel "t (s)"
set xrange [-1:1]
set yrange [0:1]
set colorbox border 101
set pm3d map
unset key
unset grid

set title "Burger's full solution"
splot "./Data/Burgers_inviscid.txt" index 10 using 1:2:3 palette

set xlabel "x (m)"
set ylabel "u"
set xrange [-1:1]
set yrange [0:0.75]
set grid
set key inside
unset pm3d

set pointsize 0.6

set title "Burger's initial and final"
plot \
    "./Data/Burgers_inviscid.txt" index 9 using 1:3 lt 11 with lines title "Initial", \
    "./Data/Burgers_inviscid.txt" index 11 using 1:3 lt 12 with lines title "Final"
reset

