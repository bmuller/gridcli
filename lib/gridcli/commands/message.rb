require 'active_support/core_ext'
require 'tempfile'

module GridCLI
  class MessageCommand < BaseCommand
    def initialize
      super "message", "Send a message to a friend or group of friends."
      add_option("-s subject", "--subject subject", "Subject for message") { |s| @opts[:subject] = s }
      add_option("-f file", "--file file", "File to use for message body") { |f| @opts[:file] = f }
      add_option("-b body", "--body body", "Message body. If -b/-f aren't used, $EDITOR will be opened.") { |b| @opts[:body] = b }
      add_format_option
    end

    def usage
      super "<username>[,<username>,...]"
    end

    def run(args)
      usage if args.length == 0
      recipients = args.shift
      parse_opts args

      body = nil
      if not @opts[:file].nil?
        error("File '#{@opts[:file]}' does not exist.") unless File.exists? @opts[:file]
        body = File.read(@opts[:file])
      elsif not @opts[:body].nil?
        body = @opts[:body]
      else
        editor = ENV['EDITOR'] || 'vi'
        tfile = Tempfile.new('gridmessage')
        tfile.close
        system("#{editor} #{tfile.path}")
        body = File.read(tfile.path)
        tfile.unlink
      end
      
      error("Body cannot be blank. Use one of -f or -b") if body.nil?
      subject = @opts[:subject].nil? ? body.truncate(30) : @opts[:subject]

      begin
        log "Trying to send a message '#{subject}' to '#{recipients}'"
        post = Post::Message.create :subject => subject, :body => body, :recipients => recipients, :posttype => 'message'
        puts "Message to #{recipients} send successfully."
      rescue ActiveResource::ClientError
        puts "There was an error sending your message.  Please make sure everyone in your recipient list is a friend, and the message body isn't empty."
        return
      end
  
    end
  end

  Runner.register "message", MessageCommand
end
