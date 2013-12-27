#!/usr/bin/ruby

#./floatsign source "iPhone Distribution: Name" -p "path/to/profile" [-d "display name"]  [-e entitlements] [-k keychain] -b "BundleIdentifier" outputIpa

require 'optparse'
require 'pathname'

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

def set_bundle_id plist_file, new_bundle_id

  verbose_msg "Changing bundle id to: #{new_bundle_id}"
  `#{PLIST_BUDDY_CMD} -c "Set :CFBundleIdentifier #{new_bundle_id}" "#{plist_file}"`

end

def replace_embedded_profile application_folder, profile_location

    `cp "#{profile_location}" "#{application_folder}/embedded.mobileprovision"`

end

def repackage application_folder, output_ipa, temp_folder

  `(cd #{temp_folder} && zip -qr ../temp.ipa *) && mv temp.ipa "#{output_ipa}"`

end

# parse and validate options
# stop execution if required
options=validate_options parse_options ARGV
$be_verbose=(options[:verbose]!=nil)

verbose_msg "Passed options:\n#{options.inspect}"

# wipe out temp folder
`rm -Rf #{options[:temp_folder]} 2>&1 > /dev/null`

# prepare input
if options[:input_is_app]
  `mkdir -p "#{options[:temp_folder]}/Payload"`
  `cp -Rf "#{options[:input_file]}" "temp/Payload/#{options[:input_file]}"`
else
  # unzip archive (if input is not app bundle)
  `unzip -q "#{options[:input_file]}" -d #{options[:temp_folder]}` if not options[:input_is_app]
end

# unlock keychain if selected
#if options[:keychain]
#  `security list-keychains -s #{options[:keychain]} && security unlock #{options[:keychain]} && security default-keychain -s #{options[:keychain]}`
#end

# Set the app name
# The app name is the only file within the Payload directory
application_folder=Dir.glob("#{options[:temp_folder]}/Payload/*")[0]
application_name=Pathname.new(application_folder).basename
verbose_msg "application_name: #{application_name}"

current_name=`#{PLIST_BUDDY_CMD} -c "Print :CFBundleDisplayName" "#{application_folder}/Info.plist"`
current_bundle_identifier=`#{PLIST_BUDDY_CMD} -c "Print :CFBundleIdentifier" "#{application_folder}/Info.plist"`
provisioning_bundle_identifier=`egrep -a -A 2 application-identifier "#{options[:profile_location]}" | grep string | sed -e 's/<string>//' -e 's/<\\/string>//' -e 's/ //' | awk '{split($0,a,"."); i = length(a); for(ix=2; ix <= i;ix++){ s=s a[ix]; if(i!=ix){s=s "."};} print s;}'`
current_bundle_identifier.strip!
provisioning_bundle_identifier.strip!

new_bundle_id = current_bundle_identifier
new_bundle_id = options[:bundle_id] if options[:bundle_id]

bundle_id_prefix=provisioning_bundle_identifier.sub(/\*$/,"")
is_bundle_id_compatible=new_bundle_id.start_with? bundle_id_prefix

if not is_bundle_id_compatible
  error_msg "Provisioning profile identifier [#{provisioning_bundle_identifier}] is not compatible with bundle identifier [#{new_bundle_id}]\n \
  \tMaybe you should use -b switch to overwrite the bundle identifier?"
  exit 1
end

verbose_msg "current_name: #{current_name}"
verbose_msg "current_bundle_identifier: #{current_bundle_identifier}"
verbose_msg "provisioning_bundle_identifier: #{provisioning_bundle_identifier}"

#
set_bundle_id("#{application_folder}/Info.plist", options[:bundle_id]) if options[:bundle_id]

#
replace_embedded_profile application_folder, options[:profile_location]
verbose_msg "/usr/bin/codesign -f -s \"#{options[:identity]}\" --resource-rules=\"#{application_folder}/ResourceRules.plist\" \"#{application_folder}\""
`/usr/bin/codesign -f -s "#{options[:identity]}" --resource-rules="#{application_folder}/ResourceRules.plist" "#{application_folder}"`

`codesign -d -vvv "#{application_folder}"` if $be_verbose

repackage application_folder, options[:output_ipa], options[:temp_folder]