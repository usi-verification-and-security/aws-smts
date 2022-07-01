# /bin/sh

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <Account Number> <Region>";
    exit 1;
fi
a_num=$1
region=$2

echo "Building psmtsp base docker image ..."
cd base
docker build -t psmtsp-base .

echo "Building and Tagging psmtsp-leader docker image ..."
cd ../leader
docker build -t psmtsp:leader .
docker tag psmtsp:leader ${a_num}.dkr.ecr.${region}.amazonaws.com/psmtsp-leader

echo "Building and Tagging psmtsp-worker docker image ..."
cd ../worker
docker build -t psmtsp:worker .
docker tag psmtsp:worker ${a_num}.dkr.ecr.${region}.amazonaws.com/psmtsp-worker

echo "List Of docker images:"
docker image ls

echo "Login attempt to aws ..."
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${a_num}.dkr.ecr.${region}.amazonaws.com

echo "Push docker images to ECR ..."
docker push ${a_num}.dkr.ecr.${region}.amazonaws.com/psmtsp-worker
docker push ${a_num}.dkr.ecr.${region}.amazonaws.com/psmtsp-leader