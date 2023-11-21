gac () {
  declare -a args
  if [ -z "$1" ]
  then
    args+=(--profile "$DEFAULT_AWS_PROFILE")
  else
    args+=(--profile "$1")
  fi
  args+=(
      --roles /$GAC_ROLE/
      --mfa-code "$(pass otp "$GAC_PASS_MFA")"
  )
  gimme-aws-creds "${args[@]}"
}
alias otp='pass otp "$OTP_PASS_OTP" -c'
alias opa='pass "$OPA_PASS" -c'
