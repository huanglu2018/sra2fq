batch="/public/home/huanglu/valid_dump/batches/batch3.txt"
s= fread(batch,data.table = F,header = F)[,1]
s4 = dir("~/ncbi/dbGaP-9455/sra") %>% grep("sra$",.,value = T) %>% sub(".sra","",.)
s2 = intersect(s,s1)
write.table(s2,"/node6-data1/share/huanglu/gtex/public2_temp/batches/batch4.txt",col.names = F,row.names = F,quote = F)


setwd("/public/home/huanglu/download_code/gtex_krt/RNAseq")
dir()
s1 = read.table("76list.txt",header = F)[,1] %>% sub(".sra","",.)
s2 = read.table("all_v7_RNAseq_SRR_List.txt",header = F)[,1]
s3 = intersect(s1,s4)



s1=fread("/public/home/huanglu/snake_dump/batches/batch4.txt",data.table = F,header = F)[,1]
s2=dir("/public/home/huanglu/snake_dump/dump/dump_result/dump_log") %>% sub(".dump_result","",.)
s3=setdiff(s1,s2)

write.table(s3[1:2500],"/public/home/huanglu/snake_dump/batches/batch5_161.txt",col.names = F,row.names = F,quote = F)
write.table(s3[2501:3961],"/public/home/huanglu/snake_dump/batches/batch5_169.txt",col.names = F,row.names = F,quote = F)


###check the undownloaded sra

sradirs=c("/public/home/huanglu/ncbi/dbGaP-9455/sra","/node6-data1/share/huanglu","/public2/huanglu")

totalsralist=fread("/public/home/huanglu/download_code/gtex_krt/RNAseq/all_v7_RNAseq_SRR_List.txt",header = F,data.table = F)[,1] %>% 
  paste0(.,".sra")

donesrafulllist=""
for (i in sradirs){
  eachlist=system(paste0('find ',i,' -name "*.sra"'),intern = T)
  donesrafulllist=c(donesrafulllist,eachlist)
}
donesrafulllist=donesrafulllist[-1] 

donesralist = donesrafulllist %>% basename() %>% unique()

donesrafulllist[match(setdiff(donesralist,totalsralist),donesralist)]###WGS maybe

sradf=fread("/public/home/huanglu/download_code/gtex_krt/RNAseq/all_v7_RNAseq_SraRunTable.txt",header = T,data.table = F)
undownload_df = sradf %>% filter(Run %in% (setdiff(totalsralist,donesralist) %>% sub(".sra","",.)))



#check the dumped sr


search_file=function(dirs,name){
  donefulllist=""
  for (i in dirs){
    eachlist=system(paste0('find ',i,' -name ',name),intern = T)
    donefulllist=c(donefulllist,eachlist)
  }
  return(donefulllist[-1])
}

sradirs=c("/public/home/huanglu",
          "/node6-data1/share/huanglu/gtex"
)

f1= search_file(sradirs,"*_1.fastq.gz") %>% basename() %>% sub("_1.fastq.gz","",.)
f2= search_file(sradirs,"*_2.fastq.gz") %>% basename() %>% sub("_2.fastq.gz","",.)
donedumplist=intersect(f1,f2)

rnaseqdf = fread("/public/home/huanglu/download_code/gtex_krt/RNAseq/all_v7_RNAseq_SraRunTable.txt",data.table = F) %>% 
            .[,c("Run","body_site")]

rnaseqdf[,2]=no_spaces_or_brackets(rnaseqdf[,2])

for (i in unique(rnaseqdf[,2])){
  
  
  
}





donesrafulllist=search_file(sradirs,"*.sra")

donesradirs=donesrafulllist %>% dirname() %>% unique()

total_sralist=fread("/public/home/huanglu/download_code/gtex_krt/RNAseq/all_v7_RNAseq_SRR_List.txt",header=F,data.table=F)[,1]

setdiff(donesrafulllist %>% basename() %>% sub(".sra","",.),totalralist) %>% length()


undumpedsralist=setdiff(sub(".sra","",(donesrafulllist%>% basename() %>% unique())),donedumplist)
undownloadedsralist=setdiff(total_sralist,c(donedumplist,donesrafulllist %>% basename() %>% sub(".sra","",.)))
write(undownloadedsralist[1:100],"~/RNA_add_100.txt")
write(undownloadedsralist[101:200],"~/RNA_add_200.txt")
write(undownloadedsralist[201:300],"~/RNA_add_300.txt")
write(undownloadedsralist[301:400],"~/RNA_add_400.txt")
write(undownloadedsralist[401:500],"~/RNA_add_500.txt")
write(undownloadedsralist[501:551],"~/RNA_add_551.txt")




undumpedsrafulllist=""
for(i in paste0(undumpedsralist,".sra")){
  eachmatch=grep(i,donesrafulllist,value = T)
  undumpedsrafulllist=c(undumpedsrafulllist,eachmatch
}
undumpedsrafulllist=undumpedsrafulllist[-1]  

undumpedsralist=basename(undumpedsrafulllist) %>% sub(".sra","",.) %>% unique()

undumpedRNAseqsralist=intersect(undumpedsralist,totalsralist %>% sub(".sra","",.))

write(undumpedRNAseqsralist,"/public/home/huanglu/snake_dump/batches/batch6_161.txt")

grep("^public2",undumpedsrafulllist,value = T)####character(0)说明public2里面的sra都是处理过的，没必要留




grep("^/public/home/huanglu",donesrafulllist,value=T,invert = T) %>% length()

donesralist = donesrafulllist %>% basename() %>% unique() %>% sub(".sra","",.)
deletelist=donesrafulllist[match(intersect(donesralist,donedumplist),donesralist)]
deletelist_no_public2=grep("^/public2",deletelist,value = T,invert = T)

write(deletelist_no_public2,"deletelist_no_public2.txt")

#############check 161 dump inter break
fastqdir="/public/home/huanglu/snake_dump/dump/dump_result/dump_finish"
batchfile="/public/home/huanglu/snake_dump/batches/batch6_161.txt"
sradir="/public/home/huanglu/ncbi/dbGaP-9455/sra"

dumpedlist= dir(fastqdir) %>% sub("_1.fastq.gz","",.) %>% sub("_2.fastq.gz","",.) %>% unique()
alllist=fread(batchfile,header = T,data.table = F)[,1]
sralist=dir(sradir) %>% grep(".sra$",.,value = T) %>% sub(".sra","",.) %>% unique()
#all list处理到一半被郭叫停转移，而dumpedlist中仅仅有停止转移后的结果，
#而且all list中已处理后的sra已经在sralist中删掉，
#sralist里面有从public2中脑残挪过来的sra（~11.6），
#因此取alllist和sralist的交集可以去掉转移前的sra，且里面没有public2中的sra
#然后和dumpedlist取差集可以获得未处理的sra

undumpedlist=setdiff(intersect(alllist,sralist),dumpedlist)

write(undumpedlist,"/public/home/huanglu/snake_dump/batches/batch6_161_2.txt")

#############check 169 dump inter break

fastqdir="/node6-data1/share/huanglu/gtex/169_dump_final/dump/dump_result/dump_finish"
batchfile="/public/home/huanglu/snake_dump/batches/batch5_169.txt"

dumpedlist= dir(fastqdir) %>% sub("_1.fastq.gz","",.) %>% sub("_2.fastq.gz","",.) %>% unique()
alllist=fread(batchfile,header = T,data.table = F)[,1]

undumpedlist=setdiff(alllist,dumpedlist)
undumpedlist_aiailable = intersect(undumpedlist,sub(".sra","",grep(".sra$",dir("/public/home/huanglu/ncbi/dbGaP-9455/sra"),value = T)))

write(undumpedlist_aiailable,"/node6-data1/share/huanglu/gtex/169_dump_final/batches/batch5_169_2.txt")




######### mv remained sra to /public/home/huanglu/ncbi/DbGap/sra/

reamained_sra=search_file(sradirs,"*.sra")

misputsra=reamained_sra %>% grep("^/public/home/huanglu/ncbi/dbGaP-9455/sra",.,value = T,invert = T)

write(misputsra,"misputsra_to_cp.txt")

getwd()# [1] "/public/home/huanglu/download_code/gtex_krt/RNAseq"

grep("SRR2135330",reamained_sra,value=T)





############################# WGS list for snakemake ###################
sradir="~/ncbi/dbGaP-9455/sra"
wgsfile="/public/home/huanglu/download_code/gtex_krt/wgs/SRR_Acc_List.txt"
pg6_list_file="/public/home/huanglu/download_code/gtex_krt/wgs/WGS_pg6.txt"


sralist=dir(sradir) %>% grep(".sra$",.,value = T) %>% sub(".sra","",.)
wgslist=fread(wgsfile,header=F,data.table = F)[,1]
pg6list=fread(pg6_list_file,header=T,data.table = F)$Run

downloaded_wgs_in_sra=intersect(sralist,wgslist)
downloaded_pg6_in_sra=intersect(sralist,pg6list)

batch_pg6=downloaded_pg6_in_sra

write(batch_pg6,"/public/home/huanglu/snake_dump/batches/dump_pg6.txt")




