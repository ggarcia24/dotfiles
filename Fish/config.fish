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

# set -g theme_display_git_default_branch yes
# set -g theme_use_abbreviated_branch_name yes
# set -g theme_display_vagrant yes
# set -g theme_display_rust yes
# set -g theme_display_docker_machine no
# set -g theme_display_k8s_context yes
# set -g theme_display_hg yes
# set -g theme_display_virtualenv yes
# set -g theme_display_aws_vault_profile yes
# set -g theme_display_nix no
# set -g theme_display_ruby no
# set -g theme_display_node always
# set -g theme_display_user ssh
# set -g theme_display_hostname ssh
# set -g theme_display_sudo_user yes
# set -g theme_display_date no
# set -g theme_display_cmd_duration no
# set -g theme_title_display_path no
# set -g theme_avoid_ambiguous_glyphs yes
# set -g theme_nerd_fonts yes
# set -g theme_show_exit_status yes
# set -g theme_display_jobs_verbose yes
# set -g default_user ggarcia
# set -g theme_color_scheme terminal2-dark-white
# set -g theme_newline_cursor yes
# set -g theme_newline_prompt '$ '
