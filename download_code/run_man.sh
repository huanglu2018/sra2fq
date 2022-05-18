##allocate server for download
tissue_list=(Artery_Coronary Artery_Tibial Brain_Amygdala Brain_Anterior_cingulate_cortex_BA24 Brain_Caudate_basal_ganglia Brain_Cerebellar_Hemisphere Brain_Hypothalamus Brain_Nucleus_accumbens_basal_ganglia Brain_Substantia_nigra Breast_Mammary_Tissue Cervix_Endocervix Colon_Sigmoid Colon_Transverse Esophagus_Gastroesophageal_Junction Esophagus_Muscularis Lung Nerve_Tibial Ovary Small_Intestine_Terminal_Ileum Spleen Stomach Testis Thyroid)

# determine the download dir

function is_available(){

case $1 in
    213)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/213.txt
		usrnameIP='pub213@222.200.186.213'
    ;;
    76)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/76.txt
		usrnameIP='huanglu@222.200.187.76'
    ;;
    # 83)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/83.txt
		# usrnameIP='-p 22135 huanglu@222.200.187.83'
    # ;;
    170)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/170.txt
		usrnameIP='xiexw@222.200.186.170'
    ;;
    169)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/169.txt
		usrnameIP='huanglu@222.200.186.169'
    ;;
    165)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/165.txt
		usrnameIP='zhuling@222.200.186.165'
    ;;
    163)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/163.txt
		usrnameIP='huanglu@222.200.186.163'
    ;;
esac

	if [ $(sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "ps -ef |grep -v grep|grep -v SCREEN|grep prefetch|wc -l") == 0 ]
	then
		echo TRUE
	else
		echo FALSE
	fi
}

function download_man(){

case $1 in
    213)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/213.txt
		usrnameIP='pub213@222.200.186.213'
    ;;
    76)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/76.txt
		usrnameIP='huanglu@222.200.187.76'
    ;;
    # 83)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/83.txt
		# usrnameIP='-p 22135 huanglu@222.200.187.83'
    # ;;
    170)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/170.txt
		usrnameIP='xiexw@222.200.186.170'
    ;;    
    169)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/169.txt
		usrnameIP='huanglu@222.200.186.169'
    ;;
    165)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/165.txt
		usrnameIP='zhuling@222.200.186.165'
    ;;
    163)  pswdfile=/storage2/huanglu/download/gtex/key/pswd/163.txt
		usrnameIP='huanglu@222.200.186.163'
    ;;

esac

sh /storage2/huanglu/download/gtex/download_man.sh $1 $2
}

tissue_76=null
tissue_213=null
# tissue_83=null
tissue_170=null
tissue_169=null
tissue_165=null
tissue_163=null

until [ $(echo ${tissue_list[@]}|wc -w) == 0 ]
do

if [ $(is_available 213) == TRUE ]
then
	echo "213 is available.."

	download_man 213 $tissue_213 ##清空下载的之前tissue的文件
	
	server=213
	pswdfile=/storage2/huanglu/download/gtex/key/pswd/213.txt
	usrnameIP='pub213@222.200.186.213'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd /data2/pub213/ncbi/dbGaP-9455 && nohup /data3/huanglu/software/sratoolkit.2.9.1-1-centos_linux64/bin/prefetch -X 200G -v /data2/pub213/download/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_213.log 2>&1 &" &
	tissue_213=${tissue_list[0]}
	tissue_list=(${tissue_list[@]:1})
fi
	
if [ $(is_available 76) == TRUE ]
then
	echo "76 is available.."

	download_man 76 $tissue_76 ##清空下载的之前tissue的文件
	
	server=76
	pswdfile=/storage2/huanglu/download/gtex/key/pswd/76.txt
	usrnameIP='huanglu@222.200.187.76'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd /public0/huanglu/ncbi/dbGap-9455 && nohup /public0/huanglu/software/sratoolkit.2.9.1-1-centos_linux64/bin/prefetch -X 200G -v /public0/huanglu/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_76.log 2>&1 &" &
	tissue_76=${tissue_list[0]}
	tissue_list=(${tissue_list[@]:1})
fi

# if [ $(is_available 83) == TRUE ]
# then
	# echo "83 is available.."

	# download_man 83 $tissue_83 ##清空下载的之前tissue的文件
	
	# server=83
	# pswdfile=/storage2/huanglu/download/gtex/key/pswd/83.txt
	# usrnameIP='huanglu@222.200.187.83'
	# echo "start downloading "${tissue_list[0]}" in "${server}
	# nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "cd /data9/users/huanglu/ncbi/dbGaP-9455 && nohup /data9/users/huanglu/software/sratoolkit.2.9.2-ubuntu64/bin/prefetch -X 200G -v /data9/users/huanglu/download/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_83.log 2>&1 &" &
	# tissue_83=${tissue_list[0]}
	# tissue_list=(${tissue_list[@]:1})
# fi

if [ $(is_available 170) == TRUE ]
then
	echo "170 is available.."

	download_man 170 $tissue_170 ##清空下载的之前tissue的文件
	
	server=170
	pswdfile=/storage2/huanglu/download/gtex/key/pswd/170.txt
	usrnameIP='xiexw@222.200.186.170'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd /home/xiexw/ncbi/dbGaP-9455 && nohup /home/xiexw/huanglu/software/sratoolkit.2.9.2-ubuntu64/bin/prefetch -X 200G -v /home/xiexw/huanglu/download/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_170.log 2>&1 &" &
	tissue_170=${tissue_list[0]}
	tissue_list=(${tissue_list[@]:1})
fi
	
if [ $(is_available 169) == TRUE ]
then
	echo "169 is available.."

	download_man 169 $tissue_169 ##清空下载的之前tissue的文件
	
	server=169
	pswdfile=/storage2/huanglu/download/gtex/key/pswd/169.txt
	usrnameIP='huanglu@222.200.186.169'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd ~/ncbi/dbGaP-9455 && nohup /home/huanglu/software/sratoolkit.2.9.2-ubuntu64/bin/prefetch -X 200G -v /data2/gtex_download/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_169.log 2>&1 &" &
	tissue_169=${tissue_list[0]}
	tissue_list=(${tissue_list[@]:1})
fi
	
if [ $(is_available 165) == TRUE ]
then
	echo "165 is available.."

	download_man 165 $tissue_165 ##清空下载的之前tissue的文件
	
	server=165
	pswdfile=/storage2/huanglu/download/gtex/key/pswd/165.txt
	usrnameIP='zhuling@222.200.186.165'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd /home/zhuling/ncbi/dbGaP-9455 && nohup /home/zhuling/huanglu/software/sratoolkit.2.9.2-ubuntu64/bin/prefetch -X 200G -v /home/zhuling/huanglu/download/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_165.log 2>&1 &" &
	tissue_165=${tissue_list[0]}
	tissue_list=(${tissue_list[@]:1})
fi
	
if [ $(is_available 163) == TRUE ]
then
	echo "163 is available.."

	download_man 163 $tissue_163 ##清空下载的之前tissue的文件
	
	server=163
	pswdfile=/storage2/huanglu/download/gtex/key/pswd/163.txt
	usrnameIP='root@222.200.186.163'
	echo "start downloading "${tissue_list[0]}" in "${server}
	nohup sshpass -f $pswdfile ssh -o StrictHostKeyChecking=no $usrnameIP "source ~/.bashrc && cd /home/huanglu/ncbi/dbGaP-9455 && nohup /home/huanglu/software/sratoolkit.2.9.2-ubuntu64/bin/prefetch -X 200G -v /home/huanglu/download/allkrts/"${tissue_list[0]}"_cart_prj9455.krt > ~/gtex_download_log/"`date +%Y%m%d`"_"${tissue_list[0]}"_163.log 2>&1 &" &
	tissue_163=${tissue_list[0]}
	tissue_list=(${tissue_list[@]:1})	
fi

download_man 213 $tissue_213
download_man 76 $tissue_76
# download_man 83 $tissue_83
download_man 170 $tissue_170
download_man 169 $tissue_169
download_man 165 $tissue_165
download_man 163 $tissue_163

echo "=============================================="`date`" progress ============================================"
echo "there are "${#tissue_list[@]}"/54 tissues to be downloaded..."

sleep 3600

done

echo "all loaded, wait to finish..."
until [[ $(is_available 213) == TRUE ]] && [[ $(is_available 76) == TRUE ]] && [[ $(is_available 169) == TRUE ]] && [[ $(is_available 165) == TRUE ]] && [[ $(is_available 163) == TRUE ]] && [[ $(is_available 170) == TRUE ]] 
do

download_man 213 $tissue_213
download_man 76 $tissue_76
# download_man 83 $tissue_83
download_man 170 $tissue_170
download_man 169 $tissue_169
download_man 165 $tissue_165
download_man 163 $tissue_163
	
sleep 3600
done

download_man 213 $tissue_213
download_man 76 $tissue_76
# download_man 83 $tissue_83
download_man 170 $tissue_170
download_man 169 $tissue_169
download_man 165 $tissue_165
download_man 163 $tissue_163
