#!perl
use strict;
use Test::More (tests => 7);
BEGIN
{
    use_ok("Template::Plugin::DateTime");
}

use Template;

my $dt;
my $output;

my $tt = Template->new({ POST_CHOMP => 1 });
my $template = <<EOM;
[% USE date = DateTime(year => 2000, month => 1, day => 1 ) %]
[% date.datetime %]
EOM

$tt->process(\$template, undef, \$output);
$dt = DateTime->new(year => 2000, month => 1, day => 1);
is($output, $dt->datetime);

$output = '';
$template = <<EOM;
[% USE date = DateTime(now = 1) %]
[% date.datetime %]
EOM
$tt->process(\$template, undef, \$output);
$dt = DateTime->now(); # time will be different, but that's okay.
is($output, $dt->datetime);

$output = '';
$template = <<EOM;
[% USE date = DateTime(today = 1) %]
[% date.datetime %]
EOM
$tt->process(\$template, undef, \$output);
$dt = DateTime->today(); 
is($output, $dt->datetime);

$output = '';
$template = <<EOM;
[% USE date = DateTime(last_day_of_month = 1, year = 2004, month = 2) %]
[% date.datetime %]
EOM
$tt->process(\$template, undef, \$output);
$dt = DateTime->last_day_of_month(year => 2004, month => 2);
is($output, $dt->datetime);

$output = '';
$template = <<EOM;
[% USE date1 = DateTime(now = 1) %]
[% USE date2 = DateTime(from_object = date1) %]
[% IF date1 == date2 %]
ok
[% ELSE %]
nok
[% END %]
EOM
$tt->process(\$template, undef, \$output);
like($output, qr(^ok$));

$output = '';
$template = <<EOM;
[% USE date1 = DateTime(now = 1) %]
[% USE date2 = DateTime(from_epoch = date1.epoch) %]
[% IF date1 == date2 %]
ok
[% ELSE %]
nok
[% END %]
EOM
$tt->process(\$template, undef, \$output);
like($output, qr(^ok$));

