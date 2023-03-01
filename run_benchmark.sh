set -e

for N in `seq 10 39`; do
    python gen_input.py --n ${N}000 > input_${N}.bin
done

PERF="perf stat -e instructions,cache-references,cache-misses,branches,branch-misses"
for EXEC in rust_branch rust_branchless cpp_branch cpp_branchless; do
    for N in `seq 10 39`; do
        $PERF target/release/${EXEC} < input_${N}.bin 2>&1 > output_${EXEC}_${N}.txt 2>&1
    done

    echo "$EXEC" > instructions_$EXEC.txt
    grep instructions output_${EXEC}_*txt | awk '{print $2}' >> instructions_$EXEC.txt
    echo "$EXEC" > branches_$EXEC.txt
    grep -P '^(?!.*\bof\b).*\bbranches\b.*$' output_${EXEC}_*txt | awk '{print $2}' >> branches_$EXEC.txt
    echo "$EXEC" > branch_missies_$EXEC.txt
    grep branch-misses output_${EXEC}_*txt | awk '{print $2}' >> branch_missies_$EXEC.txt
    echo "$EXEC" > time_$EXEC.txt
    grep elapsed output_${EXEC}_*txt | awk '{print $2}' >> time_$EXEC.txt
done
