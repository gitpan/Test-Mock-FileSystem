use strict;
use warnings;
use Test::More tests => 1;
use Test::Mock::FileSystem 'MyPackage';

my $file = ( $^O eq 'Win32' ) ? 'C:\temp\myfile' : '/tmp/myfile';
my $content = 'The quick brown fox jumped over the lazy dog';

mock_file $file => ( content => $content );

is( MyPackage->load_resource, $content, 'File content' );

INIT {

    package MyPackage;

    use strict;
    use warnings;

    sub load_resource {
        open( my $fh, '<', $file );
        my $content = <$fh>;
        close($fh);
        return $content;
    }

}
