wgslist_dir="/public/home/huanglu/download_code/gtex_krt/wgs"
setwd(wgslist_dir)
pglist=dir(wgslist_dir) %>% grep("txt$",.,value = T) %>% grep("^WGS",.,value = T)

sradir="~/ncbi/dbGaP-9455/sra"
done_sra_list=dir(sradir) %>% grep(".sra$",.,value = T) %>% sub(".sra","",.)

info2=""
for (i in pglist) {
  each_full_list=fread(i,header = T,data.table = F)$Run
  each_done_list=intersect(each_full_list,done_sra_list)
  each_undone_list=setdiff(each_full_list,each_done_list)
  print(i)
  # print(each_undone_list %>% paste0(.,collapse = " "))
  # print(each_undone_list[25:48] %>% paste(.,collapse = " "))
  print(each_undone_list)
  print("===========================================================")
  info2=rbind(info2,c(pg=i,miss_num=each_undone_list %>% length()))
}
info2=info2[-1,]


pglist=c("WGS_pg8.txt")
total=""
info2=""
for (i in pglist) {
  each_full_list=fread(i,header = T,data.table = F)$Run
  total=c(total,each_full_list)
  each_done_list=intersect(each_full_list,done_sra_list)
  each_undone_list=setdiff(each_full_list,each_done_list)
  print(i)
  # print(each_full_list %>% paste0(.,collapse = " "))
  # print(each_undone_list[25:48] %>% paste(.,collapse = " "))
  print(each_undone_list)
  print("===========================================================")
  info2=rbind(info2,c(pg=i,miss_num=each_undone_list %>% length()))
}
info2=info2[-1,]
total=total[-1]

write(total,"~/dump_pg9.txt")


