module GridCLI
  module Post
    class Message < BaseResource
      self.element_name = "post"
    end
    class Like < BaseResource
      self.element_name = "post"
    end
    class Dislike < BaseResource
      self.element_name = "post"
    end
    class Status < BaseResource
      self.element_name = "post"
    end
  end
end


