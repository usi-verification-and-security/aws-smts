# SMTComp Parallel cube-and-conquer Solver

##Setup
To set up the account resources for parallel track, run the create-solver-infrastructure script:

```text
./create-solver-infrastructure --profile usiverify --project smtscq --instance m6i.16xlarge --memory 253000 --ami ami-014ddabf5947b9cbe --update True
```

## Build and Push The Images To ECR

To build the entire cube-and-conquer containers and push them to ecr:
(Dockers will be built with the PROJECT_NAME : psmtscq)
1. Run the `buildAndPush_docker_images.sh <Account Number> <Region>`.

