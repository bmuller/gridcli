module GridCLI
  class LikeCommand < BaseCommand
    def initialize
      super "like", "Like something."
    end

    def usage
      super "<like>"
    end

    def run(args)
      usage if args.length == 0
      body = args.shift
      parse_opts args

      begin
        log "Trying to send a like '#{body}' to your friends"
        post = Post::Like.create :body => body, :recipients => "friends", :posttype => 'like'
      rescue ActiveResource::ClientError
        puts "There was an error sending your like.  Please make sure it's not empty."
        return
      end

      puts post
    end
  end

  Runner.register "like", LikeCommand
end
