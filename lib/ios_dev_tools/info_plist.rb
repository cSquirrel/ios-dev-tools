module IOSDevTools

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
      `#{@plist_buddy_cmd} -c "Set :#{property_id} #{new_name}" "#{@info_plist_file_path}"`
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

  end
end