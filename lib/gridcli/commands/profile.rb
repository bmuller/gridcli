module GridCLI
  class ProfileCommand < BaseCommand
    def initialize
      super "profile", "Show profile information for other users or update own profile", { :update => false }
      add_option("--github-user username", "Set your username on github") { |u| 
        @opts[:github_username] = u 
        @opts[:update] = true
      }
      add_option("--name fullname", "Set your full name") { |u| 
        @opts[:name] = u
        @opts[:update] = true
      }
    end

    def usage
      super "[username]"
    end

    def run(args)
      username = (args.length == 0 || args.first.start_with?('-')) ? @config['username'] : args.shift
      parse_opts args

      begin
        log "Trying to find user with name '#{username}'"
        user = User.find(username)
      rescue ActiveResource::ResourceNotFound
        puts "Sorry, username '#{username}' does not exist."
        return
      rescue ActiveResource::ClientError
        puts "Sorry, you cannot see the profile for '#{username}'"
        return
      end

      # if we're supposed to update, do so
      if @opts[:update]
        [:github_username, :name].each { |n| user.send("#{n.to_s}=", @opts[n]) }
        user.id = username
        user.save
      end

      puts user
    end
  end

  Runner.register "profile", ProfileCommand
end
