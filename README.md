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
 
 To demonstrate the toolchain, I will compile the following file
 
     
     
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
    

    


    
 
