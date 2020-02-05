##Assignment Week 5
#Rentrez.R

library("rentrez")

#Creates object ncbi_ids with 3 strings
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

#Receives data files from NCBI database for specified id's from ncbi_ids vector in fasta format
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#Splits the Bburg object to 3 different sequences of the 16S gene of Borrelia burgdorferi 
Sequences<-strsplit(Bburg,"\n\n")

#Creates dataframe 
Sequences<-unlist(Sequences)

#Separates sequences from the headers
header<-gsub("(^>.*sequence)\\n[ATCG].*","\\1",Sequences)
seq<-gsub("^>.*sequence\\n([ATCG].*)","\\1",Sequences)
Sequences<-data.frame(Name=header,Sequence=seq)

#Removes newline characters 
Sequences$Sequence<-gsub("\\n","",Sequences$Sequence)

#Outputs vector to a file
write.csv(Sequences,"Sequences.csv")
