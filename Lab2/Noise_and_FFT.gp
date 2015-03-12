set terminal pdfcairo enhanced size 4, 4

set output "./Plots/White_noise_uniform.pdf"

set multiplot

set title "Uniform white noise autocorrelation"

set size 1.0, 0.5
set origin 0.0, 0.5
set xrange[-100:8192]
set xlabel "k"
set ylabel "AC[k]"
set logscale y
unset key

plot "./Data/White_noise.txt" index 0 with lines

set title "Uniform white noise spectral density"

set origin 0.0, 0.0
set xrange[-3.14:3.14]
set xlabel "ω"
set ylabel "S(ω) (dB)"
unset logscale y
plot "./Data/White_noise.txt" index 1 with lines

unset multiplot

set output "./Plots/White_noise_gaussian.pdf"

set multiplot

set title "Gaussian white noise autocorrelation"

set size 1.0, 0.5
set origin 0.0, 0.5
set xrange[-100:8192]
set xlabel "k"
set ylabel "AC[k]"
set logscale y
unset key

plot "./Data/White_noise.txt" index 2 with lines

set title "Gaussian white noise spectral density"

set origin 0.0, 0.0
set xrange[-3.14:3.14]
set xlabel "ω"
set ylabel "S(ω) (dB)"
unset logscale y
plot "./Data/White_noise.txt" index 3 with lines

unset multiplot

set output "./Plots/Noise_reduction.pdf"

set multiplot

set origin 0.0, 0.5
set title "Time domain signals"
set xrange[0:0.012]
set xlabel "Time (s)"
set ylabel ""

plot \
    "./Data/Noise_reduction.txt" index 0 using 1:2 title "No noise" with lines lc 1, \
    "./Data/Noise_reduction.txt" index 0 using 1:3 title "Noise" with lines lc 3, \
    "./Data/Noise_reduction.txt" index 0 using 1:4 title "Cleaned" with lines lc 4

set origin 0.0, 0.0
set title "Frequency domain signals"
set xrange[-22500:22500]
set xlabel "Frequency (Hz)"
set ylabel ""

plot \
    "./Data/Noise_reduction.txt" index 1 using 1:2 title "No noise" with lines lc 1, \
    "./Data/Noise_reduction.txt" index 1 using 1:3 title "Noise" with lines lc 3, \
    "./Data/Noise_reduction.txt" index 1 using 1:4 title "Cleaned" with lines lc 4


reset
