# $Id$
#
# Daisuke Maki <dmaki@cpan.org>
# All rights reserved.

use strict;
use Module::Build;

my $class = Module::Build->subclass(code => q|
    sub ACTION_manifest
    {
        my $self = shift;
        $self->SUPER::ACTION_manifest();
        if ($self->create_makefile_pl) {
            $self->_add_to_manifest('MANIFEST', 'Makefile.PL        Added here by Build.PL');
        }
    }
|);

my $build = $class->new(
    module_name => 'Template::Plugin::DateTime',
    license => 'perl',
    requires => {
        'DateTime'   => 0,
        'Template'   => 0,
    },
    build_requires => {
        'Test::More' => 0
    },
    recommends => {
        'perl' => '5.6.1',
    },
    sign => 1,
    create_makefile_pl => 'traditional'
);
$build->create_build_script;
