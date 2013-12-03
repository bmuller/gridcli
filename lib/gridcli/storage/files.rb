require 'fileutils'
require 'date'

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

    def years(type)
      Dir.glob(File.join(@basedir, type, '*')).map { |f| File.basename(f).to_i }
    end

    def months(type, year)
      Dir.glob(File.join(@basedir, type, year.to_s, '*')).map { |f| File.basename(f).to_i }
    end

    def dates(type, year, month)
      Dir.glob(File.join(@basedir, type, year.to_s, month.to_s, '*')).map { |f| 
        File.basename(f).split('.').first.to_i
      }
    end

    def min_date(type)
      year = years(type).sort.first
      month = months(type, year).sort.first
      date = dates(type, year, month).sort.first
      Date.new year, month, date
    end

    def max_date(type)
      year = years(type).sort.last
      month = months(type, year).sort.last
      date = dates(type, year, month).sort.last
      Date.new year, month, date
    end

    def has_type?(type)
      Dir.glob(File.join(@basedir, type, "*")).length > 0
    end

    def files(type, start_date, end_date)
      types = (type.strip == "all") ? @types : [type]
      types.each { |t|
        next unless has_type?(t)
        dates = [start_date || min_date(t), end_date || max_date(t)]
        dates.min.upto(dates.max) { |d|
          path = File.join(@basedir, t, d.year.to_s, d.month.to_s, d.day.to_s + ".json")
          yield path if File.exists? path
        }
      }
    end
    
    def run(pipes)
      system pipes.join(" | ")
    end

    def search(type, query, start_date, end_date, output_format, fromuser=nil)
      options = output_format.nil? ? "" : "-o #{output_format}"
      files(type, start_date, end_date) { |path|
        pipes = ["grep -Rhi \"#{query}\" #{path}"]
        pipes << "grep '\"from_username\":\"#{fromuser}\"'" unless fromuser.nil?
        pipes << "#{$0} pprint #{options}"
        run pipes
      }
    end

    def list(type, start_date, end_date, output_format)
      options = output_format.nil? ? "" : "-o #{output_format}"
      files(type, start_date, end_date) { |path|
        run ["cat #{path}", "#{$0} pprint #{options}"]
      }
    end

  end
end
