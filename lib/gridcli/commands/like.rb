module GridCLI
  class LikeCommand < BaseCommand
    def initialize
      super "like", "Like something. Specify friends/subgrids to restrict recipients."
      add_format_option
    end

    def usage
      super "<like> [<username>[,<username>]]"
    end

    def run(args)
      usage if args.length == 0
      body = args.shift
      recipients = pop_arg(args, "friends")
      parse_opts args

      begin
        log "Trying to send a like '#{body}' to your friends"
        post = Post::Like.create :body => body, :recipients => recipients, :posttype => 'like'
      rescue ActiveResource::ClientError
        puts "There was an error sending your like.  Please make sure it's not empty."
        return
      end

      puts "Like posted."
    end
  end

  Runner.register "like", LikeCommand
end
