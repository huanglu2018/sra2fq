search_file=function(dirs,name){
  donefulllist=""
  for (i in dirs){
    eachlist=system(paste0('find ',i,' -name ',name),intern = T)
    donefulllist=c(donefulllist,eachlist)
  }
  return(donefulllist[-1])
}

sradirs=c("/public/home/huanglu",
          "/node6-data1/share/huanglu/gtex/gtex_rna_fq"
)
outdir="/node6-data1/share/huanglu/gtex/gtex_rnaseq_tissue"


# sra=search_file(sradirs,"*.sra")%>% basename() %>% sub(".sra","",.) %>% unique()
f1= search_file(sradirs,"*_1.fastq.gz") %>% basename() %>% sub("_1.fastq.gz","",.)
f2= search_file(sradirs,"*_2.fastq.gz") %>% basename() %>% sub("_2.fastq.gz","",.)
donedumplist=intersect(f1,f2)
donefqfulllist=search_file(c("/public/home/huanglu","/node6-data1/share/huanglu/gtex/gtex_rna_fq","/node6-data1/share/huanglu/gtex/gtex_rnaseq_tissue"),"*.fastq.gz")

rnaseqdf = fread("/public/home/huanglu/download_code/gtex_krt/RNAseq/all_v7_RNAseq_SraRunTable.txt",data.table = F) %>% 
  .[,c("Run","body_site")]

rnaseqdf[,2]=no_spaces_or_brackets(rnaseqdf[,2])

for (i in unique(rnaseqdf[,2])){
  subdir=paste0(outdir,"/",i)
  dir.create(subdir)
  subsrrlist=rnaseqdf %>% 
    filter(body_site%in%i) %>% 
    .[,1]
  for (j in subsrrlist){
    fq1file=donefqfulllist %>% grep(paste0(j,"_1.fastq.gz"),.,value = T)
    fq2file=donefqfulllist %>% grep(paste0(j,"_2.fastq.gz"),.,value = T)
    fqfile=donefqfulllist %>% grep(paste0(j,".fastq.gz"),.,value = T)
    if(length(fq1file)|length(fq2file)|length(fqfile)){
    system(paste0("mv -n ",fq1file," ",fq2file," ",fqfile," ",subdir,"/"))
    }
  }
}


s=donefqfulllist %>% basename() %>% table() %>% as.data.frame() %>% filter(Freq>1) %>% .[,1]

for (i in s){
  path1=grep(as.character(i),donefqfulllist,value = T)[1]
  path2=grep(as.character(i),donefqfulllist,value = T)[2]
  if ( (path1 %>% file.info() %>% .["size"] %>% .[,1]) !=  (path2%>% file.info() %>% .["size"] %>% .[,1])){
    print(path1)
    print(path2)
  }
  
}

file.info("/node6-data1/share/huanglu/gtex/gtex_rnaseq_tissue/Lung/SRR665217_1.txt")$size
