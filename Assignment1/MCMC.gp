reset

set terminal pdfcairo enhanced

set output "./Plots/Simple_random_walk.pdf"

set title "Simple random walk"
set xlabel "x"
set ylabel "PDF"
set xrange[-200:200]
unset key

plot "./Data/Simple_random_walk.txt" with boxes

set output "./Plots/Metropolis_Gauss_distribution.pdf"

set title "Gaussian distribution using Metropolis method"
set xrange[-5:5]
set xlabel "x"
set ylabel "PDF"
unset key

plot "./Data/Metropolis_Gauss_distribution.txt" with boxes, (sqrt(0.4)/sqrt(2*3.14159265))*exp(-0.2*x*x) with lines lc 3

set output "./Plots/Metropolis_Gauss_mean.pdf"

set title "Mean of Metropolis sequence"
set xlabel "i"
set ylabel "Mean"
set xrange[0:5000]
set yrange[-1.5:1.5]
unset key

plot "./Data/Metropolis_Gauss_mean.txt" with lines, 0 with lines lc 3


reset
