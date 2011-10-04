require 'json'
require 'colorize'

module GridCLI
  class PrettyPrinter
    def initialize(string)
      begin
        j = JSON.parse(string)
        type = j.keys.first
        @contents = j[type]    
        @created_at = Time.parse(@contents['created_at']).localtime.to_s
        @pretty = case type
                  when "message" then pprint_message
                  when "like" then pprint_like
                  when "dislike" then pprint_dislike
                  when "status" then pprint_status
                  else string 
                  end
      rescue JSON::ParserError
        @pretty = string
      end
    end

    def pprint_like
      "on #{@created_at} #{@contents['from_username']} liked #{@contents['body']}".green
    end

    def pprint_dislike
      "on #{@created_at} #{@contents['from_username']} disliked #{@contents['body']}".red
    end

    def pprint_status
      "on #{@created_at} #{@contents['from_username']} was #{@contents['body']}".cyan
    end

    def pprint_message
      s = "Message from: ".cyan + @contents['from_username'] + "\n"
      s+= "Subject: ".cyan + @contents['subject'] + "\n"
      s+= "Date: ".cyan + @created_at + "\n"
      s+= "To: ".cyan + @contents['recipients'] + "\n"
      s+= @contents['body']
    end

    def to_s
      @pretty
    end
  end
end
