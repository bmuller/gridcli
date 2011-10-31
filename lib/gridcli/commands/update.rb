module GridCLI
  class UpdateCommand < BaseCommand
    def initialize
      super "update", "Download all messages"
      add_format_option
    end

    def run(args)
      parse_opts args
      last_sha = @stats['last_sha']

      GridCLI.hooker.invoke :before_update

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

      posts = GridCLI.hooker.invoke :after_update, posts

      log "Saving #{posts ? posts.length : 0} posts."
      save posts
    end

    def save(posts)
      if posts.blank?
        puts "Up to date."
      else
        posts.each { |p| 
          type = p.known_attributes.first
          json = p.send(type).to_json(:root => type)
          pprint json
        }
        @stats['last_sha'] = GridCLI.storage.append(posts)
        @stats.save
      
        # run again if we got back 300 posts
        run(args) if posts.length == 300
      end
    end
  end

  Runner.register "update", UpdateCommand
end
