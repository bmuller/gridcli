module GridCLI
  class BaseResource < ActiveResource::Base
    self.format = :json
    self.site = GridCLI.config['site']
    self.user = GridCLI.config['username']
    self.password = GridCLI.config['token']

    def to_s
      known_attributes.map { |k| "#{k}:\t#{send(k)}" }.join("\n")
    end
  end
end
