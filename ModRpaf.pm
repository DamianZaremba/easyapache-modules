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
# wget https://github.com/gnif/mod_rpaf/archive/v0.8.2.zip
# unzip v0.8.2.zip 
# tar -cvzf ModRpaf.pm.tar.gz mod_rpaf-0.8.2

# We deal in packages
package Cpanel::Easy::ModRpaf;

# Let's be strict about proceedings
use strict;

# Shared hash for cPanel to understand
our $easyconfig = {
    name => 'Mod Rpaf',
    note => 'mod_rpaf support for Apache 2.x',
    hastargz => 1,
    src_cd2 => 'mod_rpaf-0.8.2',
    modself => sub {
        my($easy, $self_hr, $profile_hr) = @_;
        if($profile_hr->{'Apache'}{'version'} eq '2')
        {
            $self_hr->{'skip'} = 1;
            return(0, q{Mod Rpaf requires Apache 2.x});
        }
    },
    step => {
        # Run apxs
        0 => {
            name => 'Compiling mod_rpaf',
            command => sub {
                my($self) = @_;

                return $self->run_system_cmd_returnable([
                                                $self->_get_main_apxs_bin(),
                                                '-a', '-i', '-c',
                                                'mod_rpaf.c']);
            },
        },
    },
};

1;
