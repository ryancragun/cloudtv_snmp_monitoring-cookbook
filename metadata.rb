name             'cloudtv_snmp_monitoring'
maintainer       'Ryan Cragun'
maintainer_email 'ryan@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures cloudtv_snmp_monitoring-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports "ubuntu"
supports "centos"

depends "rightscale"

recipe "cloudtv_snmp_monitoring::default", "default recipe"
recipe "cloudtv_snmp_monitoring::install_cloudtv_plugin", "Installs SNMP monitoring for CloudTV"
recipe "cloudtv_snmp_monitoring::install_transcoder_plugin", "Installs SNMP monitoring for CloudTV Transcoder"
