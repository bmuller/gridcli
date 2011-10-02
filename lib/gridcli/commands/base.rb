require 'optparse'

module GridCLI
  class BaseCommand
    attr_accessor :cmd, :desc

    def initialize(cmd, desc, default_opts = nil)
      @config = GridCLI.config
      @cmd = cmd
      @desc = desc
      @opts = default_opts || {}
      @optp = OptionParser.new { |opts|
        opts.on("-v", "--verbose", "Run verbosely") { |v| @opts[:verbose] = v }
      }
    end

    def add_option(*args) 
      @optp.on(*args) { |u| yield u }
    end

    def usage(cmd_opts=nil)
      cmd_opts ||= ""
      @optp.banner = "Usage: grid #{@cmd} #{cmd_opts} [options]"
      puts @optp
      exit
    end

    def parse_opts(args)
      begin
        @optp.parse(args)
      rescue 
        usage
      end
    end

    def log(msg)
      return unless @opts[:verbose]
      puts "[debug]: #{msg}"
    end
  end
end
