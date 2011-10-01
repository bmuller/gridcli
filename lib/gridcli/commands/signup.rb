module GridCLI
  class SignupCommand < BaseCommand
    def self.run(args)
      user = User.new(:username => 'bmuller')
      user.save
    end
  end
  
  Runner.register "signup", SignupCommand
end
