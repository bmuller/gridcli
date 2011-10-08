module GridCLI
  class DislikeCommand < BaseCommand
    def initialize
      super "dislike", "Dislike something."
    end

    def usage
      super "<dislike>"
    end

    def run(args)
      usage if args.length == 0
      body = args.shift
      parse_opts args

      begin
        log "Trying to send a dislike '#{body}' to your friends"
        post = Post::Dislike.create :body => body, :recipients => "friends", :posttype => 'dislike'
      rescue ActiveResource::ClientError
        puts "There was an error sending your dislike.  Please make sure it's not empty."
        return
      end

      puts PrettyPrinter.new(post.to_post_json)
    end
  end

  Runner.register "dislike", DislikeCommand
end
