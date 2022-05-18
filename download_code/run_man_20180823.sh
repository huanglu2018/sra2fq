##allocate server for download
tissue_list=(Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood Lung Skin_Not_Sun_Exposed_Suprapubic Small_Intestine_Terminal_Ileum Spleen Thyroid Whole_Blood )

# determine the download dir

function not_running(){
	if [ $(ssh $1 "ps -ef |grep -v grep|grep -v SCREEN|grep -v ssh|grep prefetch|wc -l") == 0 ]
	then
		echo TRUE
	else
		echo FALSE
	fi
}

function is_available(){

case $1 in
    76)  pswdfile=/public2/huanglu/download/gtex/key/pswd/76.txt
		usrnameIP='huanglu@222.200.187.76'
    ;;
    170)  pswdfile=/public2/huanglu/download/gtex/key/pswd/170.txt
		usrnameIP='xiexw@222.200.186.170'
    ;;
    169)  pswdfile=/public2/huanglu/download/gtex/key/pswd/169.txt
		usrnameIP='huanglu@222.200.186.169'
    ;;
esac

	if [ $(sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "ps -ef |grep -v grep|grep -v SCREEN|grep prefetch|wc -l") == 0 ]
	then
		echo TRUE
	else
		echo FALSE
	fi
}

tissue_76=null
tissue_170=null
tissue_169=null


until [ $(echo ${tissue_list[@]}|wc -w) == 0 ]
do

if [ $(not_running master) == TRUE ]
then
	echo "master is available.."
	echo "start downloading "${tissue_list[0]}" in master 161"
	nohup ssh master "cd ~/ncbi/dbGaP-9455 && prefetch -X 200G -v /public2/huanglu/download/gtex/RNAseq/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/"`date +%Y%m%d`"_"${tissue_list[0]}"_master.log 2>&1 &" &
	tissue_list=(${tissue_list[@]:1})
fi

if [ $(not_running node1) == TRUE ]
then
	echo "node1 is available.."
	echo "start downloading "${tissue_list[0]}" in node1 132"
	nohup ssh node1 "cd ~/ncbi/dbGaP-9455 && prefetch -X 200G -v /public2/huanglu/download/gtex/RNAseq/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/"`date +%Y%m%d`"_"${tissue_list[0]}"_node1.log 2>&1 &" &
	tissue_list=(${tissue_list[@]:1})
fi

if [ $(not_running node2) == TRUE ]
then
	echo "node2 is available.."
	echo "start downloading "${tissue_list[0]}" in node2 83"
	nohup ssh node2 "cd ~/ncbi/dbGaP-9455 && prefetch -X 200G -v /public2/huanglu/download/gtex/RNAseq/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/"`date +%Y%m%d`"_"${tissue_list[0]}"_node2.log 2>&1 &" &
	tissue_list=(${tissue_list[@]:1})
fi

if [ $(not_running node5) == TRUE ]
then
	echo "node5 is available.."
	echo "start downloading "${tissue_list[0]}" in node5 213"
	nohup ssh node5 "cd ~/ncbi/dbGaP-9455 && prefetch -X 200G -v /public2/huanglu/download/gtex/RNAseq/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/"`date +%Y%m%d`"_"${tissue_list[0]}"_node5.log 2>&1 &" &
	tissue_list=(${tissue_list[@]:1})
fi

if [ $(is_available 76) == TRUE ]
then
	echo "76 is available.."
	server=76
	pswdfile=/public2/huanglu/download/gtex/key/pswd/76.txt
	usrnameIP='huanglu@222.200.187.76'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd /public0/huanglu/ncbi/dbGap-9455 && nohup /public0/huanglu/software/sratoolkit.2.9.1-1-centos_linux64/bin/prefetch -X 200G -v /public0/huanglu/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_76.log 2>&1 &" &
	tissue_list=(${tissue_list[@]:1})
fi

if [ $(is_available 170) == TRUE ]
then
	echo "170 is available.."
	server=170
	pswdfile=/public2/huanglu/download/gtex/key/pswd/170.txt
	usrnameIP='xiexw@222.200.186.170'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd /home/xiexw/ncbi/dbGaP-9455 && nohup /home/xiexw/huanglu/software/sratoolkit.2.9.2-ubuntu64/bin/prefetch -X 200G -v /home/xiexw/huanglu/download/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_170.log 2>&1 &" &
	tissue_list=(${tissue_list[@]:1})
fi
	
if [ $(is_available 169) == TRUE ]
then
	echo "169 is available.."
	server=169
	pswdfile=/public2/huanglu/download/gtex/key/pswd/169.txt
	usrnameIP='huanglu@222.200.186.169'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd ~/ncbi/dbGaP-9455 && nohup /home/huanglu/software/sratoolkit.2.9.2-ubuntu64/bin/prefetch -X 200G -v /data2/gtex_download/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_169.log 2>&1 &" &
	tissue_list=(${tissue_list[@]:1})
fi

/usr/bin/Rscript /public/home/huanglu/download_code/download_each_tissue_count.R

echo "=============================================="`date`" progress ============================================"
echo $(find ~/ncbi/dbGaP-9455/sra/ -name "*.sra"|wc -l)"/9911 downloaded..."

sleep 1800

done
