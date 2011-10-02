module GridCLI
  class MessageCommand < BaseCommand
    def initialize
      super "message", "Send a message to a friend or group of friends."
    end

    def usage
      super "<username>[,<username>,...] [<subject>] <body>"
    end

    def run(args)
      usage if args.length < 2
      recipients = args.shift
      if args.length > 1 and not args[1].start_with?('-')
        subject = args.shift
      else
        subject = args.first.slice(0,30) + "..."
      end
      body = args.shift
      parse_opts args

      begin
        log "Trying to send a message '#{subject}' to '#{recipients}'"
        post = Post::Message.create :subject => subject, :body => body, :recipients => recipients, :posttype => 'message'
      rescue ActiveResource::ClientError
        puts "There was an error sending your message.  Please make sure everyone in your recipient list is a friend, and the message body isn't empty."
        return
      end

      puts post
    end
  end

  Runner.register "message", MessageCommand
end
