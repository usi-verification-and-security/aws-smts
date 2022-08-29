# SMTComp Cloud cube-and-conquer Solver 

First start by downloading aws-backend infrastructure:
`./download_aws_infrastructure.sh`

Run the following command to get ami:
```text
aws --profile usiverify  ssm get-parameters --names /aws/service/ecs/optimized-ami/amazon-linux-2/recommended
```

To set up the account resources for cloud track, run the create-solver-infrastructure script:
```text 
./create-solver-infrastructure --profile [usiverify] --project [smtscq] --instance m6i.4xlarge --memory 61000 --ami [ami-014ddabf5947b9cbe]
```

To set up the account resources for cloud track, run the create-solver-infrastructure script:
```text
./create-solver-infrastructure --profile usiverify --project smtscq --instance m6i.16xlarge --memory 253000 --ami ami-014ddabf5947b9cbe --update True
```

Creating the base docker Leader and Worker images for solvers:
Then `cd aws-batch-comp-infrastructure-sample/src` and run the `build_docker_images.sh`

This repository contains two Dockerfiles that build the cube-and-conquer distributed solver using the SMT-Comp 2022 infrastructure.

Repository: [Link](https://github.com/usi-verification-and-security/SMTS/tree/cube-and-conquer)

Web Page: [Link](http://verify.inf.usi.ch/opensmt2)

## Prerequisites

Docker should be installed on the machine.  

The cube-and-conquer docker images are built on top of the base containers smtcomp-base:leader and smtcomp-base:worker.

The process of building these base images (as well as many other aspects of building solvers for SAT-Comp) is described in the README.md file in the [https://github.com/aws-samples/aws-batch-comp-infrastructure-sample](https://github.com/aws-samples/aws-batch-comp-infrastructure-sample) repository.
Please follow the steps in this repository up to the point at which the base containers have been built.

## How to Build

To build the entire cube-and-conquer containers and push them to ecr:

(Dockers will be built with the PROJECT_NAME : csmtscq)
1. Run the `buildAndPush_docker_images.sh <Account Number> <Region>`.

