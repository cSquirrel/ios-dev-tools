module IOSDevTools

  #NSString *const kCFBundleIconFile                           = @"CFBundleIconFile";
  #NSString *const kCFBundleIconFiles                          = @"CFBundleIconFiles";
  #NSString *const kCFBundleShortVersionString                 = @"CFBundleShortVersionString";
  #NSString *const kCFBundlePackageType                        = @"CFBundlePackageType";
  #NSString *const kMinimumOSVersion                           = @"MinimumOSVersion";
  #NSString *const kLSMinimumSystemVersion                     = @"LSMinimumSystemVersion";
  #NSString *const kLSRequiresIPhoneOS                         = @"LSRequiresIPhoneOS";
  #NSString *const kUILaunchImageFile                          = @"UILaunchImageFile";
  #NSString *const kUILaunchImageFileIphone                    = @"UILaunchImageFile~iphone";
  #NSString *const kUILaunchImageFileIpad                      = @"UILaunchImageFile~ipad";
  #NSString *const kUISupportedInterfaceOrientations           = @"UISupportedInterfaceOrientations";
  #NSString *const kUISupportedInterfaceOrientationsIphone     = @"UISupportedInterfaceOrientations~iphone";
  #NSString *const kUISupportedInterfaceOrientationsIpad       = @"UISupportedInterfaceOrientations~ipad";
  #NSString *const kUIDeviceFamily                             = @"UIDeviceFamily";
  #NSString *const kCFBundleSupportedPlatforms                 = @"CFBundleSupportedPlatforms";
  #NSString *const kCFBundleDisplayName                        = @"CFBundleDisplayName";
  #NSString *const kDTPlatformName                             = @"DTPlatformName";
  #NSString *const kUIAppFonts                                 = @"UIAppFonts";
  #NSString *const kCFBundleIcons                              = @"CFBundleIcons";
  #NSString *const kCFXcodeBuild                               = @"DTXcodeBuild";
  #NSString *const kCFXcodeVersion                             = @"DTXcode";
  #
  #NSString *const kUIRequiredDeviceCapabilities               = @"UIRequiredDeviceCapabilities";
  #NSString *const kUIApplicationExitsOnSuspend                = @"UIApplicationExitsOnSuspend";
  #NSString *const kUIFileSharingEnabled                       = @"UIFileSharingEnabled";
  #NSString *const kUIViewEdgeAntialiasing                     = @"UIViewEdgeAntialiasing";
  #NSString *const kUIViewGroupOpacity                         = @"UIViewGroupOpacity";

  #
  #
  #
  class InfoPlist

    attr_accessor :info_plist_file_path
    attr_accessor :plist_buddy_cmd

    def initialize info_plist_file_path

      @info_plist_file_path=info_plist_file_path

      yield self if block_given?

      @plist_buddy_cmd||="/usr/libexec/PlistBuddy"

      raise "Property list file \"#{info_plist_file_path}\" doesn't exist" if not File.exists? @info_plist_file_path
      raise "Plist editor \"#{info_plist_file_path}\" doesn't exist" if not File.exists? @plist_buddy_cmd

    end

    def set_property property_id, property_value
      return if not property_id or not property_value
      `#{@plist_buddy_cmd} -c "Set :#{property_id} #{property_value}" "#{@info_plist_file_path}"`
    end

    def get_property property_id
      `#{@plist_buddy_cmd} -c "Print :#{property_id}" "#{@info_plist_file_path}"`.strip
    end

    def display_name
      get_property "CFBundleDisplayName"
    end

    def display_name= new_name
      set_property "CFBundleDisplayName", new_name
    end

    def bundle_id
      get_property "CFBundleIdentifier"
    end

    def bundle_id= new_bundle_id
      set_property "CFBundleIdentifier", new_bundle_id
    end

    def xcode_build_number
      get_property "DTXcodeBuild"
    end

    def xcode_version
      get_property "DTXcode"
    end

    def device_family
      parse_array_string get_property "UIDeviceFamily"
    end

    def bundle_icon_file
      get_property "CFBundleIconFile"
    end

    def bundle_icon_files
      parse_array_string get_property "CFBundleIconFiles"
    end

    def bundle_version
      get_property "CFBundlePackageType"
    end

    def bundle_short_version
      get_property "CFBundleShortVersionString"
    end

    def app_fonts
      parse_array_string get_property "UIAppFonts"
    end

    def parse_array_string array_string
      value=array_string
      if not value.empty?
        value=value.split("\n")[1..-2].map {|e| e.strip! }
      end
      value
    end

  end
end