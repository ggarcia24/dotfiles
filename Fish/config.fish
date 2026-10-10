if status is-interactive
    # Commands to run in interactive sessions can go here
end

switch (uname)
    case Linux
        set -gx AWS_VAULT_BACKEND pass
        set -gx AWS_VAULT_PASS_PASSWORD_STORE_DIR ~/.password-store/aws-vault
    case Darwin
        set -gx AWS_VAULT_BACKEND keychain
end

