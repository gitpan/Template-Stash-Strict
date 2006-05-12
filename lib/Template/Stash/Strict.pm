#============================================================= -*-Perl-*-
# 
# Template::Stash::Strict
# 
# DESCRIPTION
#
#   Perl bootstrap for Strict module. Inherits methods from 
#   Template::Stash when not implemented in the Strict module.
#
#========================================================================

package Template::Stash::Strict;
use strict;
use warnings;
use vars qw($AUTOLOAD $VERSION);

use Template;
use Template::Stash;

BEGIN {
  $VERSION = '2.15';
  require DynaLoader;
  @Template::Stash::Strict::ISA = qw( DynaLoader Template::Stash );

  eval {
    bootstrap Template::Stash::Strict $VERSION;
  };
  if ($@) {
    die "Couldn't load Template::Stash::Strict $VERSION:\n\n$@\n";
  }
}


sub DESTROY {
  # no op
  1;
}


# catch missing method calls here so perl doesn't barf 
# trying to load *.al files 
sub AUTOLOAD {
  my ($self, @args) = @_;
  my @c             = caller(0);
  my $auto	    = $AUTOLOAD;

  $auto =~ s/.*:://;
  $self =~ s/=.*//;

  die "Can't locate object method \"$auto\"" .
      " via package \"$self\" at $c[1] line $c[2]\n";
}

1;

__END__


#------------------------------------------------------------------------
# IMPORTANT NOTE
#   This documentation is generated automatically from source
#   templates.  Any changes you make here may be lost.
# 
#   The 'docsrc' documentation source bundle is available for download
#   from http://www.template-toolkit.org/docs.html and contains all
#   the source templates, XML files, scripts, etc., from which the
#   documentation for the Template Toolkit is built.
#------------------------------------------------------------------------

=head1 NAME

Template::Stash::Strict - Experimental strict high-speed stash written in XS

=head1 SYNOPSIS

    use Template;
    use Template::Stash::Strict;

    my $stash = Template::Stash::Strict->new(\%vars);
    my $tt2   = Template->new({ STASH => $stash });

=head1 DESCRIPTION

This module loads the Strict XS version of Template::Stash::Strict. It
should behave very much like the XS one, but throw an exception when
attempting to return something which is undef. See the synopsis above
for usage information.

This behaves somewhat like Perl's "use strict" method.

Only a few methods (such as get and set) have been implemented in XS. 
The others are inherited from Template::Stash.

=head1 NOTE

To always use the Strict version of Stash, modify the Template/Config.pm 
module near line 45:

 $STASH    = 'Template::Stash::Strict';

If you make this change, then there is no need to explicitly create 
an instance of Template::Stash::Strict as seen in the SYNOPSIS above. Just
use Template as normal.

Alternatively, in your code add this line before creating a Template
object:

 $Template::Config::STASH = 'Template::Stash::Strict';

To use the original, pure-perl version restore this line in 
Template/Config.pm:

 $STASH    = 'Template::Stash';

Or in your code:

 $Template::Config::STASH = 'Template::Stash';

=head1 AUTHORS

Andy Wardley   <abw@kfs.org>,
Doug Steinwand <dsteinwand@citysearch.com>,
Leon Brocard   <acme@astray.com>

Many thanks to Foxtons Ltd.

=head1 COPYRIGHT

  Parts Copyright (C) 2006 Leon Brocard.  All Rights Reserved.
  Copyright (C) 1996-2004 Andy Wardley.  All Rights Reserved.
  Copyright (C) 1998-2002 Canon Research Centre Europe Ltd.
    
This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<Template::Stash|Template::Stash>,
L<Template::Stash::XS|Template::Stash::XS>

