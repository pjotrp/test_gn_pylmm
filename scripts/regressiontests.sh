#! /bin/bash
#
#  Ascertain that the GN my_pylmm is linked as a symlink!
#
#  ./scripts/test_run.sh &> test.out
#

pylmm_path=my_pylmm
pylmm_lib_path=my_pylmm/pyLMM

if [ ! -d $pylmm_lib_path ]; then
    echo "The symlink to $pylmm_path is not working!"
    exit 1
fi

env PYTHONPATH=$pylmm_lib_path:./lib python $pylmm_lib_path/runlmm.py --pheno data/small.pheno --geno data/small.geno redis > test/data/regression/small.new
[ $? -ne 0 ] && exit 1

env PYTHONPATH=$pylmm_lib_path:./lib python $pylmm_lib_path/runlmm.py --pheno data/small.pheno --geno data/small_na.geno redis > test/data/regression/small_na.new
[ $? -ne 0 ] && exit 1

env PYTHONPATH=$pylmm_lib_path:./lib python $pylmm_lib_path/runlmm.py --geno data/small.geno kinship --test-kinship > test/data/regression/k_small.new
[ $? -ne 0 ] && exit 1

env PYTHONPATH=$pylmm_lib_path:./lib python $pylmm_lib_path/runlmm.py --geno data/small_na.geno kinship --maf-normalization --test-kinship > test/data/regression/k_small_na.new
[ $? -ne 0 ] && exit 1

env PYTHONPATH=$pylmm_lib_path:./lib python $pylmm_lib_path/runlmm.py --pheno data/test8000.pheno --geno data/test8000.geno redis > test/data/regression/test8000.new
[ $? -ne 0 ] && exit 1

diff test/data/regression/small.new test/data/regression/small.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/small_na.new test/data/regression/small_na.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/k_small.new test/data/regression/k_small.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/k_small_na.new test/data/regression/k_small_na.ref|grep -v seconds
[ $? -ne 0 ] && exit 1

diff test/data/regression/test8000.new test/data/regression/test8000.ref|grep -v seconds
[ $? -ne 0 ] && exit 1
