#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

FILE_LIST=`ls *_test`
FAILED_FILE_LIST=""

echo $FILE_LIST

SKIP_LIST="admin_services_end2end_test alts_concurrent_connectivity_test async_end2end_test backend_metrics_lb_policy_test bad_server_response_test bad_ssl_alpn_test bad_ssl_cert_test cancel_ares_query_test channelz_service_test channelz_v2_service_test chttp2_server_listener_test cli_call_test concurrent_connectivity_test connection_refused_test dualstack_socket_test client_callback_end2end_test client_interceptors_end2end_test client_lb_end2end_test context_allocator_end2end_test crl_provider_test" 


for file in $FILE_LIST
do
found=0
echo "${GREEN}*********Running $file ********${NC}"
	for file1 in $SKIP_LIST
	do
		if [[ $file == $file1 ]];then
			found=1
		fi
	done
	if [[ $found == 1 ]];then
		continue;
	fi
./$file
if [[ $?  != 0 ]]; then
    echo "${RED}********* ${file} execution failed******${NC}"
	FAILED_FILE_LIST="$FAILED_FILE_LIST $file "
else
echo "${GREEN}********* $file execution completed******${NC}"
fi
done

for file in $FAILED_FILE_LIST
do
echo "${RED} $file ${NC}"
done
