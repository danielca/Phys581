reset
set terminal pdfcairo

set output "./Plots/Tau_histogram.pdf"

set title "Tau histogram"
set xlabel "tau"
set ylabel ""
set xrange[0:10]
set yrange[0:1]
unset key

plot "./Data/Tau_histogram.txt" with boxes

set output "./Plots/Mu_histogram.pdf"

set title "Mu histogram"
set xlabel "mu"
set ylabel ""
set xrange[-1:1]
set yrange[0:0.6]
unset key

plot "./Data/Mu_histogram.txt" with boxes

set output "./Plots/Phi_histogram.pdf"

set title "Phi histogram"
set xlabel "phi"
set ylabel ""
set xrange[0:6.3]
set yrange[0:0.2]
unset key

plot "./Data/Phi_histogram.txt" with boxes

set output "./Plots/Theta_histogram.pdf"

set title "Theta histogram"
set xlabel "theta"
set ylabel ""
set xrange[0:3.2]
set yrange[0:0.55]
unset key

plot "./Data/Theta_histogram.txt" with boxes

set output "./Plots/Scattering_experiment_1.pdf"

set title "Intensity distribution with no absorption"
set xlabel "theta (deg)"
set ylabel "Normalized intensity"
set xrange[0:90]
set yrange[0:1.7]
set key

plot \
"./Data/Scattering_experiment_1.txt" using 1:3 with points title "Monte Carlo", \
"./Data/Scattering_experiment_1.txt" using 1:4 with lines lc 0 title "Theoretical"

set output "./Plots/Scattering_experiment_2.pdf"

set title "Intensity distribution with absorption"
set xlabel "theta (deg)"
set ylabel "Normalized intensity"
set xrange[0:90]
set yrange[0:3.0]
set key

plot \
"./Data/Scattering_experiment_2.txt" using 1:3 with points title "Monte Carlo"

reset
