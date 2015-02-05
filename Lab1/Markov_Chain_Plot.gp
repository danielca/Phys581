set terminal pdfcairo
set output "./Plots/Markov_Sunny_Day.pdf"
#set terminal x11
set multiplot layout 2,1 title "Marcov chain with a Sunny Day Start"
unset key
set title "Probability of a Sunny Day"
set xrange [0:100]
set yrange [0:1]
set ylabel "Probability"
plot "./Data/MarcovSunny1.txt" using 2:1 with lines

set title "Probabilty of a Rainny Day"
set xrange [0:100]
set yrange [0:1]
set xlabel "Trials"
unset key
plot "./Data/MarcovRainy1.txt" using 2:1 with lines

unset multiplot
unset out

set output "./Plots/Markov_Rainy_Day.pdf"
#set terminal x11
set multiplot layout 2,1 title "Marcov chain with a Rainy Day Start"
unset key
set title "Probability of a Sunny Day"
set xrange [0:100]
set yrange [0:1]
set ylabel "Probability"
plot "./Data/MarcovSunny2.txt" using 2:1 with lines

set title "Probabilty of a Rainny Day"
set xrange [0:100]
set yrange [0:1]
set xlabel "Trials"
unset key
plot "./Data/MarcovRainy2.txt" using 2:1 with lines

unset multiplot
unset out