module GridCLI
  class BaseResource < ActiveResource::Base
    self.format = :json
    self.site = GridCLI.config['site']
    self.user = GridCLI.config['username']
    self.password = GridCLI.config['token']
  end
end
