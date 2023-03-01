CXX = clang++
CXXFLAGS = -O3 -g -std=c++17
all:
	${CXX} ${CXXFLAGS} src/bin/branch.cc -o target/release/branch_cc
	${CXX} ${CXXFLAGS} src/bin/branchless.cc -o target/release/branchless_cc
