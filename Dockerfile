FROM ubuntu:16.04

RUN  apt-get update -y  && \
     apt-get install -y  git \
                        cmake \
                        build-essential \
                        gcc \
                        g++ \
                        g++-multilib \
			nodejs \
			default-jre \
			python && \
     apt-get autoremove -y && rm -rf /var/lib/apt/

RUN cd ~ && \
	git clone https://github.com/llvm-mirror/llvm.git && \
	cd llvm/ && \
	git checkout release_40 && \
	mkdir build && \
	cd build && \
	cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD="X86" -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly .. && \
	make -j 8 && \
	make install && \
	make clean && \
	cd ~  && \
	rm -rf llvm

RUN cd ~ && \
	git clone https://github.com/flang-compiler/clang.git && \
	cd clang && \
	git checkout flang_release_40 && \
	mkdir build && \
	cd build && \
	cmake -G "Unix Makefiles" .. && \
	make -j 16 && \
	make install && \
	cd ~ && \
	rm -rf clang

RUN cd ~ && \
	git clone https://github.com/llvm-mirror/openmp.git && \
	cd openmp/runtime/ && \
	git checkout release_40 && \
	mkdir build && \
	cd build/ && \
	cmake -G "Unix Makefiles" .. && \
 	make -j 16 && \
	make install && \
	cd ~ && \
	rm -rf openmp

RUN cd ~ && \
	git clone https://github.com/flang-compiler/flang.git && \
	cd flang && \
 	mkdir build && \
	cd build && \
	cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -DCMAKE_Fortran_COMPILER=flang .. && \
	make -j 16 && \
	make install && \
	cd ~ && \
	rm -rf flang

RUN cd ~ && \
	git clone https://github.com/WebAssembly/binaryen.git && \
	cd binaryen/ && \
 	mkdir build && \
 	cd build/ && \
	cmake .. && \
 	make -j 16 && \
	make install && \
	cd ~ && \
	rm -rf binaryen

RUN cd ~ && \
	git clone https://github.com/WebAssembly/wabt.git && \
	cd wabt/ && \
	mkdir build && \
	cd build/ && \
 	cmake -DBUILD_TESTS=off .. && \
	make -j 16 && \
	make install && \
 	cd ~ && \
	rm -rf wabt

RUN 	cd ~ && \
	git clone https://github.com/kripken/emscripten.git && \
	echo 'export PATH=$PATH:~/emscripten' >> ~/.bashrc

