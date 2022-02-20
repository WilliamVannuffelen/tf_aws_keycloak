#!/usr/bin/env bash
# requires jq

# unset env vars first; otherwise get-session-token call fails due to AWS idiosyncracy
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

# vars
# static var as I don't want to be queried for it every time
MFAARN='arn:aws:iam::850901712561:mfa/wvannuffelen'

read -p 'MFA Code: ' MFACODE

# get and set secrets to shell session env vars
res=$(aws sts get-session-token --serial-number $MFAARN --token-code $MFACODE --duration-seconds 7200)

export AWS_ACCESS_KEY_ID=$(echo $res | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $res | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $res | jq -r '.Credentials.SessionToken')
