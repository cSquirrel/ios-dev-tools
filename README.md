# About

Bunch of ruby tools to ease iOS development and deployment pain.  

Latest published version is  
[![Gem Version](https://badge.fury.io/rb/ios_dev_tools.png)](http://badge.fury.io/rb/ios_dev_tools)
# Installation
Typical installation should be as easy as executing the following command:

    $> sudo gem install ios-dev-tools
    
Thsi will install ruby gem and binaries. Common destination for the binaries is '/usr/bin/ios_sign' folder.

Try the following command to make sure the installation was successful

    $> ios_sign -h
    Usage: ios_sign.rb -i "iPhone Distribution: Name" -p path/to/profile -o output/ipa/file [options] inputIpa
    
    ...
        
    $>

# Tools provided

## ios_sign
Manipulates .ipa archive's signature. 

This tool comes handy when you want re-sign bundle in order to test in with
your own provisioning profile.

### Usage
***Re-sign .ipa archive with enterprise profile for testing purposes.***

 * input ipa: Acme.ipa
 * output ipa (re-signed): Acme-QA-Test.ipa
 * identity name: iPhone Distribution: Acme Ltd
 * provisioning profile file: ~/my_profiles/Acme_Enterprise_Distribution.mobileprovision
 
Command line:

    $> ios_sign -i "iPhone Distribution: Acme Ltd" -p ~/my_profiles/Acme_Enterprise_Distribution.mobileprovision -o Acme-QA-Test.ipa Acme.ipa

***Re-sign .ipa archive with enterprise profile and change bundle id for testing purposes.***

 * input ipa: Acme.ipa
 * output ipa (re-signed): Acme-QA-Test.ipa
 * identity name: iPhone Distribution: Acme Ltd
 * provisioning profile file: ~/my_profiles/Acme_Enterprise_Distribution.mobileprovision
 * new bundle id: com.acme.qa.app
 
Command line:

    $> ios_sign -i "iPhone Distribution: Acme Ltd" -p ~/my_profiles/Acme_Enterprise_Distribution.mobileprovision -o Acme-QA-Test.ipa -b com.acme.qa.app Acme.ipa


## ios_verify
Verifies .ipa archive according to number of rules. 

To be used for validation before submission to Apple App Store.