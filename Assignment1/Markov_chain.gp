reset

set terminal pdfcairo enhanced

set output "./Plots/Weather_simulation.pdf"

set title "Weather simulation"
set xlabel "State"
set ylabel "Frequency"
set xrange[-1:2]
set yrange[0:1]

plot \
    "./Data/Weather_simulation.txt" using 1:2 with boxes title "Markov Chain" lc 0, \
    "./Data/Weather_simulation.txt" using 1:3 with impulses title "Theoretical" lc 1

set terminal pdfcairo enhanced size 4, 4

set output "./Plots/Square_simulation.pdf"

set multiplot layout 2, 2

set size 0.5, 0.5
set origin 0.0, 0.5
set title "Starting state 1"
set xlabel "State"
set ylabel "Frequency"
set xrange[0:5]
set yrange[0.0:0.5]
unset key

plot \
    "./Data/Square_simulation.txt" using 1:3 with boxes title "Markov Chain" lc 0, \
    "./Data/Square_simulation.txt" using 1:2 with impulses title "Theoretical" lc 1

set size 0.5, 0.5
set origin 0.5, 0.5
set title "Starting state 2"
set xlabel "State"
set ylabel "Fraction Observed"
set xrange[0:5]
set yrange[0.0:0.5]
unset key

plot \
    "./Data/Square_simulation.txt" using 1:3 with boxes title "Markov Chain" lc 0, \
    "./Data/Square_simulation.txt" using 1:2 with impulses title "Theoretical" lc 1

set size 0.5, 0.5
set origin 0.0, 0.0
set title "Starting state 3"
set xlabel "State"
set ylabel "Fraction Observed"
set xrange[0:5]
set yrange[0.0:0.5]
unset key

plot \
    "./Data/Square_simulation.txt" using 1:3 with boxes title "Markov Chain" lc 0, \
    "./Data/Square_simulation.txt" using 1:2 with impulses title "Theoretical" lc 1

set size 0.5, 0.5
set origin 0.5, 0.0
set title "Starting state 4"
set xlabel "State"
set ylabel "Fraction Observed"
set xrange[0:5]
set yrange[0.0:0.5]
unset key

plot \
    "./Data/Square_simulation.txt" using 1:3 with boxes title "Markov Chain" lc 0, \
    "./Data/Square_simulation.txt" using 1:2 with impulses title "Theoretical" lc 1


reset
