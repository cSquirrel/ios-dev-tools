
module IOSDevTools

  require 'optparse'

  class Tool

    def process_cmd_line_args cmd_line_arguments

      command_name=cmd_line_arguments[0]

      if not command_name or command_name=="-h" or command_name=="--help"
        command_name="help"
      end

      if not Tool.valid_command_name? command_name
          puts "Unknown command"
          exit
      end

      # create class definition
      command_class=Tool.command_name_to_class command_name

      # NOTE:shift argument array to loose first element which is command name
      # the command is already recognised and is not needed any more
      # this simplifies options parsing inside commands
      ARGV.shift

      # use common factory method to create the command
      command=command_class.create_with_args ARGV
      # execute the command if created
      command.execute if command

    end

    def self.valid_command_name? command_name

      valid_commands=["sign", "pack", "verify", "help"]
      return valid_commands.include? command_name

    end

    def self.command_name_to_class command_name
      # convert snake case to camel case
      c=command_name.gsub(/(?<=_|^)(\w)/){$1.upcase}.gsub(/(?:_)(\w)/,'\1')
      # create class definition
      command_class=nil
      begin
        command_class=Object.const_get("IOSDevTools::#{c}")
      rescue NameError,e
      end
      return command_class
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