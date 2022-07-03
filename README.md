# SMTComp Parallel portfolio Solver

This repository contains two Dockerfiles that build the portfolio distributed solver using the SMT-Comp 2022 infrastructure.

Repository: [Link](https://github.com/usi-verification-and-security/SMTS/tree/portfolio)

Web Page: [Link](http://verify.inf.usi.ch/opensmt2)

## Prerequisites

Docker should be installed on the machine.

The portfolio docker images are built on top of the base containers smtcomp-base:leader and smtcomp-base:worker.

The process of building these base images (as well as many other aspects of building solvers for SAT-Comp) is described in the README.md file in the [https://github.com/aws-samples/aws-batch-comp-infrastructure-sample](https://github.com/aws-samples/aws-batch-comp-infrastructure-sample) repository.
Please follow the steps in this repository up to the point at which the base containers have been built.

## How to Build and Push The Images To ECR

To build the entire portfolio containers and push them to ecr:
(Dockers will be built with the PROJECT_NAME : psmtsp)
1. Run the `buildAndPush_docker_images.sh <Account Number> <Region>`.

