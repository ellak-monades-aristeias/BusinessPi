#!/bin/bash

title=''
output=''
files=''
i=1

function help () {
	echo "Script για την γραφική αναπαράσταση του apache benchmark (ab)."
	echo "προϋποθέτει οτι έχετε εγκαταστήσει το gnuplot"
	echo "========================================================"
	echo "	χρήση: ./benchmark run <τίτλος> <λίστα αρχείων gnuplot>"
	echo "	"
	echo "	"
	echo "	Επεξήγηση:"
	echo "	έχετε 2 αρχεία myserver.com.out myserver2.com.out τα οποία προέκυψαν"
	echo "	απο benchmark των 2 server σας με το εργαλείο ab. Έπειτα τροφοδοτείτε αυτά"
	echo "	στο ./benchmark"
	echo "	"
	echo "	"
	echo "	παράδειγμα: ./benchmark run benchmark myserver.com.out myserver2.com.out"
	echo "--------------------------------------------------------"
}

function run () {
	echo "set terminal png
set output '${1}'
set title '${2}'
set size 1,1
set grid y
set xlabel 'request'
set ylabel 'response time (ms)' " > /tmp/plotme
	
	c=1
	for var in "$@"
	do
	    if [ $c -eq 3 ]; then
			echo -e "plot '${var}' using 9 smooth sbezier with lines title '${var}' \\" >> /tmp/plotme	
		fi
		if [ $c -gt 3 ]; then
			echo -e ", '${var}' using 9 smooth sbezier with lines title '${var}' \\" >> /tmp/plotme
		fi
	    let c++
	done
	## plotting
	gnuplot /tmp/plotme

	echo -e "\n Επιτυχία! Το γράφημα είναι: ${1}"

	## show the image
	eog ${1} > /dev/null &
}

case "$1" in
	run )
		output="$2.png"
		title=$2
		for var in "$@"; do
			if [[ i -gt 2 ]]; then
				files+=${var}
				files+=" "
			fi
			let i++
		done
		run ${output} ${title} ${files}
		;;
	* )
		help
		;;
esac
