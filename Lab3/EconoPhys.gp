set terminal pdfcairo size 8, 8

set loadpath '../Gnuplot_stuff/'
load 'parula.pal'
load 'my_config.cfg'

set output "./Plots/Stock.pdf"
set nokey
set multiplot layout 3,2
set xrange[0:20]
set yrange[0:10]
set xlabel "S"
set ylabel "V"
set ytics(0,2,4, 6, 8, 10)
set xtics(0,4,8, 12, 16, 20)

set title "Stock at t=100"
plot "./Data/stock_100.txt" using 1:2 with lines

set title "Stock at t=85"
#set yrange [0:15]
plot "./Data/stock_85.txt" using 1:2 with lines

set title "Stock at t=75"
#set yrange [0:15]
plot "./Data/stock_75.txt" using 1:2 with lines

#unset multiplot
#unset out
#
#set terminal pdfcairo size 4, 6
#set output "./Plots/Stock2.pdf"
#set multiplot layout 2,1
#set nokey
##set xrange [2:20]
##set yrange [0:15]
#
set title "Stock at t=50"
plot "./Data/stock_50.txt" using 1:2 with lines

set title "Stock at t=0.0"
#set yrange [0:15]
plot "./Data/stock_00.txt" using 1:2 with lines

