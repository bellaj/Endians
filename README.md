# Endians
Little endians to big endians and double sha256 hashing

*Instruction*

compile openSSL code. you could follow the instruction listed here : http://p-nand-q.com/programming/windows/building_openssl_with_visual_studio_2013.html

Alternative (instead compiling openssl) use Windows32-openSSL: http://slproweb.com/products/Win32OpenSSL.html

Next open Configuration Properties and then Linker.

Now you want to add the folder you have the Allegro libraries in to Additional Library Directories,

[C/C++ -> General -> Additional Include Directories] value: OpenSSL’s include directory in your machine (e.g C:\openssl\include)

[Linker -> General -> Additional Library Directories] value: OpenSSL’s lib directory in your machine (e.g C:\openssl\lib)

[Linker -> Input -> Additional Dependencies] value: libeay32.lib and ssleay32.lib


![alt tag](https://s18.postimg.org/hhudvh1op/include.png)
![alt tag](https://s18.postimg.org/pbuzgv9hl/link.png)
