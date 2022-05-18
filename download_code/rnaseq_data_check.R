source('~/function/R_sub.R')

RNAseq_info_file="/node6-data1/share/huanglu/gtex/all_v7_RNAseq_SraRunTable.txt"
input_fq_dir="/node6-data1/share/huanglu/gtex/gtex_rnaseq_mv"
tissue_fq_dir="/node6-data1/share/huanglu/gtex/gtex_rnaseq_tissue"
result_dir="/node6-data1/share/huanglu/gtex/lacking_list"
wgs_dir="/node6-data1/share/huanglu/gtex/maybe_wgs"

dir.create(result_dir)
dir.create(wgs_dir)

RNAseq_info=fread(RNAseq_info_file,data.table = F) %>% 
  .[,c("Run","body_site")]

RNAseq_info[,"body_site"]=no_spaces_or_brackets(RNAseq_info[,"body_site"])
rownames(RNAseq_info)=RNAseq_info[,"Run"]

put_into_bins=function(input_fq_dir,tissue_fq_dir,RNAseq_info){
  fqlist=search_file(input_fq_dir,"*.gz")
  for (i in fqlist) { 
    SRR=basename(i) %>% 
      strsplit(.,"_",fixed = T) %>% 
      .[[1]] %>% 
      .[1] %>% 
      strsplit(.,"\\.",fixed = T) %>% 
      .[[1]] %>% 
      .[1]
    # if (file.exists(paste0(input_fq_dir,"/",SRR,"_1.fastq.gz")) & file.exists(paste0(input_fq_dir,"/",SRR,"_2.fastq.gz"))){
      tissue=RNAseq_info[SRR,"body_site"]
      if(!(is.na(tissue))){
        if(!file.exists(paste0(tissue_fq_dir,"/",tissue,"/",basename(i)))){
        system(paste0("mv -n ",i," ",tissue_fq_dir,"/",tissue,"/"))
        }else{
          print(paste0(basename(i)," already in tissue folder"))
        }
      }else{
        print(paste0(basename(i)," no match tissue, maybe wgs ?"))
        system(paste0("mv -n ",i," ",wgs_dir,"/"))
      }
    # }else{
    #   print(paste0(basename(i)," not in pair"))
    #   next
    # }
  }
}

put_into_bins(input_fq_dir,tissue_fq_dir,RNAseq_info)
