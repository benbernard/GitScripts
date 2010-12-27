package Amling::GRD::Command::Merge;

use strict;
use warnings;

use Amling::GRD::Command;
use Amling::GRD::Command::Simple;
use Amling::GRD::Utils;

use base 'Amling::GRD::Command::Simple';

sub name
{
    return "merge";
}

sub min_args
{
    return 2;
}

sub max_args
{
    return undef;
}

sub execute_simple
{
    my $self = shift;
    my $ctx = shift;
    my $parent0 = convert($ctx, shift);
    my @parents1 = map { convert($ctx, $_) } @_;

    Amling::GRD::Utils::run("git", "checkout", $parent0) || die "Cannot checkout $parent0";
    if(!Amling::GRD::Utils::run("git", "merge", "--commit", "--no-ff", @parents1))
    {
        print "git merge of " . join(", ", @parents1) . " into $parent0 blew chunks, please clean it up (get correct version into index)...\n";
        Amling::GRD::Utils::run_shell(1, 1, 0);
        print "Continuing...\n";

        Amling::GRD::Utils::run("git", "commit") || die "Could not commit merge";
    }

    # TODO: amend merge? (would need original commit and I think the above is fairly prompty about merge commit message)
}

sub convert
{
    my $ctx = shift;
    my $tag = shift;

    my $commit = $ctx->get('tags', {})->{$tag};
    if(defined($commit))
    {
        return $commit;
    }

    # not a tag?  hopefully it's a commitlike
    return $tag;
}

Amling::GRD::Command::add_command(sub { return __PACKAGE__->handler(@_) });

1;
