require 'fileutils'

module GridCLI
  class FileStorage < StorageBase
    def initialize
      super
      @basedir = File.expand_path(File.join("~", ".grid"))
      @types = [ 'like', 'dislike', 'status', 'message' ]
      @types.each { |type|
        path = File.join(@basedir, type)
        Dir.mkdir(path) if not File.exists?(path)
      }
      @handles = {}
    end

    # return sha of last post
    def append(posts)
      obj = nil
      posts.each { |post|
        type = post.known_attributes.first
        obj = post.send(type)
        write_post obj, type
      }
      obj.sha
    end

    def write_post(post, type)
      created_at = Date.parse(post.created_at)
      json = post.to_json(:root => type) + "\n"
      open(type, created_at).write json
    end

    def open(type, date)
      dir = File.join(@basedir, type, date.year.to_s, date.month.to_s)
      path = File.join(dir, date.day.to_s + ".json")
      unless @handles.has_key? path
        FileUtils.mkdir_p dir
        @handles[path] = File.open(path, 'a')
      end
      @handles[path]
    end

    def search(type, query, dates)
      types = (type == "all") ? @types : [type]
      types.each { |t|
        path = File.join(@basedir, t)
        system "grep -R \"#{query}\" #{path}"
      }
    end

  end
end
