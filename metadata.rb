name 'hdeploy'

depends 'enterprise' if __FILE__.start_with?('/opt/hdeploy') # Trick for this to only happen in the embedded chef

