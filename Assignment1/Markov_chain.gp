reset

set terminal pdfcairo enhanced

set output "./Plots/Weather_simulation.pdf"

set title "Weather simulation"
set xlabel "Day number"
set ylabel "Day type"
set xrange[1:110]
set yrange[-0.5:1.5]

plot "./Data/Weather_simulation.txt" with steps title "Markov Chain", 0.666667 with lines lc 3 title "Expected P[Sunny]", "./Data/Weather_simulation_aux.txt" with lines lc 0 title "Calculated P[Sunny]"

reset
