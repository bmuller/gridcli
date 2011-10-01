module GridCLI
  class BaseResource < ActiveResource::Base
    self.format = :json
    self.site = GridCLI.config['site']
  end
end
