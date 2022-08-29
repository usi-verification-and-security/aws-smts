# /bin/sh

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <Account Number> <Region>";
    exit 1;
fi
a_num=$1
region=$2

echo "Building smtscq base docker image ..."
cd base
docker build -t smtscq-base .

echo "Building and Tagging smtscq-leader docker image ..."
cd ../leader
docker build -t smtscq:leader .
docker tag smtscq:leader ${a_num}.dkr.ecr.${region}.amazonaws.com/smtscq-leader

echo "Building and Tagging smtscq-worker docker image ..."
cd ../worker
docker build -t smtscq:worker .
docker tag smtscq:worker ${a_num}.dkr.ecr.${region}.amazonaws.com/smtscq-worker

echo "List Of docker images:"
docker image ls

echo "Login attempt to aws ..."
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${a_num}.dkr.ecr.${region}.amazonaws.com

echo "Push docker images to ECR ..."
docker push ${a_num}.dkr.ecr.${region}.amazonaws.com/smtscq-worker
docker push ${a_num}.dkr.ecr.${region}.amazonaws.com/smtscq-leader
