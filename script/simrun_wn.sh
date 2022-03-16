if [ -z "$1" ]
then
	echo "simrun_rpr.sh: no arguments are given"
	exit
fi

mkdir ~/rpr_log/run_wn
for ((run_count=12; run_count<13; run_count++));
do
time ./simrun_rl_l.sh water_nsquared $1 16 &
wait
mv ~/rpr_log/water_nsquared*.log ~/rpr_log/run_wn/
done
