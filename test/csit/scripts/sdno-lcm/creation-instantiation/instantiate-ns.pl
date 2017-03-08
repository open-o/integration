#!/usr/bin/env perl
use Data::Dumper;
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

#MSB address, ID of the instance to be instantiated, the json file with request body.
$MSB_ADDR=$ARGV[0];
$INSTANCE_ID=$ARGV[1];
$BODY_FILE_NAME=$ARGV[2];

$INSTANCE_ID_PLACEHOLDER = "INSTANCE_ID_PLACEHOLDER";


#Read instantiation request from JSON file
my $body = readFile($BODY_FILE_NAME);

#replace instance id placeholder with real value
$body =~ s/$INSTANCE_ID_PLACEHOLDER/$INSTANCE_ID/;

#prepare curl command. quiet mode is used since we use stdout to return the job id.
my $body_in_curl = "'".$body."'";
my $instantiate_command = "curl -s -X POST -d ".$body_in_curl." -H 'Content-Type: application/json;charset=UTF-8' http://".$MSB_ADDR."/openoapi/sdnonslcm/v1/ns/$INSTANCE_ID/instantiate";

#execute and get response
my $response = `$instantiate_command`;
my $rsp_json = decode_json($response);
my $id = $rsp_json->{"jobId"};

#return job id (needed to query instantiation job status)
print $id;