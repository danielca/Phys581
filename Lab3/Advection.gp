 set terminal pdfcairo enhanced size 5, 3
 
 set loadpath "../Gnuplot_stuff"
 load "parula.pal"
 load "my_config.cfg"
 
 set output "./Plots/Advection.pdf"
 
 
 set size 1, 0.9
 set origin 0, 0.1
 
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set xrange [-2:2]
 set yrange [0:2]
 unset key
 unset grid
 
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 1"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.815    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   0 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 1"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.225    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   1 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 1"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.718    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   2 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 1"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.765    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   3 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 2"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =     149.    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   4 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 2"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.178    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   5 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 2"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.714    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   6 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 2"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.761    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   7 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 3"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.139E+11" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   8 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 3"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.167    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index   9 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 3"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.714    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  10 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 3"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.760    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  11 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 4"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.408E+21" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  12 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 4"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.165    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  13 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 4"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.710    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  14 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 4"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.756    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  15 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 5"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.275E+22" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  16 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 5"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.165    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  17 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 5"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.710    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  18 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 5"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.756    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  19 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 6"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.801    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  20 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 6"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.196    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  21 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 6"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.737    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  22 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 6"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.761    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  23 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 7"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.227E+08" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  24 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 7"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.166    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  25 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 7"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.670    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  26 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 7"
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.761    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  27 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 1"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.699    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  28 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 1"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.508    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  29 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 1"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.527    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  30 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 1"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.500    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  31 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 2"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.321E+07" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  32 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 2"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.505    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  33 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 2"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.528    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  34 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 2"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.500    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  35 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 3"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.118E+16" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  36 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 3"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.504    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  37 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 3"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.528    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  38 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 3"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.500    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  39 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 4"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.965E+26" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  40 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 4"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.501    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  41 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 4"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.528    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  42 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 4"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.500    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  43 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 5"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.692E+27" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  44 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 5"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.586E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  45 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 5"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.528    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  46 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 5"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.500    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  47 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 6"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =     163.    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  48 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 6"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.505    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  49 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 6"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.520    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  50 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 6"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.500    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  51 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 7"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.650E+12" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  52 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 7"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.500    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  53 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 7"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.540    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  54 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 7"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.500    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  55 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 1"
 set cbrange [ -0.20000000298023224      :   24.999999999999979      ]
 set label "ΔE_{rel} =     104.    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  56 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 1"
 set cbrange [ -0.20000000298023224      :   24.999999999999979      ]
 set label "ΔE_{rel} =   -0.728    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  57 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 1"
 set cbrange [ -0.20000000298023224      :   24.999999999999979      ]
 set label "ΔE_{rel} =   -0.761    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  58 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 1"
 set cbrange [ -0.20000000298023224      :   24.999999999999979      ]
 set label "ΔE_{rel} =   -0.546E-15" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  59 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 2"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =    0.625E+09" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  60 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 2"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =   -0.800    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  61 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 2"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =   -0.886    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  62 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 2"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =    0.131E-13" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  63 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 3"
 set cbrange [ -0.20000000298023224      :   72.992700729926767      ]
 set label "ΔE_{rel} =    0.339E+18" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  64 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 3"
 set cbrange [ -0.20000000298023224      :   72.992700729926767      ]
 set label "ΔE_{rel} =   -0.814    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  65 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 3"
 set cbrange [ -0.20000000298023224      :   72.992700729926767      ]
 set label "ΔE_{rel} =   -0.922    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  66 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 3"
 set cbrange [ -0.20000000298023224      :   72.992700729926767      ]
 set label "ΔE_{rel} =    0.341E-14" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  67 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 4"
 set cbrange [ -0.20000000298023224      :   99.009900990099027      ]
 set label "ΔE_{rel} =    0.378E+29" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  68 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 4"
 set cbrange [ -0.20000000298023224      :   99.009900990099027      ]
 set label "ΔE_{rel} =   -0.627    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  69 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 4"
 set cbrange [ -0.20000000298023224      :   99.009900990099027      ]
 set label "ΔE_{rel} =   -0.943    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  70 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 4"
 set cbrange [ -0.20000000298023224      :   99.009900990099027      ]
 set label "ΔE_{rel} =    0.115E-13" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  71 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 5"
 set cbrange [ -0.20000000298023224      :   101.01010101010081      ]
 set label "ΔE_{rel} =    0.277E+30" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  72 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 5"
 set cbrange [ -0.20000000298023224      :   101.01010101010081      ]
 set label "ΔE_{rel} =     432.    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  73 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 5"
 set cbrange [ -0.20000000298023224      :   101.01010101010081      ]
 set label "ΔE_{rel} =   -0.944    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  74 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 5"
 set cbrange [ -0.20000000298023224      :   101.01010101010081      ]
 set label "ΔE_{rel} =   -0.144E-13" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  75 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 6"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =    0.310E+05" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  76 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 6"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =   -0.774    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  77 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 6"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =   -0.837    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  78 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 6"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =   -0.236E-14" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  79 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 7"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =    0.127E+15" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  80 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 7"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =     0.00    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  81 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 7"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =   -0.919    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  82 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 7"
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 set label "ΔE_{rel} =   -0.127E-14" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  83 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 1"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.422E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  84 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 1"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.206E-03" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  85 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 1"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.375E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  86 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 1"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.875E-09" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  87 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 2"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.425E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  88 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 2"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.682E-04" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  89 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 2"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.377E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  90 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 2"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.779E-09" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  91 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 3"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.129    " at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  92 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 3"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.526E-04" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  93 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 3"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.377E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  94 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 3"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.106E-08" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  95 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 4"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.214E+10" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  96 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 4"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.349E-04" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  97 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 4"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.377E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  98 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 4"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.763E-09" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index  99 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 5"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.144E+11" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 100 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 5"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.344E-04" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 101 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 5"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.377E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 102 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 5"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.763E-09" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 103 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 6"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.206E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 104 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 6"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.493E-04" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 105 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 6"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.194E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 106 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 6"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.777E-09" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 107 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 7"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =    0.907E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 108 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 7"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.373E-04" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 109 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 7"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.713E-01" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 110 using 1:2:3 palette
 
 unset label
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 7"
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 set label "ΔE_{rel} =   -0.788E-09" at -2.2, -0.5 textcolor rgb "#404040"
 
 splot "./Data/Advection.txt" index 111 using 1:2:3 palette
 
 unset label
 
 reset
 
