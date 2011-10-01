module GridCLI
  class ProfileCommand < BaseCommand
    def initialize
      super "profile", "Show profile information for other users or update own profile", { :update => false }
      @optp.on("--github-user username", "Set your username on github") { |u| @opts[:github_username] = u }
      @optp.on("--name fullname", "Set your full name") { |u| @opts[:name] = u }
      @optp.on("--update", "Set values for your profile") { |u| @opts[:update] = u }
    end

    def usage
      super "[username]"
    end

    def run(args)
      username = args.length == 0 ? @config['username'] : args.shift
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

      if @opts[:update]
        attrs = {}
        [:github_username, :name].each { |n| attrs[n] = @opts[n] unless @opts[n].nil? }
        user.id = username
        user.update_attributes(attrs)
      end
      puts user.encode
      puts user.username
      puts user
    end
  end

  Runner.register "profile", ProfileCommand
end
