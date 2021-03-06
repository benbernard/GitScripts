package Amling::Git::GBD::Action;

use strict;
use warnings;

use Amling::Git::GBD::Action::Bad;
use Amling::Git::GBD::Action::Checkout;
use Amling::Git::GBD::Action::Clear;
use Amling::Git::GBD::Action::ClearAll;
use Amling::Git::GBD::Action::ClearBad;
use Amling::Git::GBD::Action::ClearGood;
use Amling::Git::GBD::Action::Debug;
use Amling::Git::GBD::Action::DumpRange;
use Amling::Git::GBD::Action::Gitk;
use Amling::Git::GBD::Action::Good;
use Amling::Git::GBD::Action::Load;
use Amling::Git::GBD::Action::PrintCheckout;
use Amling::Git::GBD::Action::Save;
use Amling::Git::GBD::Action::Shell;
use Amling::Git::GBD::Action::Speculate;
use Amling::Git::GBD::Action::Status;
use Amling::Git::GBD::Action::XBad;
use Amling::Git::GBD::Action::XGood;

my @handlers =
(
    'Amling::Git::GBD::Action::Bad',
    'Amling::Git::GBD::Action::Checkout',
    'Amling::Git::GBD::Action::Clear',
    'Amling::Git::GBD::Action::ClearAll',
    'Amling::Git::GBD::Action::ClearBad',
    'Amling::Git::GBD::Action::ClearGood',
    'Amling::Git::GBD::Action::Debug',
    'Amling::Git::GBD::Action::DumpRange',
    'Amling::Git::GBD::Action::Gitk',
    'Amling::Git::GBD::Action::Good',
    'Amling::Git::GBD::Action::Load',
    'Amling::Git::GBD::Action::PrintCheckout',
    'Amling::Git::GBD::Action::Save',
    'Amling::Git::GBD::Action::Shell',
    'Amling::Git::GBD::Action::Speculate',
    'Amling::Git::GBD::Action::Status',
    'Amling::Git::GBD::Action::XBad',
    'Amling::Git::GBD::Action::XGood',
);

sub make_options
{
    my $ar = shift;

    my $cb = sub
    {
        my $action = shift;
        push @$ar, $action;
    };

    return map { $_->make_options($cb) } @handlers;
}

sub shell_action
{
    my $string = shift;

    for my $handler (@handlers)
    {
        my $action = $handler->shell_action($string);
        if(defined($action))
        {
            return $action;
        }
    }

    return undef;
}

1;
