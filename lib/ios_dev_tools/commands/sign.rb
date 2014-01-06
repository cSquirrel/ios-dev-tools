
module IOSDevTools

  require 'optparse'

  class Sign

    def self.create_with_args cmd_line_arguments

      options=parse_options cmd_line_arguments

      return Sign.new options
    end

    def initialize options

      @options=options
      @be_verbose=(options[:verbose]!=nil)

    end

    def self.display_help

      Sign.parse_options ["-h"]

    end

    def verbose_msg message

      puts message if @be_verbose

    end

    def error_msg message

      puts "\nERROR:\t#{message}\n"

    end

    def execute

      verbose_msg "Passed options:\n#{@options.inspect}"

      begin
        provisioning_profile=IOSDevTools::ProvisioningProfile.new @options[:profile_location]
        application_bundle=IOSDevTools::ApplicationBundle.new @options[:input_file] do |ab|
          ab.temp_folder=@options[:temp_folder]
        end
      rescue => error
        error_msg error
        exit 1
      end

      new_bundle_id = @options[:bundle_id]
      new_bundle_id ||= application_bundle.info_plist.bundle_id

      if not provisioning_profile.is_compatible_with_bundle_id new_bundle_id
        error_msg "Provisioning profile identifier [#{provisioning_profile.application_identifier}] is not compatible with bundle identifier [#{new_bundle_id}]\n \
        \tMaybe you should use -b switch to overwrite the bundle identifier?"
        exit 1
      end

      application_bundle.info_plist.bundle_id = new_bundle_id
      application_bundle.set_provisioning_profile provisioning_profile.profile_location
      application_bundle.sign_with_identity @options[:identity]
      application_bundle.package_to_ipa @options[:output_ipa]

      puts "\nApplication archive created and signed: #{@options[:output_ipa]}"

    end

    def self.parse_options(args)

      options = Hash.new
      OptionParser.new do |opts|

        opts.banner = "Usage:
  ios_tool sign -i \"iPhone Distribution: Name\" -p path/to/profile -o output/ipa/file [options] inputIpa"

        opts.separator ""
        opts.separator "Options:"

        opts.on("-p", "--profile PATH_TO_PROFILE", "Path to profile") do |profile_location|
          options[:profile_location] = profile_location
        end

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

        opts.on("--version", "Show version and exit") do |v|
          puts "Version: #{IOSDevTools::VERSION}"
          exit
        end

        # No argument, shows at tail.  This will print an options summary.
        # Try it and see!
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

      end.parse!(args)

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

  end

end