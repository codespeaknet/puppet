# entry point for puppet
#

node default {
  include apt
  include site_unattended_upgrades
}
