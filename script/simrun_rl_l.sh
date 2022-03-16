#!/bin/bash

#Description : Runs Simulation with different Size and Policy

#Argument : [TARGET]

TARGET="$1"
POLICY="$2"
#SIMDIR="/home/dcslab/rlapr/sim/sim"
SIMDIR="/home/dcslab/git_rpr/rpr/sim/sim"
MEDIUM_INPUTDIR="/home/dcslab/git_rpr/rpr/traces2/simmedium"
LARGE_INPUTDIR="/home/dcslab/git_rpr/rpr/traces/simlarge"
LOG_DIR="/home/dcslab/rpr_log"

SEQ_SIMDIR="/home/dcslab/APR/pose-tools-master/sim/sim"

if [ -n "$2" ]
then
	POLICY="$2"
	NAME="$2"
else
	POLICY=("opt" "clock" "clock-pro" "seq" "alifo")
	NAME="ALL"
fi

if [ "$2" = "ALL" ];
then
	POLICY=("clock" "clock-pro" "seq" "alifo" "opt")
	NAME="ALL"
fi

#SIMDIR=$SEQ_SIMDIR

SIZE_cholesky=("4000" "6250" "8500" "10750" "13000" "15250" "17500" "19750" "22000" "24250" "26500" "28750" "31000" "33250" "35500" "37750")
SIZE_fft=("125000" "170000" "215000" "260000" "305000" "350000" "395000" "440000" "485000" "530000" "575000" "620000" "665000" "710000" "755000")
SIZE_lu_cb=("3000" "5000" "7000" "9000" "11000" "13000" "15000" "17000" "19000" "21000" "23000" "25000" "27000" "29000" "31000" "33000")
SIZE_lu_ncb=("900" "1800" "2700" "3600" "4500" "5400" "6300" "7200" "8100" "9000")
SIZE_ocean_cp=("500000" "528125" "556250" "584375" "612500" "640625" "668750" "696875" "725000" "753125" "781250" "809375" "837500" "865625" "893750" "921875")
SIZE_ocean_ncp=("700000" "731250" "762500" "793750" "825000" "856250" "887500" "918750" "950000" "981250" "1012500" "1043750" "1075000" "1106250" "1137500" "1168750")
SIZE_radiosity=("7000" "14000" "21000" "28000" "35000" "42000" "49000" "56000" "63000" "70000")
#SIZE_radix=("100000" "159375" "218750" "278125" "337500" "396875" "456250" "515625" "575000" "634375" "693750" "753125" "812500" "871875" "931250" "990625" "1050000")
SIZE_radix=("105000" "115000" "125000" "135000" "145000" "155000" "165000" "175000" "185000" "195000" "205000" "215000" "225000" "235000" "245000" "255000")
SIZE_raytrace=("700" "1400" "2100" "2800" "3500" "4200" "4900" "5600" "6300" "7000")
SIZE_volrend=("1500" "1593" "1686" "1779" "1872" "1965" "2058" "2151" "2244" "2337" "2430" "2523" "2616" "2709" "2802" "2895" "2988")
SIZE_water_nsquared=("200" "281" "362" "443" "524" "605" "686" "767" "848" "929" "1010" "1091" "1172" "1253" "1334" "1415" "1496")
SIZE_water_spatial=("700" "1400" "2100" "2800" "3500" "4200" "4900" "5600" "6300" "7000")

case "${TARGET}" in
	"cholesky" )
		SIZE=${SIZE_cholesky[*]}
		INPUT=$MEDIUM_INPUTDIR/${TARGET}_m.out
		TARGET=${TARGET}_m
		;;
	"fft" )
		SIZE=${SIZE_fft[*]}
		INPUT=$LARGE_INPUTDIR/${TARGET}_l.out
		TARGET=${TARGET}_l
		;;
	"lu_cb" )
		SIZE=${SIZE_lu_cb[*]}
		INPUT=$LARGE_INPUTDIR/${TARGET}_l.out
		TARGET=${TARGET}_l
		;;
	"lu_ncb" )
		SIZE=${SIZE_lu_ncb[*]}
		INPUT=$MEDIUM_INPUTDIR/${TARGET}_m.out
		TARGET=${TARGET}_m
		;;
	"radix" )
		SIZE=${SIZE_radix[*]}
		INPUT=$MEDIUM_INPUTDIR/${TARGET}_m.out
		TARGET=${TARGET}_m
		;;
	"ocean_cp" )
		SIZE=${SIZE_ocean_cp[*]}
		INPUT=$LARGE_INPUTDIR/${TARGET}_l.out
		TARGET=${TARGET}_l
		;;
	"ocean_ncp" )
		SIZE=${SIZE_ocean_ncp[*]}
		INPUT=$LARGE_INPUTDIR/${TARGET}_l.out
		TARGET=${TARGET}_l
		;;
	"radiosity" )
		SIZE=${SIZE_radiosity[*]}
		INPUT=$MEDIUM_INPUTDIR/${TARGET}_m.out
		TARGET=${TARGET}_m
		;;
	"raytrace" )
		SIZE=${SIZE_raytrace[*]}
		INPUT=$MEDIUM_INPUTDIR/${TARGET}_m.out
		TARGET=${TARGET}_m
		;;
	"volrend" )
		SIZE=${SIZE_volrend[*]}
		INPUT=$LARGE_INPUTDIR/${TARGET}_l.out
		TARGET=${TARGET}_l
		;;
	"water_nsquared" )
		SIZE=${SIZE_water_nsquared[*]}
		INPUT=$MEDIUM_INPUTDIR/${TARGET}_m.out
#		INPUT=$LARGE_INPUTDIR/${TARGET}_l.out
#		INPUT="/home/dcslab/git_rpr/rpr/traces3/water_nsquared_l.out"
		TARGET=${TARGET}_m
		;;
	"water_spatial" )
		SIZE=${SIZE_water_spatial[*]}
		INPUT=$MEDIUM_INPUTDIR/${TARGET}_m.out
		TARGET=${TARGET}_m
		;;
	*)
		echo "Target Error!"
		exit 1;;
esac


echo "$SIZE"

DATE=$(date '+%d%m%Y_%H%M%S')
echo "$DATE"
echo "$POLICY[*]"
echo "$NAME"

LOG=$LOG_DIR/${TARGET}.$NAME.$DATE.$3.log
touch $LOG

for pol_item in ${POLICY[*]}
do
	if [ $pol_item = "seq" ]
	then
		TARGET_SIM=$SEQ_SIMDIR
	else
		TARGET_SIM=$SIMDIR
	fi

	i=$3

	for size_item in ${SIZE[*]}
	do
#		RUN="$TARGET_SIM $pol_item $size_item $INPUT"
#		for ((i=0;i<=99;i++))
#		do
#			echo "$RUN" | tee -a $LOG
#			eval $RUN | tee -a $LOG
#		done

		RUN="$TARGET_SIM $pol_item $size_item $INPUT"
#		echo "$RUN" | tee -a $LOG
#		eval $RUN | tee -a $LOG

		if [ $i -eq 32 ]; then
			i=0
		fi
		taskset --cpu-list $i $RUN | tee -a $LOG &
		i=$(($i + 1))
	done
	wait
done

#wait
