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

echo "*** Convert kinship, genotype and phenotype files to new format 1.0"
env PYTHONPATH=$pylmm_lib_path:./lib python $pylmm_lib_path/convertlmm.py -v --kinship data/test_snps.132k.clean.noX.pylmm.kin > test.kin
python my_pylmm/pyLMM/runlmm.py --kinship test.kin parse

# /usr/bin/time -v env PYTHONPATH=$pylmm_lib_path:./lib python ./scripts/pylmmGWAS.py -v --genotype data/test_snps.132k.clean.noX --kfile data/test_snps.132k.clean.noX.pylmm.kin --phenofile data/test_snps.132k.clean.noX.fake.phenos

# env PYTHONPATH=$pylmm_lib_path python $pylmm_lib_path/lmm.py
# md5sum *.foo
