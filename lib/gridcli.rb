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
require 'gridcli/commands/befriend'
require 'gridcli/commands/friends'
require 'gridcli/commands/message'
require 'gridcli/commands/status'
require 'gridcli/commands/like'
require 'gridcli/commands/dislike'

require 'gridcli/resources/base'
require 'gridcli/resources/user'
require 'gridcli/resources/friendship'
require 'gridcli/resources/post'

