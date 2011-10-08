module GridCLI
  class SignupCommand < BaseCommand
    def initialize
      super "signup", "Create an account on the grid"
    end

    def usage
      super "<username>"
    end

    def run(args)
      # handle options
      usage if args.length == 0
      username = args.shift
      parse_opts args

      username = GridCLI.hooker.invoke :before_signup, username

      @config["username"] = username
      @config.save
      
      begin
        log "Trying to create new user with name '#{username}'"
        User.new(:username => username, :token => @config['token']).save
        puts "New user created.  You are now known as '#{username}'"
      rescue ActiveResource::ClientError
        puts "Sorry, username '#{username}' already exists."
      end
    end
  end

  Runner.register "signup", SignupCommand
end
