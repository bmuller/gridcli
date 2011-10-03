module GridCLI
  class ListCommand < BaseCommand
    def initialize
      super "list", "List posts of a particular kind or all posts"
    end

    def usage
      super "<like|dislike|message|status|all> [<since time>][ to <end time>]"
    end

    def run(args)
      usage if args.length == 0
      type = args.shift
      usage if not [ 'like', 'dislike', 'status', 'message', 'all' ].include? type
      period = (args.length > 0 and not args.first.start_with? '-') ? args.shift : nil
      dates = parse_dates period
      parse_opts args
      
      log "Showing #{type} posts in range #{dates.first || 'first'} - #{dates.last || 'last'}"
      GridCLI.storage.list(type, dates[0], dates[1])
    end
  end

  Runner.register "list", ListCommand
end
