# Custom EasyApache module providing mod_wsgi support
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
# We deal in packages
#
# To build the tar.gz do something like the following....
# mkdir temp
# cd temp
# wget -N http://modwsgi.googlecode.com/files/mod_wsgi-3.3.tar.gz
# mv mod_wsgi-3.3.tar.gz mod_wsgi.pm.tar.gz

package Cpanel::Easy::ModWsgi;

# Let's be strict about proceedings
use strict;

# Shared hash for cPanel to understand
our $easyconfig = {
    name => 'Mod Wsgi',
    note => 'mod_wsgi support for Apache 2.x/Python 2.7',
    hastargz => 1,
    ensurepkg => ['python27-devel'],
    src_cd2 => 'mod_wsgi-3.3',
    step => {
        # Run configure
        0 => {
            name => 'Running configure on mod_wsgi',
            command => sub {
                my $self = @_;

                return $self->run_system_cmd_returnable(['./configure',
                                                        '--with-apxs=' .
                                                '/usr/local/apache/bin/apxs']);
            },
        },

        # Run make
        1 => {
            name => 'Running make on mod_wsgi',
            command => sub {
                my $self = @_;

                return $self->run_system_cmd_returnable(['make']);
            },
        },

        # Run make install
        2 => {
            name => 'Running make install on mod_wsgi',
            command => sub {
                my $self = @_;

                return $self->run_system_cmd_returnable(['make', 'install']);
            },
        },

        # Load the module into Apache
        3 => {
            name => 'Loading mod_wsgi into Apache',
            command => sub {
                my $self = @_;

                return $self->ensure_loadmodule_in_httpdconf('wsgi',
                                                            'mod_wsgi.so');
            },
        },
    },
};

1;