# This class manages ipsets
# i'd love to use any of the 3 puppet modules that manage ipsets
# but they don't support Debian, neither iptables-persistent :(
#
# @param ipsets contains a hash with ipsets and their parameters
#

class site_firewall::ipsets (
  Hash $ipsets,
) {

  file { '/etc/iptables/ipsets':
    ensure  => present,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('site_firewall/ipsets.erb'),
    notify  => Service['netfilter-persistent'],
  }

}
