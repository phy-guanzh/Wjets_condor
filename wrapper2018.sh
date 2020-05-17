exit_on_error() {
    result=$1
    code=$2
    message=$3

    if [ $1 != 0 ]; then
        echo $3
        exit $2
    fi
}

#### FRAMEWORK SANDBOX SETUP ####
# Load cmssw_setup function
source cmssw_setup.sh

# Setup CMSSW Base
export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh


wget --no-check-certificate --progress=bar "http://stash.osgconnect.net/+zguan/Wjets/condor/B2G-Run3Summer19wmLHEGS-00017_1_cfg.py"  || exit_on_error $? 150 "Could not download sandbox1."
cmsrel CMSSW_10_2_18
cd CMSSW_10_2_18/src
cmsenv
cd -
# Download sandbox, replace it when you have different sandbox_name
sandbox_name1="sandbox-CMSSW_10_2_6-e33be22.tar.bz2"
sandbox_name2="sandbox-CMSSW_10_2_18-441666a.tar.bz2"
# Change to your own http
wget --no-check-certificate --progress=bar "http://stash.osgconnect.net/+zguan/Wjets/condor/${sandbox_name1}"  || exit_on_error $? 150 "Could not download sandbox1."
wget --no-check-certificate --progress=bar "http://stash.osgconnect.net/+zguan/Wjets/condor/${sandbox_name2}"  || exit_on_error $? 150 "Could not download sandbox1."

pushd .
# Setup framework from sandbox
cmssw_setup $sandbox_name1 || exit_on_error $? 151 "Could not unpack sandbox"
popd
sandbox_name="WJetsToLNu_HT-$1_slc6_amd64_gcc630_CMSSW_9_3_8_tarball.tar.xz"
wget --no-check-certificate --progress=bar "http://stash.osgconnect.net/+zguan/Wjets/MG265/${sandbox_name}"  || exit_on_error $? 150 "Could not download sandbox Wjets."
sed -i "s/^.*tarball.tar.xz.*$/     args = cms.vstring(\'..\/$sandbox_name\'),/" -i B2G-Run3Summer19wmLHEGS-00017_1_cfg.py

cmsRun B2G-Run3Summer19wmLHEGS-00017_1_cfg.py
rm $sandbox_name
#cmsRun SMP-RunIIAutumn18DRPremix-00048_1_cfg.py
#rm SMP-RunIIFall18wmLHEGS-00059_inLHE.root SMP-RunIIFall18wmLHEGS-00059.root
#cmsRun SMP-RunIIAutumn18DRPremix-00048_2_cfg.py
#rm SMP-RunIIAutumn18DRPremix-00048_step1.root
#cmsRun SMP-RunIIAutumn18MiniAOD-00048_1_cfg.py
#rm SMP-RunIIAutumn18DRPremix-00048.root
rm -rf cmssw-tmp
# Setup framework from sandbox
#pushd .
#cmssw_setup $sandbox_name2 || exit_on_error $? 151 "Could not unpack sandbox"
#popd
#cmsRun SMP-RunIIAutumn18NanoAODv6-00019_1_cfg.py
#rm SMP-RunIIAutumn18MiniAOD-00048.root
# clean
#rm -rf cmssw-tmp
rm *py
rm *pyc
rm $sandbox_name1
rm $sandbox_name2
