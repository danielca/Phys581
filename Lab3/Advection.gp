 set terminal pdfcairo enhanced
 
 set output "./Plots/Advection.pdf"
 
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   0 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   1 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   2 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   3 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   4 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   5 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   6 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   7 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   8 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index   9 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  10 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  11 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  12 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  13 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  14 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  15 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  16 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  17 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  18 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  19 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  20 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  21 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  22 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  23 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 1, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  24 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 1, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  25 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 1, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  26 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 1, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [  -1.2000000476837158      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  27 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  28 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  29 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  30 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  31 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  32 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  33 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  34 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  35 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  36 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  37 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  38 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  39 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  40 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  41 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  42 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  43 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  44 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  45 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  46 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  47 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  48 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  49 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  50 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  51 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 2, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  52 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 2, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  53 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 2, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  54 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 2, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  55 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   24.999999999999979      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  56 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   24.999999999999979      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  57 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   24.999999999999979      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  58 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   24.999999999999979      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  59 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  60 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  61 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  62 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  63 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   72.992700729926767      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  64 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   72.992700729926767      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  65 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   72.992700729926767      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  66 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   72.992700729926767      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  67 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   99.009900990099027      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  68 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   99.009900990099027      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  69 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   99.009900990099027      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  70 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   99.009900990099027      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  71 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   101.01010101010081      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  72 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   101.01010101010081      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  73 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   101.01010101010081      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  74 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   101.01010101010081      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  75 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  76 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  77 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  78 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  79 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 3, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  80 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 3, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  81 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 3, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  82 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 3, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   49.999999999999957      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  83 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  84 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  85 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  86 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 1"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  87 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  88 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  89 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  90 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 2"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  91 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  92 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  93 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  94 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 3"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  95 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  96 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  97 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  98 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 4"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index  99 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 100 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 101 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 102 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 5"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 103 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 104 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 105 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 106 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 6"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 107 using 1:2:3 palette
 
 
 set title "Advection: Forward Euler, Initial Condition 4, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 108 using 1:2:3 palette
 
 
 set title "Advection: Lax-Wendroff, Initial Condition 4, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 109 using 1:2:3 palette
 
 
 set title "Advection: Backward Euler, Initial Condition 4, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 110 using 1:2:3 palette
 
 
 set title "Advection: Crank-Nicolson, Initial Condition 4, Trial 7"
 set xlabel "x"
 set ylabel "t"
 set pm3d map
 set palette gray
 set cbrange [ -0.20000000298023224      :   1.2000000476837158      ]
 unset key
 unset grid
 
 splot "./Data/Advection.txt" index 111 using 1:2:3 palette
 
 reset
 
