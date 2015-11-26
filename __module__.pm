package Rex::Apt::Mirror; 
use Rex -base;
use Rex::Ext::ParamLookup;

# Usage: rex setup --mirror=mirror.mydomain.com

task 'setup', sub {

	unless ( is_installed("apt") ) {
    		Rex::Logger::info "pkg apt not detected on this node. Aborting", 'error';
		return;
   	}

	my $mirror = param_lookup "mirror", "mirrors.melbourne.co.uk";

	file "/etc/apt/sources.list",
		content => template("files/etc/apt/sources.tmpl", { mirror => "$mirror" }),
		on_change => sub { 
			say "config updated. updating package list.";
			update_package_db;
			}
};

1;
