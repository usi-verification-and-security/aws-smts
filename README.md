# SMTComp Cloud cube-and-conquer Solver 

This project provides scripts to build AWS resources including the Elastic Compute Cloud (EC2) service, the Elastic Container Registry (ECR) service, the Elastic Container Service (ECS) service, the Simple Storage Service, the Elastic File System (EFS) service, and  Simple Queue Service by which we will be building and running our solvers.


To simplify the solver construction process, two base Docker images are provided that manage most of the infrastructure necessary for solvers and interface to AWS resources which are described in the README.md file in the [https://github.com/aws-samples/aws-batch-comp-infrastructure-sample](https://github.com/aws-samples/aws-batch-comp-infrastructure-sample) repository.

Repository: [Link](https://github.com/usi-verification-and-security/SMTS/tree/cube-and-conquer)

Web Page: [Link](http://verify.inf.usi.ch/opensmt2)

## Prerequisites
- [Docker should be installed on the machine](https://docs.docker.com/desktop/install/mac-install/)
  The cube-and-conquer docker images are built on top of the base containers smtcomp-base:leader and smtcomp-base:worker.
- [python3](https://www.python.org/)
- [awscli](https://aws.amazon.com/cli/)
- [boto3](https://aws.amazon.com/sdk-for-python/)
- [docker](https://www.docker.com/)

## How to Build
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

To set up the account resources and scripts for building and running SMTS on the parallel track we have provided a different branch as follows:

Parallel [Link](https://github.com/usi-verification-and-security/aws-smts/tree/parallel-cube-and-conquer)

To create the base docker Leader and Worker images for solvers run the following command:
`cd aws-batch-comp-infrastructure-sample/src` && `build_docker_images.sh`

To build the entire cube-and-conquer containers and push them to ecr:

(Dockers will be built with the PROJECT_NAME : smtscq)


Run the `buildAndPush_docker_images.sh <Account Number> <Region>`.

## How to Run
First make sure you have instance at your s3 bucket by:
```text
aws --profile [usiverify] s3 ls s3://<Aws-AccountNumber>-<Region>-satcompbucket
```
You can upload instance into s3 bucket by:
```text
aws --profile [usiverify] s3 cp test.smt2.bz2 s3://<Aws-AccountNumber>-<Region>-satcompbucket
```
To start the cluster run:
```text
./update_instances --profile [usiverify] --option setup --workers [n]
```

To turn off the cluster run:
```text
./update_instances --profile [usiverify] --option shutdown
```

To submit a job and execute the tool run:
```text
./send_message --profile [usiverify] --location s3://<Aws-AccountNumber>-<Region>-satcompbucket/test.smt2.bz2 --workers [n]
```




