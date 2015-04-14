set terminal pdfcairo enhanced size 8, 5

set style line 1 linewidth 6

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Burgers_general.pdf"

set multiplot layout 1, 2

set xlabel "x (m)"
set ylabel "u"
set xrange [-1:1]
set yrange [-1.2:1.2]
set grid
set key inside right
unset pm3d

set pointsize 0.6

set title "Burger's equation; Lax-Wendroff non-conservative"
plot \
    "./Data/Burgers_general.txt" index 0 using 1:3 lt 11 with lines title columnheader(1), \
    "./Data/Burgers_general.txt" index 1 using 1:3 lt 12 with lines title columnheader(1), \
    "./Data/Burgers_general.txt" index 2 using 1:3 lt 13 with lines title columnheader(1), \
    "./Data/Burgers_general.txt" index 3 using 1:3 lt 14 with lines title columnheader(1), \
    "./Data/Burgers_general.txt" index 4 using 1:3 lt 15 with lines title columnheader(1)

set title "Burger's equation; Lax-Wendroff conservative"
plot \
    "./Data/Burgers_general.txt" index 5 using 1:3 lt 11 with lines title columnheader(1), \
    "./Data/Burgers_general.txt" index 6 using 1:3 lt 12 with lines title columnheader(1), \
    "./Data/Burgers_general.txt" index 7 using 1:3 lt 13 with lines title columnheader(1), \
    "./Data/Burgers_general.txt" index 8 using 1:3 lt 14 with lines title columnheader(1), \
    "./Data/Burgers_general.txt" index 9 using 1:3 lt 15 with lines title columnheader(1)


reset

