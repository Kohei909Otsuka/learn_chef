# See https://docs.getchef.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "kohei"
client_key               "#{current_dir}/kohei.pem"
chef_server_url          "https://default-centos65/organizations/temona"
cookbook_path            ["#{current_dir}/../cookbooks"]
