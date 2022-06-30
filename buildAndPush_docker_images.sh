# /bin/sh

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 <Account Number>";
    exit 1;
fi
a_num=$1

echo "Building psmtscq base docker image ..."
cd base
docker build -t psmtscq-base .

echo "Building and Tagging psmtscq-leader docker image ..."
cd ../leader
docker build -t psmtscq:leader .
docker tag psmtscq:leader ${a_num}.dkr.ecr.us-east-2.amazonaws.com/psmtscq-leader

echo "Building and Tagging psmtscq-worker docker image ..."
cd ../worker
docker build -t psmtscq:worker .
docker tag psmtscq:worker ${a_num}.dkr.ecr.us-east-2.amazonaws.com/psmtscq-worker

echo "List Of docker images:"
docker image ls

echo "Login attempt to aws ..."
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${a_num}.dkr.ecr.us-east-2.amazonaws.com

echo "Push docker images to ECR ..."
docker push ${a_num}.dkr.ecr.us-east-2.amazonaws.com/psmtscq-worker
docker push ${a_num}.dkr.ecr.us-east-2.amazonaws.com/psmtscq-leader
