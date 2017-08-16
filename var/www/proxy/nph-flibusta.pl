#!/usr/bin/perl
use warnings;
use HTTP::Proxy;
use LWP::UserAgent;
use LWP::Protocol::socks;
use CGI qw(:standard -nph);

my $q = new CGI;
my $ua = LWP::UserAgent->new(max_redirect => 3, agent => $q->user_agent(),);
$ua->timeout(60);
$ua->proxy([qw/ http https /] => 'socks://127.0.0.1:9050'); # Tor proxy

my $refer = $q->referer();
$refer = "" unless defined($refer);
$refer =~ s/flibusta\.v-office\.kz/flibustahezeous3.onion/g;
my $rsp = $ua->get('http://flibustahezeous3.onion'.$q->param('url'), 'Referer'=>$refer, 'Accept'=>$q->http('Accept'),
          'Accept-Language'=>$q->http('Accept-Language'),
          'Accept-Encoding'=>'identity',
          'Cookie'=>$q->http('Cookie')
);
my $fstr = $rsp->as_string;
$fstr =~ s/flibustahezeous3\.onion/flibusta.v-office.kz/g;

#define templates
my $nbl = <<DATA1;
 <link href="/b/BOOOOOOOK/fb2" rel="http://opds-spec.org/acquisition/open-access" type="application/fb2+zip" />
 <link href="/b/BOOOOOOOK/html" rel="http://opds-spec.org/acquisition/open-access" type="application/html+zip" />
 <link href="/b/BOOOOOOOK/txt" rel="http://opds-spec.org/acquisition/open-access" type="application/txt+zip" />
 <link href="/b/BOOOOOOOK/rtf" rel="http://opds-spec.org/acquisition/open-access" type="application/rtf+zip" />
 <link href="/b/BOOOOOOOK/epub" rel="http://opds-spec.org/acquisition/open-access" type="application/epub+zip" />
 <link href="/b/BOOOOOOOK/mobi" rel="http://opds-spec.org/acquisition/open-access" type="application/x-mobipocket-ebook" />
DATA1
my $olb = quotemeta <<DATA2;
 <link href="/b/BOOOOOOOK/download" rel="http://opds-spec.org/acquisition/disabled" type="disabled/fb2+zip" />
DATA2
#get all book IDs
my @IDs = $fstr =~ /\/b\/(\d+)\/download/g;
foreach my $id (@IDs)
{
  # prepare search and replace strings
  my $ao = $olb;
  $ao =~ s/BOOOOOOOK/$id/g;
  my $an= $nbl;
  $an =~ s/BOOOOOOOK/$id/g;
   # do replace to fix format for cool reader
  $fstr =~ s/$ao/$an/g;
}

print $fstr;
