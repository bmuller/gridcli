module GridCLI
  class SubgridCommand < BaseCommand
    def initialize
      super "subgrid", "Create / read / update subgrids (groups)"
    end

    def usage
      super "[<groupname> [<comma separated list of users>]]"
    end

    def run(args)
      subgrids = SubGrids.new

      groups = (args.length == 0) ? subgrids.groups : [args.shift]

      # if setting users...
      if args.length > 0
        subgrids.set_group(groups.first, args.first.split(","))
      end

      groups.each { |gname|
        error("Group not found: #{gname}") unless subgrids.groups.include? gname
        puts "#{gname} has users: #{subgrids.get_group(gname).join(', ')}"
      }

    end
  end

  Runner.register "subgrid", SubgridCommand
end
