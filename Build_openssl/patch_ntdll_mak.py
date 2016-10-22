#! -* Encoding: Latin-1 -*-

def patch_ntdll_mak(filename):
    with open(filename, "r") as fh:
        lines = fh.readlines()
        
    modified = False
    for index, line in enumerate(lines):
        if line.startswith("CFLAG="):
            if line.find("D_WINSOCK_DEPRECATED_NO_WARNINGS") < 0:
                lines[index] = "CFLAG= -D_WINSOCK_DEPRECATED_NO_WARNINGS " + line[6:]
                modified = True
                
    if modified:
        print("ok, modified %r" % (filename, ))
        with open(filename, "w") as fh:
            fh.write("".join(lines))
    else:
        print("ko: not modified %r" % (filename, ))

if __name__ == "__main__":            
    patch_ntdll_mak(r"D:\openssl-src-win32-vs2013\ms\ntdll.mak")
    
