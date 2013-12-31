
module IOSDevTools

  require 'optparse'

  class Help

    def self.create_with_args cmd_line_arguments

      options=parse_options cmd_line_arguments

      return Help.new options
    end

    def initialize options

      @options=options

    end

    def execute

      puts "

  TODO: ios_tool help


    help commands - displays available commands


           "

    end

    def self.parse_options(args)

    end

  end
end