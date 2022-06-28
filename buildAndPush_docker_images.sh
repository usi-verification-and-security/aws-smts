# /bin/sh

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <Tools Name> <Account Number>";
    echo "Hint for cube-and-conquer:  $0 smtscq <Account Number>";
    echo "Hint for SMTS-portfolio:  $0 smtsp <Account Number>";
    exit 1;
fi
t_name=$1
a_num=$2

echo "Building ${t_name} base docker image ..."
cd base
docker build -t ${t_name}-base .

echo "Building and Tagging ${t_name}-leader docker image ..."
cd ../leader
docker build -t ${t_name}:leader .
docker tag ${t_name}:leader ${a_num}.dkr.ecr.us-east-2.amazonaws.com/${t_name}-leader

echo "Building and Tagging ${t_name}-worker docker image ..."
cd ../worker
docker build -t ${t_name}:worker .
docker tag ${t_name}:worker ${a_num}.dkr.ecr.us-east-2.amazonaws.com/${t_name}-worker

echo "List Of docker images:"
docker image ls

#echo "Login attempt to aws ..."
#aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin ${a_num}.dkr.ecr.us-east-2.amazonaws.com

echo "Push docker images to ECR ..."
docker push ${a_num}.dkr.ecr.us-east-2.amazonaws.com/${t_name}-worker
docker push ${a_num}.dkr.ecr.us-east-2.amazonaws.com/${t_name}-leader
