# Setting up the tools

## Flang - The NVIDIA fortran compiler

NVIDIA provides documenation on installation.  I did not want to go through the build process, so I used a docker image.  I sed the first one I found:

    docker pull tdd20/flang
    docker run -it tdd20/flang bash
    
From inside the flang image, I can compile fortran to LLVM IR, which can be compiled to Webassembly. Translating IR to webassembly requires some additional tools.  Instead of hassling with installation, I used another docker image.

    docker pull chrisber/llvm-webassembly
    docker run -it chrisber/llvm-webassembly bash
    

    


    
 
