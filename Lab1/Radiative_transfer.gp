reset
set terminal pdfcairo

set output "./Plots/Tau_histogram.pdf"

set title "Tau histogram"
set xlabel "tau"
set ylabel ""
unset key

plot "./Data/Tau_histogram.txt" with boxes

set output "./Plots/Mu_histogram.pdf"

set title "Mu histogram"
set xlabel "mu"
set ylabel ""
set xrange[-1:1]
set yrange[0:12000]
unset key

plot "./Data/Mu_histogram.txt" with boxes

set output "./Plots/Phi_histogram.pdf"

set title "Phi histogram"
set xlabel "phi"
set ylabel ""
set xrange[0:6.3]
set yrange[0:12000]
unset key

plot "./Data/Phi_histogram.txt" with boxes

set output "./Plots/Theta_histogram.pdf"

set title "Theta histogram"
set xlabel "theta"
set ylabel ""
set xrange[0:3.2]
set yrange[0:17000]
unset key

plot "./Data/Theta_histogram.txt" with boxes

reset
