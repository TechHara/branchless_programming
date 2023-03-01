set -e

echo "rust_branch" > rust1.txt
echo "rust_branchless" > rust2.txt
echo "cc_branch" > cc1.txt
echo "cc_branchless" > cc2.txt

for N in `seq 10 39`; do
    python gen_input.py --n ${N}000 > input_${N}.bin
done

TIME=/usr/bin/time
for N in `seq 10 39`; do
    echo $N
    $TIME -v target/release/branch < input_${N}.bin 2>&1 | grep wall | gawk '{print $8}' | cut -f2 -d: >> rust1.txt
    $TIME -v target/release/branchless < input_${N}.bin 2>&1 | grep wall | gawk '{print $8}' | cut -f2 -d: >> rust2.txt
    $TIME -v target/release/branch_cc < input_${N}.bin 2>&1 | grep wall | gawk '{print $8}' | cut -f2 -d: >> cc1.txt
    $TIME -v target/release/branchless_cc < input_${N}.bin 2>&1 | grep wall | gawk '{print $8}' | cut -f2 -d: >> cc2.txt
done

paste rust1.txt rust2.txt cc1.txt cc2.txt
rm rust1.txt rust2.txt cc1.txt cc2.txt
rm input_*.bin
