module GridCLI
  class UpdateCommand < BaseCommand
    def initialize
      super "update", "Download all messages"
      add_format_option
    end

    def run(args)
      parse_opts args

      posts = run_since_sha(@stats['last_sha'])
      total_posts = posts.length
      @stats['last_sha'] = save(posts) if posts.length > 0

      # If we're doing this in chunks, get more
      while posts.length == 300
        posts = run_since_sha(@stats['last_sha'])
        total_posts += posts.length
        @stats['last_sha'] = save(posts) if posts.length > 0
      end

      @stats.save
      puts "Saved #{total_posts} posts.  Now up to date."
    end
    

    def run_since_sha(last_sha)
      GridCLI.hooker.invoke :before_update

      posts = []
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
      end

      GridCLI.hooker.invoke :after_update, posts
    end

    def save(posts)
      posts.each { |p| 
        type = p.known_attributes.first
        json = p.send(type).to_json(:root => type)
        pprint json
      }
      (posts.length > 0) ? GridCLI.storage.append(posts) : nil
    end
  end

  Runner.register "update", UpdateCommand
end
