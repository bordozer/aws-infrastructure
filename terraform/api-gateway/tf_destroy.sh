#!/usr/bin/env bash

YELLOW='\e[93m'
RED='\e[31m'
DEFAULT='\e[39m'

SERVICE_NAME="api-gateway"
# env: `test` or `prod`
ENV=$1
FORCE=$2
if [ -z "$ENV" ]
then
      echo "ENV is empty. Provide 'test' or 'prod'"
      exit 1;
fi

echo -e "=================================================="
echo -e "Environment '${YELLOW}${ENV}${DEFAULT}' is going to be ${RED}destroyed ${FORCE}${DEFAULT}"
echo -e "=================================================="

if [ "force" = "${FORCE}" ]; then

   terraform destroy "-var-file=env/${ENV}.tfvars" -auto-approve  \
      -var="service_name=${SERVICE_NAME}" \
      -var="environment_name=${ENV}"

   echo "Environment '${ENV}' has been destroyed. R.I.P."
   exit 0
fi

CONFIRM_STR="Destroy ${SERVICE_NAME}-${ENV}"
read -r -p "Type '${CONFIRM_STR}' to proceed: " confirm
if [ "${confirm}" = "${CONFIRM_STR}" ]; then

   terraform destroy "-var-file=env/${ENV}.tfvars" -auto-approve \
      -var="service_name=${SERVICE_NAME}" \
      -var="environment_name=${ENV}"

   echo "Environment '${YELLOW}${ENV}${DEFAULT}' has been destroyed. R.I.P."
   exit 0
fi

echo ""
echo "Wrong confirmation"
echo ""
