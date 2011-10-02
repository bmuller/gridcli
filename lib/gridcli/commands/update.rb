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
          posts = Post::Message.find(:all, :params => { :id => last_sha })
        end
      rescue ActiveResource::ClientError
        puts "There was an error updating your messages."
        return
      end
      
      save posts
    end

    def save(posts)
      if posts.length == 0
        puts "Up to date."
      else
        posts.each { |p| puts "#{p.to_s}\n\n" }
        @config['last_sha'] = GridCLI.storage.append(posts)
        @config.save
      
        # run again if we got back 300 posts
        run(args) if posts.length == 300
      end
    end
  end

  Runner.register "update", UpdateCommand
end
