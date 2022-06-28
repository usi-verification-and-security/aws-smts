# /bin/sh

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <Tools Name> <Account Number>";
    echo "Hint for cube-and-conquer:  $0 smtscq <Account Number>";
    echo "Hint for SMTS-portfolio:  $0 smtsp <Account Number>";
    exit 1;
fi

echo "Building $1 base docker image ..."
cd base
docker build -t $1-base .

echo "Building and Tagging $1-leader docker image ..."
cd ../leader
docker build -t $1:leader .
docker tag $1:leader $2.dkr.ecr.us-east-2.amazonaws.com/$1-leader

echo "Building and Tagging $1-worker docker image ..."
cd ../worker
docker build -t $1:worker .
docker tag $1:worker $2.dkr.ecr.us-east-2.amazonaws.com/$1-worker

echo "List Of docker images:"
docker image ls

echo "Login attempt to aws ..."
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin $2.dkr.ecr.us-east-2.amazonaws.com

echo "Push docker images to ECR ..."
docker push $1.dkr.ecr.us-east-2.amazonaws.com/$2-worker
docker push $1.dkr.ecr.us-east-2.amazonaws.com/$2-leader
