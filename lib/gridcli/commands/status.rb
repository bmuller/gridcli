module GridCLI
  class StatusCommand < BaseCommand
    def initialize
      super "status", "Send a status update to all friends."
    end

    def usage
      super "<status>"
    end

    def run(args)
      usage if args.length == 0
      body = args.shift
      parse_opts args

      begin
        log "Trying to send a status update '#{body}' to your friends"
        post = Post.create :body => body, :recipients => "friends", :posttype => 'status'
      rescue ActiveResource::ClientError
        puts "There was an error sending your status.  Please make sure it's not empty."
        return
      end

      puts post
    end
  end

  Runner.register "status", StatusCommand
end