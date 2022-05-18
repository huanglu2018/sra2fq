#!/bin/bash

i=$1
proj_dir="/node6-data1/share/huanglu/gtex/Project_Space"
cd ~/ncbi/dbGaP-9455/sra
mkdir -p $proj_dir/validation_outputs/$i
mkdir -p $proj_dir/validation_errors/$i
err_sample_list=()
eachtissuesamplelist=$(less -S /public2/huanglu/download/gtex/RNAseq/tissue_sep_krt"/"$i"/"$i"_SRR_Acc_List.txt")
for j in ${eachtissuesamplelist[*]}
do
	vdb-validate $j.sra &> $proj_dir/validation_outputs/$i/$j.validation_out
	if grep -q 'err' $proj_dir/validation_outputs/$i/$j.validation_out;
	then 
		echo 'Verification of '$j'.sra failed'
		mv $proj_dir/validation_outputs/$i/$j.validation_out $proj_dir/validation_failures/$i/$j/.validation_out
		err_sample_list=(${err_sample_list[@]} $j)
	fi
done
if [ $(echo ${err_sample_list[*]}|wc -w) == 0 ] 
then
	echo 'No errors found in any sample of '$i
	for k in ${eachtissuesamplelist[*]}
	do
	fastq-dump -v -B --gzip --split-3 -O /node6-data1/share/huanglu/gtex/fastq_files/$i $j.sra
	done
else
	echo $i" found "$(echo ${err_sample_list[*]}|wc -w)"incomplete sras, correct it and rerun this script to dump"
	echo $err_sample_list > $proj_dir/validation_outputs/$i"_invalidated_sra.txt"
fi
