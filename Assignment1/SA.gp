set terminal pdfcairo

#__________________________________________________________________________________________________
#First Plot
set output "./Plots/SA1.pdf"
set multiplot layout 1,2 title "Simulated Anealing with Temperature 1.0"
unset key
set xrange [-1:1]
set yrange [-0.35:0.1]
set ytics
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
set title "Time serries of the exploration"
plot "./Data/SA_Temp1.txt" using 1:2 with lines ls 2, (x**4) - (x**2) + (0.1*x) w line ls 1

unset key
set xrange [-1:1]
set yrange [0:10]
set title "Histogram of the sampled points"
unset ytics
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
plot "./Data/SA_Hist_T1.txt" using 1:2 linestyle 2 w steps, ((x**4) - (x**2) + (0.1*x))*2+4 w line ls 1 

unset multiplot
unset out


#__________________________________________________________________________________________________
#Second Plot
set output "./Plots/SA04.pdf"
set multiplot layout 1,2 title "Simulated Anealing with Temperature 0.4"
unset key
set xrange [-1:1]
set yrange [-0.35:0.1]
set ytics
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
set title "Time serries of the exploration"
plot "./Data/SA_Temp04.txt" using 1:2 with lines ls 2, (x**4) - (x**2) + (0.1*x) w line ls 1

unset key
set xrange [-1:1]
set yrange [0:40]
set title "Histogram of the sampled points"
unset ytics
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
plot "./Data/SA_Hist_T04.txt" using 1:2 linestyle 2 w steps, ((x**4) - (x**2) + (0.1*x))*12+15 w line ls 1 

unset multiplot
unset out

#__________________________________________________________________________________________________
#Third Plot
set output "./Plots/SA01.pdf"
set multiplot layout 1,2 title "Simulated Anealing with Temperature 0.1"
unset key
set xrange [-1:1]
set yrange [-0.35:0.1]
set ytics
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
set title "Time serries of the exploration"
plot "./Data/SA_Temp01.txt" using 1:2 with lines ls 2, (x**4) - (x**2) + (0.1*x) w line ls 1

unset key
set xrange [-1:1]
set yrange [0:115]
set title "Histogram of the sampled points"
unset ytics
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
plot "./Data/SA_Hist_T01.txt" using 1:2 linestyle 2 w steps, ((x**4) - (x**2) + (0.1*x))*100+50 w line ls 1 

unset multiplot
unset out

#__________________________________________________________________________________________________
#Fourth Plot
set output "./Plots/SA_All.pdf"
set multiplot layout 1,2 title "Simulated Anealing Full Simulation"
unset key
set xrange [-1:1]
set yrange [-0.35:0.1]
set ytics
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
set title "Time serries of the exploration"
plot "./Data/SA_All.txt" using 1:2 with lines ls 2, (x**4) - (x**2) + (0.1*x) w line ls 1

unset key
set xrange [-1:1]
set yrange [0:2]
set title "Histogram of the sampled points"
set ytics
set style line 1 lc rgb '#0025ad' lt 1 lw 1
set style line 2 lc rgb '#09ad00' lt 1 lw 1
plot "./Data/SA_Hist_TAll.txt" using 1:2 linestyle 2 w steps, ((x**4) - (x**2) + (0.1*x))*2+1 w line ls 1 

unset multiplot
unset out







reset
