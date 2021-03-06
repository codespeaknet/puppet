# Rules added at the end of the iptables chains
#

class site_firewall::post {

  Firewallchain <| title == 'INPUT:filter:IPv6' |> {
    policy => 'drop',
    before => undef,
  }

  Firewallchain <| title == 'INPUT:filter:IPv4' |> {
    policy => 'drop',
    before => undef,
  }

  Firewallchain <| title == 'FORWARD:filter:IPv6' |> {
    policy => 'drop',
    before => undef,
  }

  Firewallchain <| title == 'FORWARD:filter:IPv4' |> {
    policy => 'drop',
    before => undef,
  }

  Firewallchain <| title == 'OUTPUT:filter:IPv6' |> {
    policy => 'accept',
    before => undef,
  }

  Firewallchain <| title == 'OUTPUT:filter:IPv4' |> {
    policy   => 'accept',
    before   => undef,
  }

}
