// Endians.cpp : simple code shifting the endian form to the big endian form, usefull for reading Raw bitcoin Blocks.
//

#include "stdafx.h"
 #include <fstream>
#include <iostream> 
#include <string> 
 #include <sstream> 
using namespace std;
 

int main()
{
 
	string LittleEnd;// e.g "4f8505cdaee726fa7bfd19e18da8 1f 47 4f 6c 45 3a ea 6f 7f be 09 43 d8 08 7a b9 9d 1e f7 a7 9b db d3 9e 45 83";
	std::cout << "give your Little Endian String (hex): ";
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
	 
 
  	ofstream myfile;
	myfile.open("endian.txt");
	myfile << bigEnd;
	myfile.close();
	std::getline(std::cin, LittleEnd);

    return 0;

}

