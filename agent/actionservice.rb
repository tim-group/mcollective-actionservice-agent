require 'puppet'
require 'yaml'

module MCollective
  module Agent
    # An agent that receives an action and service.
    # Allows acl's to be explicitly set per action/service.
    # mco rpc actionservice status-elasticsearch-default
    class Actionservice<RPC::Agent
      config_file = '/etc/action_services.yaml'
      services = []
      if File.exist?(config_file)
        config = YAML.load_file('/etc/action_services.yaml')
        services = config['services']
      end

      services.each do |service|
        ['start','stop','status','restart'].each do |action|
          action "#{action}-#{service}" do
            result =  Service.do_service_action(action, service)
            if ['start','stop'].include? action 
              if result[:msg]
                reply[:status] = result[:status]
                reply.fail! result[:msg]
              else
                reply[:status] = result[:status]
              end
            else
              reply[:status] = result
            end
          end
        end
      end
    end
  end
end


# vi:tabstop=2:expandtab:ai:filetype=ruby
