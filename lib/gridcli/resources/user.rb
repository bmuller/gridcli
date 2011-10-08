module GridCLI
  class User < BaseResource
    def to_json(args=nil)
      args ||= {}
      super({ :except => ['id'] }.merge(args))
    end
  end
end
