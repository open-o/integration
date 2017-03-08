#!/usr/bin/env perl
use JSON qw( decode_json );

#read file
sub readFile {
    my ($filename) = @_;

    local $/=undef;
    open FILE, $filename or die "Couldn't open file $filename: $!";
    my $content = <FILE>;
    close FILE;

    return $content;
}

#MSB address and the json file with request body.
$MSB_ADDR=$ARGV[0];
$BODY_FILE_NAME=$ARGV[1];


#Read creation request from JSON file
my $body = readFile($BODY_FILE_NAME);

#prepare curl command. quiet mode is used since we use stdout to return the created service id.
my $body_in_curl = "'".$body."'";
my $creation_command = "curl -s -X POST -d ".$body_in_curl." -H 'Content-Type: application/json;charset=UTF-8' http://".$MSB_ADDR."/openoapi/sdnonslcm/v1/ns";

#execute and get response
my $response = `$creation_command`;
my $rsp_json = decode_json($response);
my $id = $rsp_json->{"nsInstanceId"};

#return service instance id (needed by instantiation request)
print $id;