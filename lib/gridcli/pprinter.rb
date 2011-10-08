require 'json'
require 'colorize'

module GridCLI
  class PPTextLineFormat
    def self.all(parsed)
      parsed.map { |k,v| "#{k}: #{v}" }.join("; ")
    end
    
    def self.like(original, parsed)
      self.all(parsed)
    end

    def self.dislike(original, parsed)
      self.all(parsed)
    end

    def self.status(original, parsed)
      self.all(parsed)
    end

    def self.message(original, parsed)
      self.all(parsed)
    end

    def self.user(original, parsed)
      self.all(parsed)
    end
  end

  class PPCmdFormat
    def self.like(original, parsed)
      "on #{@created_at} #{@contents['from_username']} liked #{@contents['body']}\n\n"
    end

    def self.dislike(original, parsed)
      "on #{@created_at} #{@contents['from_username']} disliked #{@contents['body']}\n\n"
    end

    def self.status(original, parsed)
      "on #{@created_at} #{@contents['from_username']} was #{@contents['body']}\n\n"
    end

    def self.message(original, parsed)
      s = "Message from: #{parsed['from_username']}\n"
      s+= "Subject: #{parsed['subject']}\n"
      s+= "Date: #{parsed['created_at']}\n"
      s+= "To: #{parsed['recipients']}\n"
      s+= "#{parsed['body']}\n\n"
    end

    def self.user(original, parsed)
      s = "#{parsed['username']}\n" 
      s+= "created: #{parsed['created_at']}\n"
      (parsed.keys - ['created_at', 'username']).each { |key|
        next if parsed[key].nil?
        s += "#{key}: #{parsed[key]}\n"
      }
      s += "\n"
    end
  end

  class PPCmdColorFormat < PPCmdFormat
    def self.like(original, parsed)
      super(original, parsed).green
    end

    def self.dislike(original, parsed)
      super(original, parsed).red
    end

    def self.status(original, parsed)
      super(original, parsed).cyan
    end

    def self.message(original, parsed)
      s = "Message from: ".cyan + parsed['from_username'] + "\n"
      s+= "Subject: ".cyan + parsed['subject'] + "\n"
      s+= "Date: ".cyan + parsed['created_at'] + "\n"
      s+= "To: ".cyan + parsed['recipients'] + "\n"
      s+= "#{parsed['body']}\n\n"
    end

    def self.user(original, parsed)
      s = "username: ".magenta + "#{parsed['username']}\n".yellow
      s+= "created: ".magenta + "#{parsed['created_at']}\n"
      (parsed.keys - ['created_at', 'username']).each { |key|
        next if parsed[key].nil?
        s += "#{key}: ".magenta + "#{parsed[key]}\n"
      }
      s += "\n"
    end
  end


  class PrettyPrinter
    # format can be one of :cmdcolor, :cmd, :textline, :json
    def initialize(string, format=nil)
      @format = format.nil? ? :cmdcolor : format.intern
      @original = string
      begin
        j = JSON.parse(string)
        @type = j.keys.first
        @contents = j[@type]
        @contents['created_at'] = Time.parse(@contents['created_at']).localtime.to_s
      rescue JSON::ParserError
        @type = nil
        @format = nil
        @contents = {}
      end
    end

    def formatters
      { :cmdcolor => PPCmdColorFormat, :cmd => PPCmdFormat, :textline => PPTextLineFormat }
    end

    def to_s
      formatter = formatters.fetch(@format, nil)
      # if the format is unknown or :json return original
      return @original if formatter.nil?
      
      case @type
      when "message" then formatter.message(@original, @contents)
      when "like" then formatter.like(@original, @contents)
      when "dislike" then formatter.dislike(@original, @contents)
      when "status" then formatter.status(@original, @contents)
      when "friend_request" then formatter.message(@original, @contents)
      when "user" then formatter.user(@original, @contents)
      else @original #unknown type
      end
    end
  end
end
