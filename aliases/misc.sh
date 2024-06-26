#!/usr/bin/env zsh
alias gimme-aws-creds-docker="docker run -it --rm \
  -v ~/.aws/credentials:/root/.aws/credentials \
  -v ~/.okta_aws_login_config:/root/.okta_aws_login_config \
  gimme-aws-creds"

gac () {
  declare -a args
  if [ -z "$1" ]
  then
    if [ -n "$GIMME_AWS_CREDS_DEFAULT_AWS_PROFILE" ]
    then args+=(--profile "$GIMME_AWS_CREDS_DEFAULT_AWS_PROFILE")
    else echo 'GIMME_AWS_CREDS_DEFAULT_AWS_PROFILE is unset and no profile specified, using default profile.' >&2
    fi
  elif [ "$1" = '-p' ] || [ "$1" = '--profile' ]
  then
    args+=(--profile "$2")
  else
    args+=(--profile "$1")
  fi

  if [ -n "$GIMME_AWS_CREDS_DEFAULT_ROLE" ]
  then args+=(--roles "/$GIMME_AWS_CREDS_DEFAULT_ROLE/")
  else echo 'GIMME_AWS_CREDS_DEFAULT_ROLE is unset, using default role' >&2
  fi

  if [ -n "$GIMME_AWS_CREDS_PASS_MFA" ]
  then args+=(--mfa-code "$(pass otp "$GIMME_AWS_CREDS_PASS_MFA")")
  else echo 'GIMME_AWS_CREDS_PASS_MFA is unset' >&2
  fi
  gimme-aws-creds "${args[@]}"
}

otp () {
  if [ -n "$OKTA_PASS_OTP_NAME" ]
  then pass otp "$OKTA_PASS_OTP_NAME" -c
  else echo 'OKTA_PASS_OTP_NAME is unset' >&2
  fi
}

opa () {
  if [ -n "$OKTA_PASS_NAME" ]
  then pass "$OKTA_PASS_NAME" -c
  else echo 'OKTA_PASS_NAME is unset' >&2
  fi
}

alias reload-gpg-agent='gpg-connect-agent reloadagent /bye'
