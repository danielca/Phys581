set terminal png
set output "Finance1.png"

set multiplot layout 1,2
unset key
set xtics ("0" 0,"1" 10, "2" 20, "3" 30, "4" 40, "5" 50, "6" 60, "7" 70 , "8" 80, "9" 90,"10" 100 ,"11" 110 , "12" 120)
set title "Estimated Stock Prices 3 Day Interval"
plot "./Data/StockPrices3Day.txt" using 1:2 with lines

unset key

set title "Estimated Stock Prices 8 Hour Interval"
set xtics ("0" 0,"1" 38, "2" 76, "3" 114, "4" 152, "5" 190, "6" 228, "7" 266, "8" 304, "9" 342,"10" 380 ,"11" 418 , "12" 455)
plot "./Data/StockPrices8Hour.txt" using 1:2 with lines

unset multiplot
reset