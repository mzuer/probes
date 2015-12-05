#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
using namespace std;

char randnt()
{
    char nt[4] = {'A', 'T', 'G', 'C'};

    int pos(rand()%4);

    return nt[pos];

}


int main()
{
 
    string const outN("nigraSeq.fasta");  //file to write  nigra seq
    string const outR("rapaSeq.fasta");  // file to write rapa seq
    string const input("ncbi.fasta");   // file with sequence from GB

   ifstream ncbiSeq(input.c_str());    // file to read (c_str() : read file stored name stored in variable)
   ofstream nigraSeq(outN.c_str());   // files to write
   ofstream rapaSeq(outR.c_str());    // La fonction c_str() renvoie un pointeur sur la chaine contenue dans le string.

   string line;    // read the file line by line
   string temp; // store line to add random mutation
   int index; // where to add mutation
int index2;
   int compteur;
   if(ncbiSeq)
   {
    compteur=0;
    while(getline(ncbiSeq, line))  // read all the lines
     {
        if(line[0]=='>')    // line with the name -> change it //  not work with double quote
         {
            rapaSeq << ">Rapa" << compteur << endl;
            nigraSeq << ">Nigra" << compteur << endl;
            compteur++;
         }
         else if(line.empty())
         {
         continue;
         }

          else   // line with sequence, print like it in the file of rapa and with random mutation in nigra file
         {
            temp = line;
            rapaSeq << temp << endl;  
            index = rand()%temp.length();
            temp[index] = randnt();
            nigraSeq << temp << endl;

         }
      }


//    ofstream writeSeq(outFile.c_str());   
  //  # use c_str() name of file in a string variable


    }
    else
    {
        cout << "ERREUR ouvertur fichier " << endl;
    }

nigraSeq.close();
rapaSeq.close();
ncbiSeq.close();

    return 0;
}
