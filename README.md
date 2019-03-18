Puppet for lists.codespeak.net
==============================

This repo contains the puppet code that drives the configuration
of lists.codespeak.net.

Every 30 minutes, puppet will checkout the code from GitHub and apply it.

To test a change before applying it, edit the code in */srv/git/puppet* and run


```shell
sudo puppet apply --noop --verbose --show_diff --hiera_config /srv/git/puppet/hiera.yaml --modulepath=/srv/git/puppet/modules:/srv/git/puppet/code /srv/git/puppet/code/site.pp
```


**Be aware that the cronjob will overwrite any change and/or commit in the repository!**

To run puppet for real

```shell
sudo puppet apply --verbose --show_diff --hiera_config /srv/git/puppet/hiera.yaml --modulepath=/srv/git/puppet/modules:/srv/git/puppet/code /srv/git/puppet/code/site.pp
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

Clone the repository from GitHub

```
git clone git@github.com:codespeaknet/puppet.git
```

*Optional:* Using RVM, rbenv, or simply setting $GEM_HOME and $GEM_PATH setup a dedicated gem store.
Then install bundler using the *Gemfile* present

```shell
gem install bundler
bundler install
```

If you wanna test your changes before committing them

```shell
rsync --delete --exclude=.gem  -rv . lists.codespeak.net:/srv/git/puppet/
```

```shell
ssh lists.codespeak.net "sudo puppet apply --noop --verbose --show_diff  --hiera_config /srv/git/puppet/hiera.yaml --modulepath=/srv/git/puppet/modules:/srv/git/puppet/code /srv/git/puppet/code/site.pp"
```

Install modules on your development environment

```shell
r10k -c r10k.yaml puppetfile install
```


etckeeper integration
---------------------

As documented in */usr/share/doc/puppet/examples/etckeeper-integration* etckeeper should run
before and after puppet runs.
A copy of the scripts lives in */usr/local/sbin*

*Scripts will run even if puppet runs in dry-run mode*
