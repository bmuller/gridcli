module GridCLI
  class BefriendCommand < BaseCommand
    def initialize
      super "befriend", "Request friendship with someone"
      add_option("--message message", "-m message", "Add a person message to the request.") { |m|
        @opts[:message] = m
      }
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
        log "Trying to create new friendship with '#{username}'"
        Friendship.new(:username => username).save
        puts "Friendship request sent."
      rescue ActiveResource::ForbiddenAccess
        puts "Looks like '#{username}' doesn't want to be your friend."
      rescue ActiveResource::ResourceConflict
        puts "You are already friends with '#{username}'"
      rescue ActiveResource::ResourceNotFound
        puts "Sorry, can't find a user with name '#{username}'"
      end
    end
  end

  Runner.register "befriend", BefriendCommand
end
