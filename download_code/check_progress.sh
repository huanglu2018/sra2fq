while :
do
rm /storage2/huanglu/download/gtex/each_tissue_download_progress.txt
for i in $(find /storage2/huanglu/download/gtex/RNAseq/tissue_sep_krt -name *.sra|cut -d "/" -f 8|sort -u)
do 
totalnum=`less /storage2/huanglu/download/gtex/RNAseq/tissue_sep_krt/${i}/${i}_SRR_Acc_List.txt|wc -l`
eachnum=`find /storage2/huanglu/download/gtex/RNAseq/tissue_sep_krt/$i -name *.sra|wc -l`
echo ${i}" download progress: "$eachnum" / "$totalnum >> /storage2/huanglu/download/gtex/each_tissue_download_progress.txt
done
echo "========== "`find /storage2/huanglu/download/gtex/RNAseq/tissue_sep_krt -name *.sra|wc -l`"/9911 RNAseq data downloaded ==========" >> /storage2/huanglu/download/gtex/each_tissue_download_progress.txt
echo "========== "`date`" ==========" >> /storage2/huanglu/download/gtex/each_tissue_download_progress.txt

sleep 3600
done
