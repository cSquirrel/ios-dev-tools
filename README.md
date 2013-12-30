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

## ios_verify
Verifies .ipa archive according to number of rules. 

To be used for validation before submission to Apple App Store.