module GridCLI
  class SubGrids < YMLHash
    def initialize
      super "subgrids"
    end

    def get_group(group, stack=nil)
      stack ||= []
      if stack.include? group
        puts "Recursive subgrid definition detected."
        exit 1
      end
      stack << group

      fetch(group, "").split(" ").map { |user|
        user.start_with?('@') ? get_group(user, stack) : user
      }.flatten
    end

    def groups
      keys
    end

    def set_group(name, members)
      self[name] = members.join(" ")
      save
    end

    def resolve(userlist)
      userlist.map { |user|
        user.start_with?('@') ? get_group(user) : user
      }
    end
  end
end
