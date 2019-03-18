# entry point for puppet
#

node default {
  include apt
  include site_unattended_upgrades
  include needrestart
  include site_firewall
  include site_firewall::ipsets
}
