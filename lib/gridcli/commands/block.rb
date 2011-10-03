module GridCLI
  class BlockCommand < BaseCommand
    def initialize
      super "block", "Block a user from further communication"
    end

    def usage
      super "<username>"
    end

    def run(args)
      # handle options
      usage if args.length == 0
      username = args.shift
      parse_opts args

      begin
        log "Trying to block '#{username}'"
        Blockage.new(:username => username).save
        puts "User '#{username}' blocked"
      rescue ActiveResource::ResourceNotFound
        puts "Sorry, can't find a user with name '#{username}'"
      end
    end
  end

  Runner.register "block", BlockCommand
end
