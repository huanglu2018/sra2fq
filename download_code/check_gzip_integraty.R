##check gzip integraty
source('~/function/R_sub.R')

checkdir="/node6-data1/share/huanglu/gtex/gtex_rnaseq_tissue"
result_dir="/node6-data1/share/huanglu/gtex/fq_gzip_check"
srainfofile="/public/home/huanglu/download_code/gtex_krt/RNAseq/all_v7_RNAseq_SraRunTable.txt"

#########################################################################################

finaldir="/node6-data1/share/huanglu/gtex/gtex_rnaseq_tissue"
rnaseqdf = fread(srainfofile,data.table = F) %>% 
  .[,c("Run","body_site")] %>% 
  column_to_rownames(.,var="Run")
rnaseqdf[,1]=no_spaces_or_brackets(rnaseqdf[,1])

perfectbin=paste0(result_dir,"/fq_gzip_success")
dustbin=paste0(result_dir,"/fq_gzip_fail")
dir.create(result_dir)
dir.create(dustbin)
dir.create(perfectbin)

fqlist=search_file(checkdir,"*.fastq.gz")

fqlist_base=fqlist %>% basename() %>% no_suffix_vector(.,"\\.")
donechecklist=search_file(c(result_dir,checkdir),"*.txt") %>% basename() %>% no_suffix_vector(.,"\\.")
fq_freshlist=fqlist[-match(donechecklist,fqlist_base) %>% na.omit()]

print(paste0("fresh fq number: ",length(fq_freshlist)))

checkgzip=function(eachfile){
# checkgzip=function(eachfile,rnaseqdf,finaldir,perfectbin,dustbin){
    
  # no_suffix = function(string,suffix) {
  #   string_ed = unlist(strsplit(string,split = suffix))[1]
  #   return(string_ed)
  # }
  
  checkresult=paste0(dirname(eachfile),"/",sub("fastq.gz","txt",basename(eachfile)))
  system(paste0("gzip -t ",eachfile," 2> ",checkresult))
  # if(file.info(checkresult)$size != 0 ){
  #   system(paste0("mv ",checkresult," ",eachfile," ",dustbin,"/" ))
  # }else{
  #   system(paste0("mv ",checkresult," ",perfectbin,"/" ))
  #   destfolder=paste0(finaldir,"/",rnaseqdf[(no_suffix(no_suffix(basename(checkresult),"\\."),"_")),1])
  #   if((dirname(destfolder)) != finaldir){
  #   system(paste0("mv ",eachfile," ",destfolder,"/" ))
  #   }
  # }
}

cl=makeCluster(5)
# test=parSapply(cl=cl,fq_freshlist,checkgzip,rnaseqdf=rnaseqdf,finaldir=finaldir,perfectbin=perfectbin,dustbin=dustbin)
test=parSapply(cl=cl,fq_freshlist,checkgzip)
stopCluster(cl)

