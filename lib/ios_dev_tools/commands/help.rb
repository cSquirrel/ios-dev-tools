
#
#
#
module IOSDevTools

  require 'optparse'

  #
  #
  #
  class Help

    #
    #
    #
    def self.create_with_args cmd_line_arguments

      options=parse_options cmd_line_arguments
      return Help.new options

    end

    #
    #
    #
    def self.parse_options(args)

      options={}
      options[:help_option]=args[0]

      return options
    end

    #
    #
    #
    def initialize options

      @options=options

    end

    #
    #
    #
    def execute

      Help.display_banner

      if not @options[:help_option]
        # no option give, display generic help
        display_generic_help
      elsif @options[:help_option]=="commands"
        # list of commands requested
        display_available_commands
      else
        # command specific help requested
        command_name=@options[:help_option]
        if not Tool.valid_command_name? command_name
            display_unknown_command command_name
        else
          display_command_specific_help command_name
        end
      end
    end

    #
    #
    #
    def display_unknown_command command_name
      puts "
ERROR: Unknown command: #{command_name}
"
      display_generic_help
    end

    #
    #
    #
    def self.display_banner
      puts "iOS Development Tools v.#{VERSION}

"
    end

    #
    #
    #
    def display_available_commands
      puts "
  Available commands:

    sign    - sign application bundle/archive
    verify  - verify application bundle/archive
    pack    - pack application bundle into archive

  Execute following command to see command specific help

    ios_tool help [COMMAND NAME]
           "

    end

    #
    #
    #
    def display_generic_help
      puts "

  TODO: ios_tool help


    help commands       - displays available commands
    help [COMMAND NAME] - displays command specific help


           "

    end

    #
    #
    #
    def display_command_specific_help command_name
      command_class=Tool.command_name_to_class command_name
      command_class.display_help
    end

  end
end