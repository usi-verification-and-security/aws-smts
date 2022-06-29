# /bin/sh

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <Account Number>";
    exit 1;
fi
a_num=$1

echo "Building smtsp base docker image ..."
cd base
docker build -t smtsp-base .

echo "Building and Tagging smtsp-leader docker image ..."
cd ../leader
docker build -t smtsp:leader .
docker tag smtsp:leader ${a_num}.dkr.ecr.us-east-2.amazonaws.com/smtsp-leader

echo "Building and Tagging smtsp-worker docker image ..."
cd ../worker
docker build -t smtsp:worker .
docker tag smtsp:worker ${a_num}.dkr.ecr.us-east-2.amazonaws.com/smtsp-worker

echo "List Of docker images:"
docker image ls

echo "Login attempt to aws ..."
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${a_num}.dkr.ecr.us-east-2.amazonaws.com

echo "Push docker images to ECR ..."
docker push ${a_num}.dkr.ecr.us-east-2.amazonaws.com/smtsp-worker
docker push ${a_num}.dkr.ecr.us-east-2.amazonaws.com/smtsp-leader
