set terminal png
set output "Finance1.png"

set multiplot layout 1,2

plot "./Data/StockPrices3Day.txt" using 1:2

plot "./Data/StockPrices8Hour.txt" using 1:2

unset multiplot
reset