 #!/bin/bash


########################
## script probe design #
########################

### Pending nigra nt sequences, generate random ones from rapa
# compile the c++ file
g++ -o rand_seq rand_seq.cpp
# run the file that create the 2 scripts Nigra/Rapa
./rand_seq
###

# merge the 2 fasta files from nigra and rapa in one
cat nigraSeq.fasta rapaSeq.fasta > allSeq.fasta

# run cdhit to group the sequence
/home/user/software/cd-hit/cd-hit -i allSeq.fasta -o clstrSeq -c 0.6 -n 4 -d 0 -g 1     # change path !

# perl script to generate 1 file per cluster
./make_multi_seq_modif.pl allSeq.fasta clstrSeq.clstr clust-seq

# for all clusters, perform alignment with macse
# -> faire un ls et récupérer les noms des fichiers, (faire un regex) puis faire une boucle
#java -jar /home/user/software/macse_v1.01b.jar -prog alignSequences -seq clust-seq/clust1.fasta

#
ls -l clust-seq/ | awk  'NR>1' > filesName.txt

awk '{print $(NF)}'  filesName.txt | grep -o '[0-9]*' | sort -r -n | head -1 > myNumber.txt   # get the number of files, needed for iteration

value= cat myNumber.txt
echo $value

rm -f myNumber.txt
rm -f filesName.txt

#HISTORY
#awk '{print $(NF)}'  filesName.txt > filesName2.txt
#cat filesName2.txt | grep -o '[0-9]*' > filesName3.txt
#awk 'NR>2' filename. 
#| grep 'clust?*.fasta' > fileNames2.txt
#ls -l clust-seq/ | awk 'clust' | sed 's/clust?*.fasta	
#{print $(NF-1),"\t",$NF}' > filesName2.txt
#awk '/class="hap"/' ISOGG_YDNATreeTrunk.html > hapnames.txt 
#sed 's/<span class="hap"?*><b>//' hapnames.txt | sed 's/<.*//' | more > hap${x}.txt
#awk '{print $(NF)}'  filesName.txt | grep -o '[0-9]*' > filesName2.txt
#sort -r -n filesName2.txt | head -1 > myNumber.txt

