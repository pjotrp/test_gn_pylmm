#! /bin/bash
#
#  Ascertain that the GN my_pylmm is linked as a symlink!
#
#  ./scripts/test_run.sh &> test.out
#

pylmm_path=pylmm_gn2
pylmm_lib_path=pylmm_gn2/pylmm_gn2:../scikits.cuda
runlmm="env PYTHONPATH="$pylmm_lib_path:$PYTHONPATH" python $pylmm_path/bin/runlmm.py"

echo "small_run.new"
$runlmm --pheno data/small.pheno --geno data/small.geno run > test/data/regression/small_run.new
[ $? -ne 0 ] && exit 1

# echo "small.new"
# $runlmm --pheno data/small.pheno --geno data/small.geno redis > test/data/regression/small.new
# [ $? -ne 0 ] && exit 1

# echo "small_na.new"
# $runlmm --pheno data/small_na.pheno --geno data/small_na.geno redis --remove-missing-phenotypes > test/data/regression/small_na.new
# [ $? -ne 0 ] && exit 1

echo "small2.new"
# $runlmm --pheno data/small.pheno --geno data/small.geno redis_new > test/data/regression/small2.new
[ $? -ne 0 ] && exit 1

echo "small_na2.new"
# $runlmm --pheno data/small_na.pheno --geno data/small_na.geno redis_new > test/data/regression/small_na2.new
[ $? -ne 0 ] && exit 1

echo "k_small.new"
$runlmm --geno data/small.geno kinship --test-kinship > test/data/regression/k_small.new
[ $? -ne 0 ] && exit 1

echo "k_small_na.new"
$runlmm --geno data/small_na.geno kinship --maf-normalization --test-kinship > test/data/regression/k_small_na.new
[ $? -ne 0 ] && exit 1

echo "test8000_run.new"
$runlmm --pheno data/test8000.pheno --geno data/test8000.geno run > test/data/regression/test8000_run.new
[ $? -ne 0 ] && exit 1

# echo "test8000.new"
# $runlmm --pheno data/test8000.pheno --geno data/test8000.geno redis --remove-missing-phenotypes > test/data/regression/test8000.new
# [ $? -ne 0 ] && exit 1

echo "test8000_new.new"
# $runlmm --pheno data/test8000.pheno --geno data/test8000.geno redis_new > test/data/regression/test8000_new.new
[ $? -ne 0 ] && exit 1

diff test/data/regression/small.new test/data/regression/small.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/small_run.new test/data/regression/small_run.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/small_na.new test/data/regression/small_na.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/small2.new test/data/regression/small2.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/small_na2.new test/data/regression/small_na2.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/k_small.new test/data/regression/k_small.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/k_small_na.new test/data/regression/k_small_na.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/test8000_run.new test/data/regression/test8000_run.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/test8000.new test/data/regression/test8000.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/test8000_new.new test/data/regression/test8000_new.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

echo "rename 's/.new/.ref/' test/data/regression/*.new -f"

