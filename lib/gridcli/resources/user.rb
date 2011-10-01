module GridCLI
  class User < BaseResource
    def to_s
      known_attributes.map { |k| "#{k}:\t#{send(k)}" }.join("\n")
    end
  end
end
