reset

set terminal pdfcairo enhanced

set output "./Plots/Ising_energy.pdf"

set title "Ising model internal energy"
set xlabel "Sweep number"
set ylabel "Energy"
set yrange [-2200:0]
set xrange [0:1000]

plot \
    "./Data/Ising_energy.txt" using 1:2 with lines title "T = 1.00", \
    "./Data/Ising_energy.txt" using 1:3 with lines title "T = 2.25", \
    "./Data/Ising_energy.txt" using 1:4 with lines title "T = 2.50", \
    "./Data/Ising_energy.txt" using 1:5 with lines title "T = 3.00"

set output "./Plots/Ising_magnetization.pdf"

set title "Ising model magnetization"
set xlabel "Sweep number"
set ylabel "Magnetization"
set yrange [-1:2]
set xrange[0:2000]

plot \
    "./Data/Ising_magnetization.txt" using 1:2 with lines title "T = 1.00", \
    "./Data/Ising_magnetization.txt" using 1:3 with lines title "T = 2.25", \
    "./Data/Ising_magnetization.txt" using 1:4 with lines title "T = 2.50", \
    "./Data/Ising_magnetization.txt" using 1:5 with lines title "T = 3.00"

set output "./Plots/Ising_mean_energy.pdf"

set title "Ising model mean energy"
set xlabel "Sweep number"
set ylabel "Energy"
set yrange [-2200:0]
set xrange [0:12000]

plot \
    "./Data/Ising_mean_energy.txt" using 1:2 with lines title "T = 1.00", \
    "./Data/Ising_mean_energy.txt" using 1:3 with lines title "T = 2.25", \
    "./Data/Ising_mean_energy.txt" using 1:4 with lines title "T = 2.50", \
    "./Data/Ising_mean_energy.txt" using 1:5 with lines title "T = 3.00"

set output "./Plots/Ising_mean_magnetization.pdf"

set title "Ising model mean magnetization"
set xlabel "Sweep number"
set ylabel "Magnetization"
set yrange [-1:2]
set xrange [0:12000]

plot \
    "./Data/Ising_mean_magnetization.txt" using 1:2 with lines title "T = 1.00", \
    "./Data/Ising_mean_magnetization.txt" using 1:3 with lines title "T = 2.25", \
    "./Data/Ising_mean_magnetization.txt" using 1:4 with lines title "T = 2.50", \
    "./Data/Ising_mean_magnetization.txt" using 1:5 with lines title "T = 3.00"

set output "./Plots/Ising_mean_energy_vs_temp.pdf"

set title "Ising model mean energy"
set xlabel "Temperature"
set ylabel "Mean energy"
set yrange[-2200:0]
set xrange[0.5:3.5]
unset key

plot "./Data/Ising_other.txt" using 1:2 with linespoints pointtype 6

set output "./Plots/Ising_mean_magnetization_vs_temp.pdf"

set title "Ising model mean magnetization"
set xlabel "Temperature"
set ylabel "Mean magnetization"
set yrange[-1:2]
set xrange[0.5:3.5]
set key

plot \
    "./Data/Ising_other.txt" using 1:3 with linespoints pt 6 title "Monte Carlo", \
    "./Data/Ising_other.txt" using 1:4 with lines lc 3 title "Theoretical"
