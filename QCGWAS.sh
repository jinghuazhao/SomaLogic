# 17-12-2018 JHZ

export rt=$HOME/SomaLogic
cd $rt
cat $rt/doc/SomaLogic.list | \
parallel --env rt -j1 -C' ' '
   echo {}; \
   export protein={}; \
   cd $rt/work; \
   if [ ! -d {} ]; then mkdir {}; fi; \
   cd -; \
   R --no-save -q < $rt/QCGWAS.R > $rt/work/{}.log'

function single_protein_as_argument()
{
# mkdir
declare -a prot=(10336-3_3 10337-83_3)
for s in $(seq 1 ${#prot[@]}); do
    export protein=${prot[$(( $s-1 ))]}
    if [ ! -d work/$protein ]; then mkdir $rt/work/$protein; fi
done
# QCGWAS
export protein=$1
R --no-save -q < QCGWAS.R > $rt/work/$protein.log
}
