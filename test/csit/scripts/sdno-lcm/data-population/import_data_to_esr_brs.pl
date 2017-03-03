#!/usr/bin/env perl
use Data::Dumper;
use JSON qw( decode_json encode_json);

#read file
sub readFile {
    my ($filename) = @_;

    local $/=undef;
    open FILE, $filename or die "Couldn't open file $filename: $!";
    my $content = <FILE>;
    close FILE;

    return $content;
}



#MSB address, the IP address on which these controllers will be simulated, controllers meta-data file, and managed elements meta-data file.
$MSB_ADDR=$ARGV[0];
$CONTROLLERS_SIMULATOR_IP=$ARGV[1];
$CONTROLLERS_FILE_NAME=$ARGV[2];
$MES_FILE_NAME=$ARGV[3];

#place holder of controller address in the json files with controller information.
$CONTROLLER_ADDRESS_PLACE_HOLDER = "CONTROLLER_IPPORT";

#ME registration body prefix in JSON
$ME_JSON_PREFIX="managedElement";
$ME_REG_API_URL="/openoapi/sdnobrs/v1/managed-elements";




#used to hold the controller ids returned from ESR
%controller_ids;

#Read controllers meta data
$all_controllers = decode_json(readFile($CONTROLLERS_FILE_NAME));

#register controllers one by one
for my $controller (@$all_controllers) {
    my $port = $controller->{"port"};
    my $api_url = $controller->{"api_url"};
    my $rsp_id_keyname = $controller->{"rsp_id_keyname"};
    my $id_placeholder = $controller->{"id_placeholder"};
    my $reg_data = $controller->{"reg_data"};
    my $reg_str = encode_json($reg_data);

    ##############register controller to ESR.
    my $real_address = $CONTROLLERS_SIMULATOR_IP.":".$port;
    $reg_str =~ s/$CONTROLLER_ADDRESS_PLACE_HOLDER/$real_address/;
    my $reg_str_in_curl = "'".$reg_str."'";

    my $reg_command = "curl -X POST -d ".$reg_str_in_curl." -H 'Content-Type: application/json;charset=UTF-8' http://".$MSB_ADDR.$api_url;
    print $reg_command."\n";

    my $reg_response = `$reg_command`;

    #############extract and save the controller id
    my $rsp_json = decode_json($reg_response);
    my $controller_id = $rsp_json->{$rsp_id_keyname};
    $controller_ids{$id_placeholder} = $controller_id;
}
print "ID of the controllers registered to ESR: \n";
print Dumper(\%controller_ids);




#used to hold the me ids returned from BRS
%me_ids;

#read all MEs
$all_elements = decode_json(readFile($MES_FILE_NAME));
for my $me (@$all_elements) {
    my $reg_str = encode_json($me);

    ###########################replace with real controller_id
    for my $placeholder (@{$me->{"controllerID"}}) {
        my $real_id = $controller_ids{$placeholder};
        $reg_str =~ s/$placeholder/$real_id/;
    }

    ##########################insert to BRS
    my $reg_str_in_command = "'{\"$ME_JSON_PREFIX\":".$reg_str."}'";
    $reg_str_in_command =~ tr{\n}{ };

    my $url = "http://$MSB_ADDR$ME_REG_API_URL";

    my $insert_command = "curl -X POST -d $reg_str_in_command -H 'Content-Type: application/json;charset=UTF-8' $url";
    print $insert_command."\n";
    my $response = `$insert_command`;
    print $response."\n";

    ########################get id returned by BRS
    my $rsp_obj = decode_json($response);
    my $me_id = $rsp_obj->{$ME_JSON_PREFIX}->{"id"};
    $me_ids{$me->{"name"}} = $me_id;
}
print "ID of the MEs registered to BRS: \n";
print Dumper(\%me_ids);