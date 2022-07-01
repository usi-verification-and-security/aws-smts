# /bin/sh

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <Account Number> <Region>";
    exit 1;
fi
a_num=$1
region=$2

echo "Building csmtscq base docker image ..."
cd base
docker build -t csmtscq-base .

echo "Building and Tagging csmtscq-leader docker image ..."
cd ../leader
docker build -t csmtscq:leader .
docker tag csmtscq:leader ${a_num}.dkr.ecr.${region}.amazonaws.com/csmtscq-leader

echo "Building and Tagging csmtscq-worker docker image ..."
cd ../worker
docker build -t csmtscq:worker .
docker tag csmtscq:worker ${a_num}.dkr.ecr.${region}.amazonaws.com/csmtscq-worker

echo "List Of docker images:"
docker image ls

echo "Login attempt to aws ..."
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${a_num}.dkr.ecr.${region}.amazonaws.com

echo "Push docker images to ECR ..."
docker push ${a_num}.dkr.ecr.${region}.amazonaws.com/csmtscq-worker
docker push ${a_num}.dkr.ecr.${region}.amazonaws.com/csmtscq-leader
