reset
set terminal pdfcairo enhanced

set output "./Plots/Random_generators_mean.pdf"

set title "Mean error for RNG's"
set xlabel "Sample size"
set ylabel "Error in mean"
set yrange[1e-6:1]
set logscale x
set logscale y
set format x '10^{%L}'
set format y '10^{%L}'

plot \
    "./Data/Test_ran0.txt" using 1:2 with linespoints pt 6 title "ran0", \
    "./Data/Test_ran1.txt" using 1:2 with linespoints pt 6 title "ran1", \
    "./Data/Test_ran2.txt" using 1:2 with linespoints pt 6 title "ran2", \
    "./Data/Test_ran3.txt" using 1:2 with linespoints pt 6 title "ran3", \
    "./Data/Test_ran4.txt" using 1:2 with linespoints pt 6 title "gfortran"

set output "./Plots/Random_generators_std_dev.pdf"

set title "Standard deviation error for RNG's"
set xlabel "Sample size"
set ylabel "Error in Std. Dev."
set yrange[1e-6:1]
set logscale x
set logscale y
set format x '10^{%L}'
set format y '10^{%L}'

plot \
    "./Data/Test_ran0.txt" using 1:3 with linespoints pt 6 title "ran0", \
    "./Data/Test_ran1.txt" using 1:3 with linespoints pt 6 title "ran1", \
    "./Data/Test_ran2.txt" using 1:3 with linespoints pt 6 title "ran2", \
    "./Data/Test_ran3.txt" using 1:3 with linespoints pt 6 title "ran3", \
    "./Data/Test_ran4.txt" using 1:3 with linespoints pt 6 title "gfortran"

set output "./Plots/Random_generators_auto_corr.pdf"

set title "Auto-correlation of RNG's"
set xlabel "k"
set ylabel "AC(k)"
set yrange[1e-6:10]
unset logscale x
set logscale y
set format x '%.0tx10^{%L}'
set format y '10^{%L}'

plot \
    "./Data/Auto_corr_ran0.txt" using 1:2 with points pt 0 title "ran0", \
    "./Data/Auto_corr_ran1.txt" using 1:2 with points pt 0 title "ran1", \
    "./Data/Auto_corr_ran2.txt" using 1:2 with points pt 0 title "ran2", \
    "./Data/Auto_corr_ran3.txt" using 1:2 with points pt 0 title "ran3", \
    "./Data/Auto_corr_ran4.txt" using 1:2 with points pt 0 title "gnuplot"

set output "./Plots/Random_generators_auto_corr_smoothed.pdf"

set title "Smoothed auto-correlation of RNG's"
set xlabel "k"
set ylabel "AC(k)"
set yrange[1e-6:10]
unset logscale x
set logscale y
set format x '%.0tx10^{%L}'
set format y '10^{%L}'

plot \
    "./Data/Auto_corr_ran0.txt" using 1:3 with lines title "ran0", \
    "./Data/Auto_corr_ran1.txt" using 1:3 with lines title "ran1", \
    "./Data/Auto_corr_ran2.txt" using 1:3 with lines title "ran2", \
    "./Data/Auto_corr_ran3.txt" using 1:3 with lines title "ran3", \
    "./Data/Auto_corr_ran4.txt" using 1:3 with lines title "gnuplot"

reset
