library(parallel)
library(data.table)

s = fread('/public/home/huanglu/download_code/list_all_refseqs.txt',data.table = F)[,1]

download_each_ref=function(i){
  i=trimws(i)
  system(paste0("wget -O /public/home/huanglu/ncbi/dbGaP-9455/refseq/",i, " ftp.ncbi.nlm.nih.gov/sra/refseq/",i))
}

cl = makeCluster(10)
parSapply(cl,s,download_each_ref)
stopCluster(cl)