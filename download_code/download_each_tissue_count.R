#check the downlooad for each tissue
source('~/function/R_sub.R')

outfile="/public/home/huanglu/download_code/download_complete_list.txt"


download_dir = "/public/home/huanglu/ncbi/dbGaP-9455/sra"
listdir = "/public2/huanglu/download/gtex/RNAseq/tissue_sep_krt"
all_downloaded_sra_list=system('cd /public/home/huanglu/ncbi/dbGaP-9455/sra && find ./ -name "*.sra"',intern = T) %>% sub('./','',.) %>% sub('.sra','',.)

download_complete_list=""
download_uncomplete_list = ""

### to save the name of newly fulldownloaded tissue 
former_complete_list = ""
for (i in dir(abs_dir(outfile)) %>% grep("^download_complete_list",.,value = T)){
  former_complete_list = c(former_complete_list,fread(paste0(abs_dir(outfile),"/",i),data.table = F,header = F)[,1])
}
former_complete_list = former_complete_list[-1]

j = 0

for (i in setdiff(dir(listdir),former_complete_list)){
  eachtissue_list=fread(paste0(listdir,"/",i,"/",i,"_SRR_Acc_List.txt"),data.table = F,header = F)[,1]
  done_list = intersect(eachtissue_list,all_downloaded_sra_list)
  if(length(done_list)!=length(eachtissue_list)){
    j = j+1
    print(paste0(j," : ",i," : ",as.character(length(done_list)),"/",as.character(length(eachtissue_list))))
    download_uncomplete_list = c(download_uncomplete_list,i)
  }else{
    download_complete_list = c(download_complete_list,i)
  }
}



if ((setdiff(download_complete_list[-1],former_complete_list) %>% length())!=0){
  write(setdiff(download_complete_list[-1],former_complete_list),file=paste0(abs_dir(outfile),"/download_complete_list_",date_str(),".txt"))
}
  
  
# print("============= uncomplete tissue list ==============")
# print(paste0(download_uncomplete_list[-1],collapse = " "))
# print("============= complete tissue list ==============")
# print(paste0(download_complete_list[-1],collapse = ", "))
# print("===========================")
# print(paste0("summary : ",length(all_downloaded_sra_list),"/9911"))



# write(download_complete_list[-1],file = outfile)
