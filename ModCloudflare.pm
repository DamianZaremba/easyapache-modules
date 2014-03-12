# Custom EasyApache module providing mod_cloudflare support
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
# mkdir mod_cloudflare-1.0.3
# wget -O mod_cloudflare-1.0.3/mod_cloudflare.c \
#     https://raw.github.com/cloudflare/mod_cloudflare/master/mod_cloudflare.c
# tar -cvzf mod_cloudflare.pm.tar.gz mod_cloudflare-1.0.3
# rm -rf mod_cloudflare-1.0.3

# We deal in packages
package Cpanel::Easy::ModCloudflare;

# Let's be strict about proceedings
use strict;

# Shared hash for cPanel to understand
our $easyconfig = {
    name => 'Mod Cloudflare',
    note => 'mod_cloudflare support for Apache 2.x',
    hastargz => 1,
    src_cd2 => 'mod_cloudflare-1.0.3',
    modself => sub {
        my($easy, $self_hr, $profile_hr) = @_;
        if($profile_hr->{'Apache'}{'version'} eq '2')
        {
            $self_hr->{'skip'} = 1;
            return(0, q{Mod Cloudflare requires Apache 2.x});
        }
    },
    step => {
        # Run apxs
        0 => {
            name => 'Compiling mod_cloudflare',
            command => sub {
                my($self) = @_;

                return $self->run_system_cmd_returnable([
                                                $self->_get_main_apxs_bin(),
                                                '-a', '-i', '-c',
                                                'mod_cloudflare.c']);
            },
        },
    },
};

1;
