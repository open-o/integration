#!/usr/bin/env perl
use JSON qw( encode_json decode_json );

#read file
sub readFile {
    my ($filename) = @_;

    local $/=undef;
    open FILE, $filename or die "Couldn't open file $filename: $!";
    my $content = <FILE>;
    close FILE;

    return $content;
}

####MSB address and the json file with request body.
$MSB_ADDR=$ARGV[0];
$BODY_FILE_NAME=$ARGV[1];


##############################Get All Templates from Catalog ################
my $extract_command = "curl -s http://".$MSB_ADDR."/openoapi/catalog/v1/servicetemplates";
my $templates_response = `$extract_command`;
my $all_templates = decode_json($templates_response);


##############################Prepare Creation Request&Command #############
#Read creation request from JSON file
my $body = decode_json(readFile($BODY_FILE_NAME));
my $template_name = $body->{"nsdId"};

for my $template (@$all_templates) {
    my $name = $template->{"id"};
    if($name eq $template_name) {
        $body->{"nsdId"} = $template->{"serviceTemplateId"};
        last;
    }
}

####prepare curl command. quiet mode is used since we use stdout to return the created service id.
my $body_in_curl = "'".encode_json($body)."'";
my $creation_command = "curl -s -X POST -d ".$body_in_curl." -H 'Content-Type: application/json;charset=UTF-8' http://".$MSB_ADDR."/openoapi/sdnonslcm/v1/ns";



#######################################Execute and Get Response###########
my $response = `$creation_command`;
my $rsp_json = decode_json($response);
my $id = $rsp_json->{"nsInstanceId"};

####return service instance id (needed by instantiation request)
print $id;