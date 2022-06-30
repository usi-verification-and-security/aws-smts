# /bin/sh

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <Account Number>";
    exit 1;
fi
a_num=$1

echo "Building csmtscq base docker image ..."
cd base
docker build -t csmtscq-base .

echo "Building and Tagging csmtscq-leader docker image ..."
cd ../leader
docker build -t csmtscq:leader .
docker tag csmtscq:leader ${a_num}.dkr.ecr.us-east-2.amazonaws.com/csmtscq-leader

echo "Building and Tagging csmtscq-worker docker image ..."
cd ../worker
docker build -t csmtscq:worker .
docker tag csmtscq:worker ${a_num}.dkr.ecr.us-east-2.amazonaws.com/csmtscq-worker

echo "List Of docker images:"
docker image ls

echo "Login attempt to aws ..."
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${a_num}.dkr.ecr.us-east-2.amazonaws.com

echo "Push docker images to ECR ..."
docker push ${a_num}.dkr.ecr.us-east-2.amazonaws.com/csmtscq-worker
docker push ${a_num}.dkr.ecr.us-east-2.amazonaws.com/csmtscq-leader
