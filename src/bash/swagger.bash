#!/bin/bash
#
# Usage:
#    ./swagger.bash generate -i mineblimp-0.1.0.yaml -l swagger
# 
java -jar ~/.m2/repository/io/swagger/swagger-codegen-cli/2.2.1/swagger-codegen-cli-2.2.1.jar $*
