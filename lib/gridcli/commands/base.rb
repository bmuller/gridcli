require 'optparse'
require 'chronic'

module GridCLI
  class BaseCommand
    attr_accessor :cmd, :desc

    def initialize(cmd, desc, default_opts = nil)
      @config = GridCLI.config
      @stats = GridCLI.stats
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

    def error(msg)
      puts msg
      exit 1
    end

    def parse_dates(datestring)
      dates = [nil, nil]
      return dates if datestring.nil? or datestring.strip == ""

      # get start / end parts
      parts = datestring.downcase.split(' to ')
      parts << parts.first if parts.length == 1

      dates[0] = (parts[0].nil? or parts[0].strip == "") ? nil : Chronic.parse(parts[0], :context => :past)
      dates[1] = (parts.length < 2 or parts[1].strip == "") ? nil : Chronic.parse(parts[1], :context => :past)
      dates.map { |d| d.nil? ? nil : Date.parse(d.to_s) }
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
