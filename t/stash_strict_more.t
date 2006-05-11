#============================================================= -*-perl-*-
#
# t/stash.t
#
# Template script testing (some elements of) the Strict version of
# Template::Stash
#
# Written by Andy Wardley <abw@kfs.org>
# Updated by Leon Brocard <acme@astray.com>
#
# Copyright (C) 1996-2000 Andy Wardley.  All Rights Reserved.
# Copyright (C) 1998-2000 Canon Research Centre Europe Ltd.
#
# This is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.
#
# $Id: stash-xs.t,v 2.5 2002/08/12 11:07:17 abw Exp $
#
#========================================================================

use strict;
use lib qw( ./lib ../lib ../blib/lib ../blib/arch );
use Template::Constants qw( :status );
use Template;
use Test::Exception;
use Test::More tests => 18;
$^W = 1;

eval {
    require Template::Stash::Strict;
};
if ($@) {
    warn $@;
    skip_all('cannot load Template::Stash::Strict');
}

my $count = 20;
my $data = {
    foo => 10,
    bar => {
	baz => 20,
    },
    baz => sub {
	return {
	    boz => ($count += 10),
	    biz => (shift || 'hello'),
	};
    },
    boo => [1,2,3],
    obj => bless {
	name => 'an object',
    }, 'AnObject',
};

my $stash = Template::Stash::Strict->new();
throws_ok { $stash->get('foo') } qr/Error fetching item: did not find key foo/;

$stash = Template::Stash::Strict->new($data);

lives_ok { $stash->get('foo') } 'lived';
throws_ok { $stash->get('foo2') } qr/Error fetching item: did not find key foo2/;
lives_ok { $stash->get('bar.baz') } 'lived';
throws_ok { $stash->get('bar.baz2') } qr/Error fetching item: did not find key baz2/;
throws_ok { $stash->get('bar2.baz') } qr/Error fetching item: did not find key bar2/;
lives_ok { $stash->get('baz.biz') } 'lived';
throws_ok { $stash->get('baz.biz2') } qr/Error fetching item: did not find key biz2/;
lives_ok { $stash->get('baz._biz') } 'lived';
lives_ok { $stash->get('boo.1') } 'lived';
throws_ok { $stash->get('boo2.1') } qr/Error fetching item: did not find key boo2/;
throws_ok { $stash->get('boo.4') } qr/Error fetching item: did not find key 4/;
throws_ok { $stash->get('boo2.last') } qr/Error fetching item: did not find key boo2/;
throws_ok { $stash->get('boo.1.foo') } qr/Error fetching item: did not find key foo/;
lives_ok { $stash->get('obj.name') } 'lived';
throws_ok { $stash->get('obj.name2') } qr/Error fetching item: did not find key name2/;
$stash->set( 'bar.baz2' => 100 );
lives_ok { $stash->get('bar.baz2') } 'lived';
$stash->set( 'bar2.baz2' => 100 );
lives_ok { $stash->get('bar2.baz2') } 'lived';

