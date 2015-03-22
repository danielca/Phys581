set terminal pdfcairo enhanced size 4,4 

set output "./Plots/Square_wave.pdf"

modulus(x) = x - (floor(x/1.0)*1.0)
rect(x) = modulus(x) > 0.5 ? 0.0 : 1.0
sinc(x) = x == 0 ? 1.0 : sin(x)/x

pi = 3.1415926

set multiplot layout 2, 1

set title "Time domain"
set samples 10000
set xrange[-3:3]
set yrange[-0.5:1.5]
set xlabel "t/T"
set ylabel "f(t)"
set nokey

plot rect(x + 0.25)

set title "Fourier coefficients"
set samples 21
set xrange[-10:10]
set yrange[-0.5:1]
set xlabel "n"
set ylabel "c_n"
set nokey

plot sinc(x)/2.0 with points

unset multiplot

set terminal pdfcairo enhanced size 5, 3

set output "./Plots/Time_domain_example.pdf"

set multiplot layout 1, 2

set title "Pure cosine"
set samples 50000
set xrange[-3:3]
set yrange[-1.25:1.25]
set xlabel "t/τ"
set ylabel "f(t)/A"

plot cos(10*pi*x)

set title "Modulated cosine"
set samples 50000
set xrange[-3:3]
set yrange[-1.25:1.25]
set xlabel "t/τ"
set ylabel "f(t)/A"

plot cos(10*pi*x)*exp(-x**2)

unset multiplot

set terminal pdfcairo enhanced size 5, 3

set output "./Plots/Frequency_domain_example.pdf"

set multiplot layout 1, 2

func(x, tau) = ((tau*pi*pi*pi)**(0.5))*(exp(-10*pi*tau*(x - 1.0)**2) + exp(-10*pi*tau*(x + 1.0)**2))

set title "Pure cosine"
set samples 1000
set xrange[-2:2]
set yrange[-1:7]
set xlabel "ω/ω_0"
set ylabel "F(ω)/A"

plot func(x, 1000.0)

set title "Modulated cosine"
set samples 50000
set xrange[-2:2]
set yrange[-1:7]
set xlabel "ω/ω_0"
set ylabel "F(ω)/A"

plot func(x, 1.0)

unset multiplot

set output "./Plots/Exponential_decay_spectrum.pdf"

set title "Exponential decay spectrum"
set samples 50000
set xrange[-10:10]
set yrange[-30:10]
set xlabel "ω"
set ylabel "|F(ω)| (dB)"
set key inside

exp_dec_spec(x, a) = 10.0*log10(1.0/((a**2 + x**2)*2.0*pi))

plot \
    exp_dec_spec(x, 0.5) title "α = 0.5", \
    exp_dec_spec(x, 1.0) title "α = 1.0", \
    exp_dec_spec(x, 2.0) title "α = 2.0", \
    exp_dec_spec(x, 3.0) title "α = 3.0"

set output "./Plots/Circuit_spectrum.pdf"

set title "Circuit spectrum"
set samples 50000
set xrange[-150:150]
set yrange[0:1]
set xlabel "ω (rad/s)"
set ylabel "|F(ω)|^2 μJ*s/rad"
set nokey 

set arrow from 10,0 to 10,1 nohead linestyle 5
set arrow from -10,0 to -10,1 nohead linestyle 5
set arrow from 127.1,0 to 127.1,1 nohead linestyle 3
set arrow from -127.1,0 to -127.1,1 nohead linestyle 3

circuit_spec(x) = 250.0/((100.0 + x**2)*pi) 

plot circuit_spec(x) linestyle 1

set output "./Plots/DFT_example.pdf"

set title "DFT example"
set samples 50000
set xrange[0:10]
set yrange[-5:10]
set xlabel "Time (s)"
set ylabel "Amplitude"
set key outside

plot \
    5 title "0 Hz comp.",\
    2*cos(2*pi*x - pi/2) title "1 Hz comp.", \
    3*cos(4*pi*x) title "2 Hz comp.", \
    5 + 2*cos(2*pi*x - pi/2) + 3*cos(4*pi*x) title "Total signal"

set output "./Plots/DFT_example.pdf"
set title "DFT example"

reset
