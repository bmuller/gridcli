module GridCLI
  class StatusCommand < BaseCommand
    def initialize
      super "status", "Send a status update to all friends (or specific ones)."
      add_format_option
    end

    def usage
      super "<status> [<username>[,<username>]]"
    end

    def run(args)
      usage if args.length == 0
      body = args.shift
      recipients = pop_arg(args, "friends")
      parse_opts args

      begin
        log "Trying to send a status update '#{body}' to your friends"
        post = Post::Status.create :body => body, :recipients => recipients, :posttype => 'status'
      rescue ActiveResource::ClientError
        puts "There was an error sending your status.  Please make sure it's not empty."
        return
      end
      
      puts "Status posted."
    end
  end

  Runner.register "status", StatusCommand
end
