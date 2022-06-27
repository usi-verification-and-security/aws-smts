# SMTComp Cloud cube-and-conquer Solver 

This repository contains two Dockerfiles that build the cube-and-conquer distributed solver using the SMT-Comp 2022 infrastructure.  It is intended to be used for teams to understand how to build solvers for SMT-Comp.

Repository: [Link](https://github.com/usi-verification-and-security/SMTS/tree/cube-and-conquer)

Web Page: [Link](http://verify.inf.usi.ch/opensmt2)

## Prerequisites

Docker should be installed on the machine.  

The cube-and-conquer docker images are built on top of the base containers smtcomp-base:leader and smtcomp-base:worker.

The process of building these base images (as well as many other aspects of building solvers for SAT-Comp) is described in the README.md file in the [https://github.com/aws-samples/aws-batch-comp-infrastructure-sample](https://github.com/aws-samples/aws-batch-comp-infrastructure-sample) repository.
Please follow the steps in this repository up to the point at which the base containers have been built.

## How to Build

To build the cube-and-conquer base container:

1. Navigate to the `base` subdirectory.
2. Run `docker build -t smtscq-base .`

To build the cube-and-conquer leader container:

1. Navigate to the `leader` subdirectory.
2. Run `docker build -t smtscq:leader .`

To build the cube-and-conquer worker container:

1. Navigate to the `worker` subdirectory.
2. Run `docker build -t smtscq:worker .`

After building both images, run `docker image ls` and make sure you see both `smts:leader` and `smts:worker` in the list of images.
