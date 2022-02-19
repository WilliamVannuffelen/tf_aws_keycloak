# prereq: request certificate; for PoC I used LetsEncrypt with DNS validation
# build customised image with TLS certs baked in
docker build -t wvdt_keycloak_tls ./build/

# auth to CLI in general
source ../scripts/awscli_mfa_auth.sh

# get docker auth
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 850901712561.dkr.ecr.eu-west-1.amazonaws.com

# tag and push custom image to ECR
docker tag wvdt_keycloak_tls:latest 850901712561.dkr.ecr.eu-west-1.amazonaws.com/wvdt_temp:latest
docker push 850901712561.dkr.ecr.eu-west-1.amazonaws.com/wvdt_temp:latest