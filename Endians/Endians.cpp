// Endians.cpp : simple code shifting the endian form to the big endian form, usefull for reading Raw bitcoin Blocks.
//

#include "stdafx.h"
 #include <fstream>
#include <iostream> 
#include <string> 
 #include <sstream> 
#include <iomanip>  

using namespace std;

#include <openssl/sha.h>
string sha256(const string str)
{
	unsigned char hash[SHA256_DIGEST_LENGTH];
	SHA256_CTX sha256;
	SHA256_Init(&sha256);
	SHA256_Update(&sha256, str.c_str(), str.size());
	SHA256_Final(hash, &sha256);
	stringstream ss;
	for (int i = 0; i < SHA256_DIGEST_LENGTH; i++)
	{
		ss << hex << setw(2) << setfill('0') << (int)hash[i];
	}
	return ss.str();
}

int main()
{


	string LittleEnd;// e.g "4f8505cdaee726fa7bfd19e18da8 1f 47 4f 6c 45 3a ea 6f 7f be 09 43 d8 08 7a b9 9d 1e f7 a7 9b db d3 9e 45 83";
	std::cout << "give your Little Endian String (hex)[spaces will be removed]: ";
	std::getline(std::cin, LittleEnd);
 
	string::iterator it;		// The string iterator.
 
	for (it = LittleEnd.begin(); it != LittleEnd.end(); it++)
	{

		if ((*it) == '\n')
			it = LittleEnd.erase(it);

		if ((*it) == ' ')
			it = LittleEnd.erase(it);

		if ((*it) == '.')
			it = LittleEnd.erase(it);

		if ((*it) == ',')
			it = LittleEnd.erase(it);
	}

  
 	 
 
	 string bigEnd = LittleEnd;
	 int l = LittleEnd.length();
	 for (int i = 1, j = 0; i < l; i = i + 2,j=j+2) {

		 bigEnd[j] = LittleEnd[l-(i+1)];
		 bigEnd[j+1] = LittleEnd[l - i];

  
	 
		
	}
	 string sha256_1 = sha256(bigEnd);
	 string sha256_2 = sha256(sha256(bigEnd));
 
	 std::cout << "little endian form: " << LittleEnd << endl;
	 std::cout << "Big Endians form : " << bigEnd << endl;
 	 std::cout <<"sha256 (of BE): " << sha256_1 << endl;
	 std::cout << "Double sha256 (of BE): " << sha256_2 << endl;
	 std::cout << "The results are stored into endian.txt: " << endl;

  	ofstream myfile;
	myfile.open("endian.txt");
	 myfile <<"little endian form"<< LittleEnd <<"\nBig Endian Form :"<< bigEnd<<"\nsha256 :"<< sha256_1<<"\ndouble sha256 :"<< sha256_2<<endl;
	myfile.close();
	std::getline(std::cin, LittleEnd);
	 
    return 0;

}

