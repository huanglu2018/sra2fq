# batch_dump.R
library(data.table)
library(parallel)
library(magrittr)
srrfile = commandArgs()[1]
# srrfile="/public2/huanglu/download/gtex/RNAseq/tissue_sep_krt/Adipose_Subcutaneous/Adipose_Subcutaneous_SRR_Acc_List.txt"
srrlist = fread(srrfile,header = F,data.table = F)[,1]
tissue=basename(srrfile) %>% sub("_SRR_Acc_List.txt","",.)


dumpsrr = function(srr,tissue){
  system(paste0("source ~/.bashrc && fastq-dump -v -B --gzip --split-3 -O /public/home/huanglu/valid_dump/fastq_files/",tissue," ",srr,".sra"))
}


cl = makeCluster(10)
parSapply(cl,srrlist,dumpsrr,tissue=tissue)
stopCluster(cl)