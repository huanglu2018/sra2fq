RNAseq_info_file="/node6-data1/share/huanglu/gtex/all_v7_RNAseq_SraRunTable.txt"
input_fq_dir="/node6-data1/share/huanglu/gtex/gtex_rnaseq_mv"
tissue_fq_dir="/node6-data1/share/huanglu/gtex/gtex_rnaseq_tissue"
result_dir="/node6-data1/share/huanglu/gtex/lacking_list"

dir.create(result_dir)
RNAseq_info=fread(RNAseq_info_file,data.table = F) %>% 
  .[,c("Run","body_site")]

RNAseq_info[,"body_site"]=no_spaces_or_brackets(RNAseq_info[,"body_site"])
rownames(RNAseq_info)=RNAseq_info[,"Run"]
#RNAseq_info=RNAseq_info[,"body_site"]

complete_fq_tissue_list=""
to_download_list=""

for(eachtissue in (RNAseq_info[,"body_site"] %>% unique())){
  
  subgroup_raw=data.frame(RNAseq_info,rowname=rownames(RNAseq_info))
  subgroup=subgroup_raw[subgroup_raw[,"body_site"]==eachtissue,c("rowname","body_site")]
  
  samplelist=subgroup$rowname
  full_number=length(samplelist)
  folder_srr_list=dir(paste0(tissue_fq_dir,"/",eachtissue)) %>%  #folder_srr_list=full_gz_list[sample(1:700,500)]
    grep("^SRR",.,value = T) %>%
    grep("gz$",.,value = T)
  full_gz_list=c(paste0(samplelist,"_1.fastq.gz"),paste0(samplelist,"_2.fastq.gz"))
  intersect_gz_list=intersect(folder_srr_list,full_gz_list)
  intersect_gz_1_list=intersect_gz_list %>% grep("_1.fastq.gz$",.,value = T) %>% sub("_1.fastq.gz$","",.)
  intersect_gz_2_list=intersect_gz_list %>% grep("_2.fastq.gz$",.,value = T) %>% sub("_2.fastq.gz$","",.)
  intersect_gz_12_list=intersect(intersect_gz_1_list,intersect_gz_2_list)
  
  lack_1_list=setdiff(paste0(samplelist,"_1.fastq.gz"),intersect_gz_list %>% grep("_1.fastq.gz$",.,value = T))
  lack_2_list=setdiff(paste0(samplelist,"_2.fastq.gz"),intersect_gz_list %>% grep("_2.fastq.gz$",.,value = T))
  
  if(length(lack_1_list)!=0){
    write(lack_1_list,paste0(result_dir,"/",eachtissue,"____",length(lack_1_list),"_","_only_1_list.txt"))
  }
  if(length(lack_2_list)!=0){
    write(lack_2_list,paste0(result_dir,"/",eachtissue,"____",length(lack_2_list),"_","_only_2_list.txt"))
  }
  if((length(lack_1_list)==0) & (length(lack_2_list)==0)){
    complete_fq_tissue_list=c(complete_fq_tissue_list,eachtissue)
  }else{
  to_download_list=c(to_download_list,union(lack_1_list %>% sub("_1.fastq.gz","",.), lack_2_list %>% sub("_2.fastq.gz","",.)))
  }
  
}

write(complete_fq_tissue_list[-1],paste0(result_dir,"/",length(complete_fq_tissue_list[-1]),"_complete_fq_tissues.txt"))
write(to_download_list[-1],paste0(result_dir,"/","to_download.txt"))
