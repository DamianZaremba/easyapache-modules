# Custom EasyApache module providing mod_rpaf support
#
# Copyright 2012 Damian Zaremba <damian@damianzaremba.co.uk>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# To build the tar.gz do something like the following....
# mkdir temp
# cd temp
# wget -N http://stderr.net/apache/rpaf/download/mod_rpaf-0.6.tar.gz
# tar -xvf mod_rpaf-0.6.tar.gz
# rm -f mod_rpaf-0.6.tar.gz
# mv mod_rpaf-0.6 src
# mkdir mod_rpaf-0.6
# cp src/mod_rpaf-2.0.c mod_rpaf-0.6
# tar -cvzf mod_rpaf.pm.tar.gz mod_rpaf-0.6
# rm -rf mod_rpaf-0.6 src

# We deal in packages
package Cpanel::Easy::ModRpaf;

# Let's be strict about proceedings
use strict;

# Shared hash for cPanel to understand
our $easyconfig = {
    name => 'Mod Rpaf',
    note => 'mod_rpaf support for Apache 2.x',
    hastargz => 1,
    src_cd2 => 'mod_rpaf-0.6',
    step => {},
};

# Run apxs
$easyconfig->{step}->{0} = {
    name => 'Compiling mod_rpaf',
    command => sub {
        my $self = @_;

        return $self->run_system_cmd_returnable([$self->_get_main_apxs_bin(),
                                                '-a', '-i', '-c',
                                                'mod_rpaf-2.0.c']);
    };
};

# Load the module into Apache
$easyconfig->{step}->{1} = {
    name => 'Loading mod_rpaf into Apache',
    command => sub {
        my $self = @_;

        return $self->ensure_loadmodule_in_httpdconf('rpaf_module',
                                                    'mod_rpaf-2.0.so');
    };
};

1;