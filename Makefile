.PHONY: install
install:
	mkdir -p /var/cpanel/easy/apache/custom_opt_mods/Cpanel/Easy/
	cp -f *.pm /var/cpanel/easy/apache/custom_opt_mods/Cpanel/Easy/
	cp -f *.tar.gz /var/cpanel/easy/apache/custom_opt_mods/Cpanel/Easy/
