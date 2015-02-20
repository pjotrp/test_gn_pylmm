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

env PYTHONPATH=$pylmm_lib_path python $pylmm_lib_path/lmm.py
exit 0

/usr/bin/time -v env PYTHONPATH=. python scripts/pylmmKinship.py -v --bfile data/test_snps.132k.clean.noX out.kin --test --test -t 1
/usr/bin/time -v env PYTHONPATH=. python scripts/pylmmGWAS.py -v --bfile data/snps.132k.clean.noX --kfile data/snps.132k.clean.noX.pylmm.kin --phenofile data/snps.132k.clean.noX.fake.phenos out.foo --test -t 1
md5sum *