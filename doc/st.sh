# 29-6-2024


if [ "$(uname -n | sed 's/-[0-9]*$//')" == "login-q" ]; then
   module load ceuadmin/libssh/0.10.6-icelake
   module load ceuadmin/openssh/9.7p1-icelake
fi

git add .gitignore
git commit -m ".gitignore"
git add README.md
git commit -m "README"
git add doc
git commit -m "Documents and auxiliary files"
git add SomaLogic_analysis_plan.md
git commit -m "Analysis plan"
git add SomaLogic.R
git commit -m "Generation of auxiliary files from curated databases"
git add format.* list.sh metal.* QCGWAS.* clump.* qml.* qqman.R
git commit -m "Programs"
git push
