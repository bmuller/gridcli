module GridCLI
  class UpdateCommand < BaseCommand
    def initialize
      super "update", "Download all messages"
    end

    def run(args)
      parse_opts args
      last_sha = @config['last_sha']

      begin
        if last_sha.nil?
          log "Trying to download all messages."
          posts = Post::Message.find(:all)
        else
          log "Trying to download all messages since '#{last_sha}'"
          posts = Post.find(:all, :params => { :id => last_sha })
        end
      rescue ActiveResource::ClientError
        puts "There was an error updating your messages."
        return
      end

      posts.each { |p| puts "#{p.to_s}\n\n" }
      GridCLI.storage.append(posts)
    end
  end

  Runner.register "update", UpdateCommand
end
