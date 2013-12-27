
require 'pathname'

#
#
#
class ApplicationBundle

  attr_accessor :is_application_folder
  attr_accessor :is_valid_zip_archive
  attr_accessor :src_location
  attr_accessor :location
  attr_accessor :temp_folder
  attr_accessor :plist_buddy_cmd
  attr_accessor :application_name

  def initialize file_or_folder_location

    raise "Application bundle \"#{file_or_folder_location}\" doesn't exist" if not File.exists? file_or_folder_location

    @is_application_folder=File.directory?(file_or_folder_location) && file_or_folder_location.end_with?(".app")
    if not @is_application_folder
      @is_valid_zip_archive=`file #{file_or_folder_location}`.include? "Zip archive data"
      raise "[#{file_or_folder_location}] is not a valid application archive" if not @is_valid_zip_archive
    end

    @src_location=file_or_folder_location
    @temp_folder="temp"
    @plist_buddy_cmd="/usr/libexec/PlistBuddy"

    yield self if block_given?

    if not @is_application_folder
      # wipeout  folder
      `rm -Rf #{temp_folder}/Payload 2>&1 > /dev/null`
      # unzip application bundle
      `unzip -q "#{@src_location}" -d #{@temp_folder}`
      # point to unzipped location
      @location=Dir.glob("#{@temp_folder}/Payload/*")[0]
    else
      @location=@src_location
    end

    @application_name=Pathname.new(@location).basename

  end

  def display_name
    `#{@plist_buddy_cmd} -c "Print :CFBundleDisplayName" "#{@location}/Info.plist"`.strip
  end

  def display_name= new_name
    return if not new_name
    `#{@plist_buddy_cmd} -c "Set :CFBundleDisplayName #{new_name}" "#{@location}/Info.plist"`
  end

  def bundle_id
    `#{@plist_buddy_cmd} -c "Print :CFBundleIdentifier" "#{@location}/Info.plist"`.strip
  end

  def bundle_id= new_bundle_id
    return if not new_bundle_id
    `#{@plist_buddy_cmd} -c "Set :CFBundleIdentifier #{new_bundle_id}" "#{@location}/Info.plist"`
  end

  def set_provisioning_profile new_provisioning_profile_location
    return if not new_provisioning_profile_location
    `cp "#{new_provisioning_profile_location}" "#{@location}/embedded.mobileprovision"`
  end

  def sign_with_identity new_identity
    return if not new_identity
    `/usr/bin/codesign -f -s "#{new_identity}" --resource-rules="#{@location}/ResourceRules.plist" "#{@location}" 2>&1`
  end

  def current_identity

    invalid_signature=`codesign -d -vv "#{@location}" 2>&1`.include? "invalid signature"
    return "Invalid signature" if invalid_signature

    codesign_output=`codesign -d -vv "#{@location}" 2>&1 | grep "Authority"`
    info=codesign_output.lines.first
    return info.strip.split("=")[1] if info

    return nil

  end

  def package_to_ipa ipa_file_location
    return if not ipa_file_location
    `(cd #{@temp_folder} && zip -qr ../temp.ipa *) && mv temp.ipa "#{ipa_file_location}"`
  end

end