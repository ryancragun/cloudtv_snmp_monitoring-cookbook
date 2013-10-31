#
# Cookbook Name:: cloudtv_snmp_monitoring
# Recipe:: install_cloudtv_plugin
#
# Copyright (C) 2013 Ryan Cragun
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

rightscale_marker

require 'fileutils'

log "   Installing cloudtv_snmp_monitoring.."

case node[:platform]
when 'centos'
  packages = %w(collectd collectd-snmp)
when 'ubuntu'
  packages = %w(collectd collect-core libsnmp15)
end

packages.each { |pkg| package pkg }

service "collectd"

file(::File.join(node[:rightscale][:collectd_plugin_dir], "snmp.conf")) do
  only_if { ::File.exists?(::File.join(node[:rightscale][:collectd_plugin_dir], "snmp.conf")) }
  action :delete
  backup false
end

template(::File.join(node[:rightscale][:collectd_plugin_dir], "cloudtv_snmp.conf")) do
  backup false
  source "cloudtv_snmp.conf.erb"
  notifies :restart, resources(:service => "collectd")
  variables(
    :instance_uuid => node[:rightscale][:instance_uuid],
    :local_ip => node[:ipaddress]
  )
end

directory node[:rightscale][:collectd_lib] do
  action :create
  recursive true
end

log "   Installed collectd cloudtv_snmtp_monitoring."
