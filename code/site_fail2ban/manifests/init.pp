# this class configures fail2ban, the basis
#
# @param jails contains the jails to configure
# @param filters contains filters to define
#

class site_fail2ban (
  Array $jails,
  Hash $filters,
) {

  include 'fail2ban'

  $jails.each |Integer $index, String $name| {
    $jail_params = lookup("fail2ban::jail::${name}")
    fail2ban::jail { $name:
      filter => $name,
      *      => $jail_params,
    }
  }

  $filters.each |String $name, Array $regexes| {
    fail2ban::filter { $name:
      failregexes => $regexes,
    }
  }

}
