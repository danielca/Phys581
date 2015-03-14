set terminal pdfcairo enhanced size 6, 4

set output "./Plots/Warm_up.pdf"

set multiplot

set size 0.5, 0.5
set origin 0.0, 0.5
set title "Two sinusoids"
set xlabel "Frequency (Hz)"
set ylabel "Signal power (dB)"
set xrange [-512:512]
unset key

plot "./Data/Warm_up.txt" using 1:2 with lines

set origin 0.5, 0.5
set title "Two sinusoids"
set xlabel "Frequency (Hz)"
set ylabel "Signal power (dB)"
set xrange [-512:512]
unset key

plot "./Data/Warm_up.txt" using 1:3 with lines

set size 0.5, 0.5
set origin 0.0, 0.0
set title "Amplitude modulation"
set xlabel "Frequency (Hz)"
set ylabel "Signal power (dB)"
set xrange [-512:512]
unset key

plot "./Data/Warm_up.txt" using 1:4 with lines

set size 0.5, 0.5
set origin 0.5, 0.0
set title "Frequency modulation"
set xlabel "Frequency (Hz)"
set ylabel "Signal power (dB)"
set xrange [-512:512]
unset key

plot "./Data/Warm_up.txt" using 1:5 with lines

unset multiplot

set terminal pngcairo enhanced size 1120, 480

set output "./Plots/My_voice.png"

set multiplot

set size 0.5, 1.0
set origin 0.5, 0.0
set title "My voice spectrum"
set xlabel "Frequency (Hz)"
set ylabel "Signal power (dB)"
set xrange [-32768:32768]
unset key

plot "./Data/myself-fft.dat" using 1:2 every 1 with lines

set size 0.5, 1.0
set origin 0.0, 0.0
set title "My voice time domain"
set xlabel "Time (s)"
set ylabel "Signal"
set xrange [0:10]
set yrange [-1.25:1.25]
unset key

plot "./Data/myself.dat" using 1:2 every 1 with lines


reset
