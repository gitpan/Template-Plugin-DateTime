use strict;
use Module::Build;

my $build = Module::Build->new(
    module_name => 'Template::Plugin::DateTime',
    dist_name => 'Template-Plugin-DateTime',
    license => 'perl',
    requires => {
        'DateTime'   => 0,
    },
    build_requires => {
        'Test::More' => 0
    },
    recommends => {
        'perl' => '5.6.1',
    },
    sign => 1,
    create_makefile_pl => 'passthrough'
);
$build->create_build_script;
