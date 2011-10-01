module GridCLI
  class SignupCommand < BaseCommand
    def initialize
      super "signup", "Create an account on the grid"
      #default_opts = { :privkey => "~/.ssh/id_rsa", :pubkey => "~/.ssh/id_rsa.pub" }
      #super "signup", "Create an account on the grid", default_opts
      # @optp.on("--private-key path", "Location of id_rsa file") { |key| @opts[:privkey] = key }
      # @optp.on("--public-key path", "Location of id_rsa.pub file") { |key| @opts[:pubkey] = key }
    end

    def usage
      super "<username>"
    end

    def run(args)
      # handle options
      usage if args.length == 0
      username = args.shift
      parse_opts args

      if @config["token"].nil?
        @config["token"] = Crypt.generate_token(username)
        @config.save
      end
        

      public_key = Crypt.public_key      
      puts "#{username} #{@config['token']} #{public_key}"
    end
  end

  Runner.register "signup", SignupCommand
end
