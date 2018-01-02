# Setting up the tools

## Flang - The NVIDIA fortran compiler

NVIDIA provides documenation on installation.  I did not want to go through the build process, so I used a docker image.  I sed the first one I found:

    docker pull tdd20/flang
    docker run -it tdd20/flang bash
    
From inside the flang image, I can compile fortran to LLVM IR, which can be compiled to Webassembly. Translating IR to webassembly requires some additional tools.  Instead of hassling with installation, I used another docker image.

    docker pull chrisber/llvm-webassembly
    docker run -it chrisber/llvm-webassembly bash
    
 # Using the tools
 
 I want to understand how fortran compiles to Webassembly.  A trial on a hello world program compiles to  form that indicates a non-trivial run time that would need to be implemented in Javascript.  Since this is non-essential behavior for this project, I will do it later if needed.
 
 To demonstrate the toolchain, I will compile the following file (call it addtwo.f90)
     
    function func(a,b) result(j)
        implicit none
        real, intent(in) :: a,b
        real             :: j
        j = a + b
    end function func
    program xfunc
        implicit none
        real :: i, res
        i = 3.1
        res = func(i, 3.2)
    end program xfunc
    
Use the docker image for flang and run
    flang -Oz -emit-llvm --target=wasm32 -c addtwo.f90 -o addtwo.bc
    
This compiles to llvm bytecode (bitcode?).  This can be converted to something human readable using llvm's dissassembler

    llvm-dis addtwo.bc
    
The result of dissassebly is a file called addtwo.ll, which is human readable.  The .ll file can be converted to webassembly with another tool is the chrisber/llvm-webassembly docker image.  Specifically, it needs a build of clang with webassembly backend support, which is a custom build at the time of writing this.

To compile the .ll file in the webassembly docker:

    llc addtwo.ll
    
It will produce a .s file.  The last step is to run s2wasm

    s2wasm addtwo.s
    
Webassembly will be dumped to stdout.  This webassembly can be compiled to a form usable by a browser by running an external tool that is easy to build called wat2wasm.


# Questions

Why does flang need a modded version of clang?  This is worrisome
    

    


    
 
