module GridCLI
  module Post

    class PostBase < BaseResource
      # before we create, resolve names from subgrid and call hooks
      def self.create(attributes)
        subgrids = SubGrids.new
        users = attributes[:recipients].split(",")
        attributes[:recipients] = subgrids.resolve(users).join(",")
        attributes = GridCLI.hooker.invoke :before_post_creation, attributes
        super attributes
      end

      # if we just call post.to_json, the root attribute will be "post"
      # for prettyprint, the root attribute needs to be one of: like,dislike,status,message
      def to_post_json
        type = self.class.name.split("::").last.downcase
        to_json(:root => type)
      end
    end

    class Message < PostBase
      self.element_name = "post"
    end

    class Like < PostBase
      self.element_name = "post"
    end

    class Dislike < PostBase
      self.element_name = "post"
    end

    class Status < PostBase
      self.element_name = "post"
    end
  end
end


