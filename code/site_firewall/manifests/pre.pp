# This firewall rules are added before any user-defined rule
#

class site_firewall::pre {

  Firewall { require => undef, }

  # INPUT
  firewall_multi { '001 allow input related and established':
    chain    => 'INPUT',
    state    => ['RELATED', 'ESTABLISHED'],
    proto    => 'all',
    action   => 'accept',
    provider => ['iptables', 'ip6tables'],
  }

  firewall_multi { '002 allow input lo':
    chain    => 'INPUT',
    proto    => 'all',
    action   => 'accept',
    iniface  => 'lo',
    provider => ['iptables', 'ip6tables'],
  }

  firewallchain { 'FILTERS:filter:IPv4':
    ensure  => present,
  }

  firewallchain { 'FILTERS:filter:IPv6':
    ensure  => present,
  }

  firewall_multi { '099 fail2ban':
    chain    => 'INPUT',
    proto    => 'all',
    jump     => 'FILTERS',
    provider => ['iptables', 'ip6tables'],
  }

  firewall_multi { '100 allow input ssh':
    chain    => 'INPUT',
    proto    => 'tcp',
    dport    => '22',
    state    => 'NEW',
    action   => 'accept',
    provider => ['iptables', 'ip6tables'],
  }

  firewall_multi { '101 allow input icmp':
    chain    => 'INPUT',
    state    => 'NEW',
    proto    => 'icmp',
    icmp     => [0, 3, 11],
    action   => 'accept',
    provider => ['iptables'],
  }

  firewall_multi { '101 allow input icmp echo from subnet':
    chain    => 'INPUT',
    proto    => 'ipv6-icmp',
    icmp     => [130, 131, 132, 143, 151, 152, 153],
    source   => 'fe80::/10',
    action   => 'accept',
    provider => ['ip6tables'],
  }

  firewall_multi { '102 allow input icmp':
    chain    => 'INPUT',
    proto    => 'ipv6-icmp',
    icmp     => [1, 2, 3, 4, 128, 133, 134, 135, 136, 137, 141, 142, 148, 149],
    action   => 'accept',
    provider => ['ip6tables'],
  }

  firewall_multi { '002 allow output lo':
    chain    => 'OUTPUT',
    proto    => 'all',
    action   => 'accept',
    outiface => 'lo',
    provider => ['iptables', 'ip6tables'],
  }

  firewall_multi { '003 allow output for root':
    chain    => 'OUTPUT',
    proto    => 'all',
    uid      => 'root',
    action   => 'accept',
    provider => ['iptables', 'ip6tables'],
  }

  firewall { '004 allow output icmp echo':
    chain  => 'OUTPUT',
    state  => 'NEW',
    proto  => 'icmp',
    icmp   => 'echo-request',
    action => 'accept',
  }

}
