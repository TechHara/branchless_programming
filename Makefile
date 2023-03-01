CXX = clang++
CXXFLAGS = -O3 -g -std=c++17
all:
	${CXX} ${CXXFLAGS} src/bin/cpp_branch.cc -o target/release/cpp_branch
	${CXX} ${CXXFLAGS} src/bin/cpp_branchless.cc -o target/release/cpp_branchless
