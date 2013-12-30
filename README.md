# About

Bunch of ruby tools to ease iOS development and deployment pain.

# Installation
Always the latest version is available at [rubygems.org](https://rubygems.org/gems/ios_dev_tools). Typical installation should be as easy es executing following command:

    $> sudo gem install ios-dev-tools
    
Thsi will install ruby gem and binaries. Common destination for the binaries is '/usr/bin/ios_sign' folder.

Try the following command to make sure the installation was successful

    $> ios_sign -h
    Usage: ios_sign.rb -i "iPhone Distribution: Name" -p path/to/profile -o output/ipa/file [options] inputIpa
    
    Options:
        -p, --profile PATH_TO_PROFILE    Path to profile
        -b [BUNDLE_IDENTIFIER]           Bundle identifier
            --bundle-id
        -o, --output OUTPUT_IPA_FILE     Output ipa archive
        -i, --identity IDENTITY          Identity
        -t, --temp [TEMP_FOLDER]         Temporary folder location
    
    Common options:
        -v, --verbose                    Run verbosely
        -h, --help                       Show this message
        
    $>


# Tools provided

## ios_sign
Manipulates .ipa archive's signature. This tool comes handy when you want re-sign bundle in order to test in with
your own provisioning profile.

## ios_verify
Verifies .ipa archive according to number of rules. To be used for validation before submission to Apple App Store.