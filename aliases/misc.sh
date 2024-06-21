#!/usr/bin/env zsh
alias gimme-aws-creds-docker="docker run -it --rm \
  -v ~/.aws/credentials:/root/.aws/credentials \
  -v ~/.okta_aws_login_config:/root/.okta_aws_login_config \
  gimme-aws-creds"

gac () {
  declare -a args
  if [ -z "$1" ]
  then
    args+=(--profile "$GIMME_AWS_CREDS_DEFAULT_AWS_PROFILE")
  elif [ "$1" = '-p' ] || [ "$1" = '--profile' ]
  then
    args+=(--profile "$2")
  else
    args+=(--profile "$1")
  fi
  args+=(
      --roles "/$GIMME_AWS_CREDS_DEFAULT_ROLE/"
      --mfa-code "$(pass otp "$GIMME_AWS_CREDS_PASS_MFA")"
  )
  gimme-aws-creds "${args[@]}"
}
alias otp='pass otp "$OKTA_PASS_OTP_NAME" -c'
alias opa='pass "$OKTA_PASS_NAME" -c'
