metadata    :name        => "actionservice",
            :description => "Start and stop system services",
            :author      => "Richard Pearce (heavily borrowed from service.rb by R.I.Pienaar)",
            :license     => "ASL2",
            :version     => "1",
            :url         => "https://github.com/youdevise/mcollective-actionservice-agent",
            :timeout     => 60

config = YAML.load_file('/etc/mcollective/action_services.yaml')
config['services'].each do |service|
  ['start','stop','restart','status'].each do |action|
    action "#{action}-#{service}", :description => "#{action} #{service}" do
      display :always

      output :status,
            :description => "The status of the service",
            :display_as  => "Service Status",
            :default     => "unknown"

      summarize do
            aggregate summary(:status)
      end

    end
  end
end

