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
    "./Data/Test_ran0_svd.txt" using 1:2 with linespoints pt 6 title "ran0", \
    "./Data/Test_ran1_svd.txt" using 1:2 with linespoints pt 6 title "ran1", \
    "./Data/Test_ran2_svd.txt" using 1:2 with linespoints pt 6 title "ran2", \
    "./Data/Test_ran3_svd.txt" using 1:2 with linespoints pt 6 title "ran3", \
    "./Data/Test_ran4_svd.txt" using 1:2 with linespoints pt 6 title "gfortran"

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
    "./Data/Test_ran0_svd.txt" using 1:3 with linespoints pt 6 title "ran0", \
    "./Data/Test_ran1_svd.txt" using 1:3 with linespoints pt 6 title "ran1", \
    "./Data/Test_ran2_svd.txt" using 1:3 with linespoints pt 6 title "ran2", \
    "./Data/Test_ran3_svd.txt" using 1:3 with linespoints pt 6 title "ran3", \
    "./Data/Test_ran4_svd.txt" using 1:3 with linespoints pt 6 title "gfortran"

set terminal png enhanced #size 1280, 960

set output "./Plots/Random_generators_auto_corr.png" 

set title "Auto-correlation of RNG's"
set xlabel "k"
set ylabel "|AC[k]|"
set yrange[1e-6:10]
unset logscale x
set logscale y
set format x '%.0tx10^{%L}'
set format y '10^{%L}'

plot \
    "./Data/Auto_corr_ran0_svd.txt" using 1:2 with lines title "ran0", \
    "./Data/Auto_corr_ran1_svd.txt" using 1:2 with lines title "ran1", \
    "./Data/Auto_corr_ran2_svd.txt" using 1:2 with lines title "ran2", \
    "./Data/Auto_corr_ran3_svd.txt" using 1:2 with lines title "ran3", \
    "./Data/Auto_corr_ran4_svd.txt" using 1:2 with lines title "gfortran"

set output "./Plots/Random_generators_auto_corr_smoothed.png"

set title "Smoothed auto-correlation of RNG's"
set xlabel "k"
set ylabel "|AC[k]|"
set yrange[1e-6:10]
unset logscale x
set logscale y
set format x '%.0tx10^{%L}'
set format y '10^{%L}'

plot \
    "./Data/Auto_corr_ran0_svd.txt" using 1:3 with lines title "ran0", \
    "./Data/Auto_corr_ran1_svd.txt" using 1:3 with lines title "ran1", \
    "./Data/Auto_corr_ran2_svd.txt" using 1:3 with lines title "ran2", \
    "./Data/Auto_corr_ran3_svd.txt" using 1:3 with lines title "ran3", \
    "./Data/Auto_corr_ran4_svd.txt" using 1:3 with lines title "gfortran"

set terminal pdfcairo enhanced size 4, 4

set output "./Plots/White_noise.pdf"
set multiplot layout 2, 1

set origin 0, 0.5
set size 1, 0.5
set title "White noise"
set xlabel "i"
set ylabel "X[i]"
set yrange[-2:2]
unset logscale x
unset logscale y
set format x '%g'
set format y '%g'
unset key

plot \
    "./Data/White_noise.txt" using 1:2 with lines , \

set origin 0, 0
set size 1, 0.5
set title "Autocorrelation of white noise"
set xlabel "k"
set ylabel "|AC[k]|"
set yrange[1e-6:10]
unset logscale x
set logscale y
set format x '%g'
set format y '10^{%L}'
unset key

plot \
    "./Data/White_noise.txt" using 1:3 with lines , \

unset multiplot 

set output "./Plots/White_noise_gaussian.pdf"
set multiplot layout 2, 1

set origin 0, 0.5
set size 1, 0.5
set title "Gaussian white noise"
set xlabel "i"
set ylabel "X[i]"
set yrange[-3:3]
unset logscale x
unset logscale y
set format x '%g'
set format y '%g'
unset key

plot \
    "./Data/White_noise.txt" using 1:4 with lines , \

set origin 0, 0
set size 1, 0.5
set title "Autocorrelation of Gaussian white noise"
set xlabel "k"
set ylabel "|AC[k]|"
set yrange[1e-6:10]
unset logscale x
set logscale y
set format x '%g'
set format y '10^{%L}'
unset key

plot \
    "./Data/White_noise.txt" using 1:5 with lines , \

reset
