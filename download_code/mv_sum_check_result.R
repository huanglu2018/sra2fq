suppressMessages(source('~/function/R_sub.R'))

while(T){

rawdir="/node6-data1/share/huanglu/gtex/gtex_rnaseq_tissue"
sumdir="/node6-data1/share/huanglu/gtex/fq_gzip_check"

mv2sum=function(rawdir,sumdir){
  checklist=search_file(rawdir,"*.txt")
  for(i in checklist){
    if(file.info(i)$size != 0 ){
      eachfile=sub("txt","fastq.gz",i)
        system(paste0("mv ",i," ",eachfile," ",sumdir,"/fq_gzip_fail/" ))
      }else{
        system(paste0("mv ",i," ",sumdir,"/fq_gzip_success/" ))
        # destfolder=paste0(finaldir,"/",rnaseqdf[(no_suffix(no_suffix(basename(i),"\\."),"_")),1])
        # if((dirname(destfolder)) != finaldir){
        # system(paste0("mv ",eachfile," ",destfolder,"/" ))
        # }
      }
  }
}

checksum=function(sumdir){
  suppressMessages(source('~/function/R_sub.R'))
  sucdir=paste0(sumdir,"/fq_gzip_success/")
  faildir=paste0(sumdir,"/fq_gzip_fail/")
  sucnum=search_file(sucdir,"*.txt") %>% length()
  failnum=search_file(faildir,"*.txt") %>% length()
  print(paste0("success VS fail >>>  ",sucnum," : ",failnum))
  failsrrlist=search_file(faildir,"*.txt") %>% basename() %>% no_suffix_vector(.,"_") %>% no_suffix_vector(.,"\\.") %>% unique()
  write(failsrrlist,paste0(sumdir,"/bdd_list.txt"))
  
}

print("+++++++++++++++++++++++++++++++++++++++++++++++++++")
mv2sum(rawdir,sumdir)
checksum(sumdir)

system("sleep 60")

}
