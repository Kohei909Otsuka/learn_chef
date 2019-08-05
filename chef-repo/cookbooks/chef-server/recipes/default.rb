#
# Cookbook Name:: chef-server
# Recipe:: default
#
# Copyright (c) 2019 The Authors, All Rights Reserved.

# chef server
server_pkg_url = node["oss-chef"]["url"]
server_pkg_name = ::File.basename(server_pkg_url)
server_pkg_local_path = "#{Chef::Config[:file_cache_path]}/#{server_pkg_name}"

remote_file server_pkg_local_path do
  source server_pkg_url
end

package server_pkg_name do
  source server_pkg_local_path
  provider Chef::Provider::Package::Rpm
  notifies :run, "execute[chef-server-ctl reconfigure]", :immediately
  notifies :run, "execute[chef-sever-ctl install chef-manage]", :immediately
  notifies :run, "execute[chef-manage-ctl reconfigure]", :immediately
end

execute "chef-server-ctl reconfigure" do
  command "sudo chef-server-ctl reconfigure"
  action :nothing
end

execute "chef-sever-ctl install chef-manage" do
  command "yes | sudo chef-server-ctl install chef-manage"
  action :nothing
end

execute "chef-manage-ctl reconfigure" do
  command "sudo chef-manage-ctl reconfigure --accept-license"
  action :nothing
end
