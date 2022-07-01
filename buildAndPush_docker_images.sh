# /bin/sh

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <Account Number> <Region>";
    exit 1;
fi
a_num=$1
region=$2

echo "Building csmtsp base docker image ..."
cd base
docker build -t csmtsp-base .

echo "Building and Tagging csmtsp-leader docker image ..."
cd ../leader
docker build -t csmtsp:leader .
docker tag csmtsp:leader ${a_num}.dkr.ecr.${region}.amazonaws.com/csmtsp-leader

echo "Building and Tagging csmtsp-worker docker image ..."
cd ../worker
docker build -t csmtsp:worker .
docker tag csmtsp:worker ${a_num}.dkr.ecr.${region}.amazonaws.com/csmtsp-worker

echo "List Of docker images:"
docker image ls

echo "Login attempt to aws ..."
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${a_num}.dkr.ecr.${region}.amazonaws.com

echo "Push docker images to ECR ..."
docker push ${a_num}.dkr.ecr.${region}.amazonaws.com/csmtsp-worker
docker push ${a_num}.dkr.ecr.${region}.amazonaws.com/csmtsp-leader
