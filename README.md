# Wjets_condor
##How to use 
mkdir Wjets
cd Wjets
git clone git@github.com:phy-guanzh/Wjets_condor.git
mkdir log
python build_submit.py
rm build_submit.py
chmod 777 wrapper*.sh
python submit_jobs.py
