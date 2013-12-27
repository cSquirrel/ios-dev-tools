#!/usr/bin/ruby

#./floatsign source "iPhone Distribution: Name" -p "path/to/profile" [-d "display name"]  [-e entitlements] [-k keychain] -b "BundleIdentifier" outputIpa

require 'optparse'
#require 'pathname'
require 'lib/application_bundle'
require 'lib/provisioning_profile'

PLIST_BUDDY_CMD="/usr/libexec/PlistBuddy"

$be_verbose=false

def verbose_msg message

  puts message if $be_verbose

end

def error_msg message

  puts "\nERROR:\t#{message}\n"

end

def parse_options(args)

  options = Hash.new
  OptionParser.new do |opts|

    opts.banner = "Usage: ios_sign.rb -i \"iPhone Distribution: Name\" -p path/to/profile -o output/ipa/file [options] inputIpa"

    opts.separator ""
    opts.separator "Options:"

    opts.on("-p", "--profile PATH_TO_PROFILE", "Path to profile") do |profile_location|
      options[:profile_location] = profile_location
    end

    #opts.on("-d", "--display-name [DISPLAY_NAME]", "Display name") do |display_name|
    #  options[:display_name] = display_name
    #end

    #opts.on("-e", "--entitlements [ENTITLEMENTS]", "Entitlements") do |entitlements|
    #  options[:entitlements] = entitlements
    #end

    #opts.on("-k", "--keychain [KEYCHAIN]", "Keychain") do |keychain|
    #  options[:keychain] = keychain
    #end

    opts.on("-b", "--bundle-id [BUNDLE_IDENTIFIER]", "Bundle identifier") do |bundle_id|
      options[:bundle_id] = bundle_id
    end

    opts.on("-o", "--output OUTPUT_IPA_FILE", "Output ipa archive") do |output_ipa|
      options[:output_ipa] = output_ipa
    end

    opts.on("-i", "--identity IDENTITY", "Identity") do |identity|
      options[:identity] = identity
    end

    opts.on("-t", "--temp [TEMP_FOLDER]", "Temporary folder location") do |temp_folder|
      options[:temp_folder] = temp_folder
    end

    opts.separator ""
    opts.separator "Common options:"

    opts.on("-v", "--verbose", "Run verbosely") do |v|
      options[:verbose] = v
    end

    # No argument, shows at tail.  This will print an options summary.
    # Try it and see!
    opts.on_tail("-h", "--help", "Show this message") do
      puts opts
      exit
    end

  end.parse!(args)

  # default values (if not supplied)
  options[:temp_folder]="temp" if not options[:temp_folder]

  options[:input_file]=ARGV[0]
  mandatory=[options[:profile_location],options[:identity],options[:output_ipa],options[:input_file]]
  expected_number=mandatory.count
  real_number=mandatory.compact.count
  if expected_number != real_number
    # one of mandatory switches is missing
    # display help and exit
    parse_options ["-h"]
  end

  return options
end

def validate_options options
# Check if the supplied file is an ipa or an app file
  valid=true
  if not File.exists? options[:input_file]
    puts "File not found: #{options[:input_file]}"
    valid=false
  end
  if not File.exists? options[:input_file]
    puts "File not found: #{options[:output_ipa]}"
    valid=false
  else
    # Check if the supplied file is an ipa or an app file
    options[:input_is_app]=File.directory? options[:input_file]
  end
  exit 1 if not valid

  return options
end

# parse and validate options
# stop execution if required
options=validate_options parse_options ARGV
$be_verbose=(options[:verbose]!=nil)

verbose_msg "Passed options:\n#{options.inspect}"

ab=ApplicationBundle.new options[:input_file] do |ab|
  ab.temp_folder=options[:temp_folder]
end

# Set the app name
# The app name is the only file within the Payload directory
application_folder=ab.location
application_name=ab.application_name
verbose_msg "application_name: #{application_name}"

current_name=ab.display_name
current_bundle_identifier=ab.bundle_id

pp=ProvisioningProfile.new options[:profile_location]
provisioning_bundle_identifier=pp.application_identifier

new_bundle_id = options[:bundle_id]
new_bundle_id ||= current_bundle_identifier

if not pp.is_compatible_with_bundle_id new_bundle_id
  error_msg "Provisioning profile identifier [#{provisioning_bundle_identifier}] is not compatible with bundle identifier [#{new_bundle_id}]\n \
  \tMaybe you should use -b switch to overwrite the bundle identifier?"
  exit 1
end

verbose_msg "current_name: #{current_name}"
verbose_msg "current_bundle_identifier: #{current_bundle_identifier}"
verbose_msg "provisioning_bundle_identifier: #{provisioning_bundle_identifier}"

#
ab.bundle_id = new_bundle_id

#
ab.set_provisioning_profile pp.profile_location
ab.sign_with_identity options[:identity]

#`codesign -d -vvv "#{application_folder}"` if $be_verbose

#repackage application_folder, options[:output_ipa], options[:temp_folder]
ab.package_to_ipa options[:output_ipa]