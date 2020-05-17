import os

if __name__ == "__main__":
    params = [('21', '70to100'),
        ('24', '100to200'),
        ('25', '200to400'),
        ('28', '400to600'),
        #('30', 'cHB'),
        ('32', '600to800'),
        ('45', '800to1200'),
        ('46', '1200to2500'),
        ('47', '2500toInf'),
    ]

    # loop over parameters to be restricted
    for ipar,param in enumerate(params):
        # 1D cards
        process='submit_'+ params[ipar][1]+'.jdl'
        os.system('condor_submit {0}'.format(process))
        
