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
set yrange[0:12000]
unset key

plot "./Data/Mu_histogram.txt" with boxes

set output "./Plots/Phi_histogram.pdf"

set title "Phi histogram"
set xlabel "phi"
set ylabel ""
set yrange[0:12000]
unset key

plot "./Data/Phi_histogram.txt" with boxes

reset
