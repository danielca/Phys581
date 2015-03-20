set terminal png

set output "./Plots/beats.png" 
set title "DFT of Heart Beats"
set yrange [0:40000]
set nokey
set xrange [-20:20]
plot "./Data/beats_fft.txt" using 1:2 with lines

unset out

#----------------------------------------------------------------------
set output "./Plots/solarSpots.png" 
set multiplot layout 2,1 title "Sun spots"

set title "Time serries of the number of sun spots in months"
set nokey
set xrange [1:3143]
set yrange [0:200]
plot "sunspots.txt" using 1:2 with lines

set title "DFT of the sun spots"
set nokey
set xrange [-0.1:0.1]
set yrange [30:100]
plot "./Data/sunspots_fft.txt" using 1:2 with lines

unset multiplot
unset out

#----------------------------------------------------------------------

set output "./Plots/dow_fft.png" 
set multiplot layout 3,1 title "Given Dow Jones"

set title "Dow jones stock prices"
set nokey
set xrange [0:1024]
set yrange [5000:15000]
plot "./Data/dow.txt" using 1:2 with lines

set title "Frequency of Dow Jones Prices"
set nokey
set xrange [-0.5:0.5]
set yrange [50:150]
plot "./Data/dow_fft.txt" using 1:2 with lines

set title "Auto Correlation of Dow Jones"
set nokey
set xrange [0:1024]
set yrange [-1:1]
plot "./Data/dow_auto.txt" using 1:2 with lines

unset multiplot
unset out

#----------------------------------------------------------------------

set output "./Plots/co2_power.png"
set title "Power Spectrum of Carbon Emmision Cycles"
set nokey
set xrange [-0.5:0.5]
set yrange [-10:65]
plot "./Data/co2_power.txt" using 1:2 with lines

unset out

#----------------------------------------------------------------------

set output "./Plots/co2_time.png"
set multiplot layout 2,1

set nokey
set title "Carbon emmisions"
set xrange [0:600]
set yrange [300:400]
plot "./Data/co2_time1.txt" using 1:2 with lines, \
     "./Data/co2_time2.txt" using 1:3 with lines

set title "Carbon emmisons with removed trend"
set nokey
set xrange [0:600]
set yrange [-10:25]
plot "./Data/co2_time2.txt" using 1:2 with lines

unset multiplot
unset out



reset
