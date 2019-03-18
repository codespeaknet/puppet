Puppet for lists.codespeak.net
==============================

This repo contains the puppet code that drives the configuration
of lists.codespeak.net.

Every 30 minutes, puppet will checkout the code from GitHub and apply it.

To test a change before applying it, edit the code in */srv/git/puppet* and run


```shell
sudo puppet apply --noop --verbose --show_diff --hiera_config /srv/git/puppet/hiera.yaml --modulepath=/srv/git/puppet/modules:/srv/git/puppet/site /srv/git/puppet/site/site.pp
```


**Be aware that the cronjob will overwrite any change and/or commit!**

To run puppet for real

```shell
sudo puppet apply --verbose --show_diff --hiera_config /srv/git/puppet/hiera.yaml --modulepath=/srv/git/puppet/modules:/srv/git/puppet/site /srv/git/puppet/site/site.pp
```


Modules
-------

modules are managed by r10k, to add a new module just add it to the Puppetfile and run r10k


```shell
r10k -c r10k.yaml puppetfile install
```

The cronjob runs r10k before running puppet.

Hiera
-----

hiera data lives in */srv/git/puppet/hieradata*, hiera configuration file is
*/srv/git/puppet/hiera.yaml*

Currently hiera 3 is in use.

Development
-----------

There is a *Gemfile* which installs puppet, hiera, and puppet-lint.


```
gem install bundler
bundler install
```

Setting GEM_HOME and GEM_PATH to *.gem* in the project directory keeps the development environment
clean against other gems.
Alternatively RVM or rbenv can be used.

etckeeper integration
---------------------

As documented in */usr/share/doc/puppet/examples/etckeeper-integration* etckeeper should run
before and after puppet runs.
A copy of the scripts lives in */usr/local/sbin*

*Scripts will run even if puppet runs in dry-run mode*
