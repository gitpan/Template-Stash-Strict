#!/usr/bin/perl
use strict;
use warnings;
use lib qw( ../lib ./lib );
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'      => 'Template::Stash::Strict',
    'C'         => [qw( Strict.c )],
    'XS'        => { 'Strict.xs' => 'Strict' },
    'OBJECT'    => 'Strict.o',
    'VERSION'   => '2.15',
    'NORECURS'  => 1,
    'PREREQ_PM' => { 'Template' => '2.14', 'Test::Exception' => '0', },
);
