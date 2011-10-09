module GridCLI
  class FriendsCommand < BaseCommand
    def initialize
      super "friends", "List your friends or the friends of a friend"
      add_format_option
    end

    def usage
      super "[<username>]"
    end

    def run(args)
      # handle options
      username = (args.length == 0 or args.first.start_with?('-')) ? @config['username'] : args.shift
      parse_opts args

      begin
        log "Getting all friends of '#{username}'"
        friends = Friendship.find(:all, :params => { :id => username })
        friends.each { |f|
          pprint f.user.to_json
        }
        puts "#{username} has no friends :(" if friends.length == 0
      rescue ActiveResource::ForbiddenAccess
        puts "Looks like '#{username}' isn't one of your friends, so you can't view #{username}'s friends."
      rescue ActiveResource::ClientError
        puts "Sorry, can't find a user with name '#{username}'"
      end
    end
  end

  Runner.register "friends", FriendsCommand
end
