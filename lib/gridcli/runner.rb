require 'active_resource'

module GridCLI
  class Runner
    def self.run(args)
      cmd = args.shift

      aliases = GridCLI.config['alias']
      if aliases.has_key?(cmd)
        args = self.shellsplit(aliases[cmd]) + args
        cmd = args.shift
      end

      cmd = "help" if not @@cmds.has_key? cmd
      begin
        @@cmds[cmd].new.run(args)
      rescue ActiveResource::UnauthorizedAccess
        puts "Sorry gridder, your username or auth token is invalid."
      end
    end

    def self.register(name, klass)
      @@cmds ||= {}
      @@cmds[name] = klass
    end

    def self.command(key)
      @@cmds[key]
    end

    def self.commands
      @@cmds.values
    end

    # taken from http://svn.ruby-lang.org/repos/ruby/trunk/lib/shellwords.rb
    def self.shellsplit(line)
      words = []
      field = ''
      line.scan(/\G\s*(?>([^\s\\\'\"]+)|'([^\']*)'|"((?:[^\"\\]|\\.)*)"|(\\.?)|(\S))(\s|\z)?/m) do
        |word, sq, dq, esc, garbage, sep|
        raise ArgumentError, "Unmatched double quote: #{line.inspect}" if garbage
        field << (word || sq || (dq || esc).gsub(/\\(.)/, '\\1'))
        if sep
          words << field
          field = ''
        end
      end
      words
    end
  end
end
