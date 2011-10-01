require 'active_resource'

module GridCLI
  autoload :Config, 'gridcli/config'

  def self.config
    @config ||= Config.new
  end
end

require 'gridcli/version'
require 'gridcli/runner'

require 'gridcli/commands/base'
require 'gridcli/commands/signup'
require 'gridcli/commands/help'
require 'gridcli/commands/profile'

require 'gridcli/resources/base'
require 'gridcli/resources/user'

