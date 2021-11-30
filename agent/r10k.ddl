metadata :name        => "r10k",
         :description => "An MCollective agent to run r10k to deploy puppet environments on puppetservers",
         :author      => "Ben Roberts <me@benroberts.net>",
         :license     => "Apache-2.0",
         :version     => "0.1.0",
         :url         => "https://github.com/optiz0r/r10k-agent",
         :provider    => "external",
         :timeout     => 60


action "deploy", :description => "Deploys puppet environments" do
  display :failed



  output :stderr,
         :description => "Stderr from r10k",
         :display_as  => "stderr"

  output :stdout,
         :description => "Stdout from r10k",
         :display_as  => "stdout"

end

