use strict;
use inc::Module::Install;

name('Template-Plugin-DateTime');
all_from('lib/Template/Plugin/DateTime.pm');
requires 'DateTime';
requires 'Template';

auto_install;
WriteAll;