set fish_greeting # Disable greeting

function _tide_item_nix_env
    test -n "$ANY_NIX_SHELL_PKGS" && _tide_print_item nix_env $tide_nix_env_icon' ' $ANY_NIX_SHELL_PKGS
end

set -g tide_nix_env_bg_color 7EBAE4
set -g tide_nix_env_color 000000
set -g tide_nix_env_icon \uf313

set -g fish_color_autosuggestion 555 brblack
set -g fish_color_cancel -r
set -g fish_color_command blue
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end green
set -g fish_color_error brred
set -g fish_color_escape brcyan
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_host_remote yellow
set -g fish_color_normal normal
set -g fish_color_operator brcyan
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection cyan --bold
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline
set -g fish_key_bindings fish_default_key_bindings
set -g fish_pager_color_completion normal
set -g fish_pager_color_description B3A06D yellow -i
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r
set -g tide_aws_bg_color FF9900
set -g tide_aws_color 232F3E
set -g tide_aws_icon \uf270
set -g tide_character_color 5FD700
set -g tide_character_color_failure FF0000
set -g tide_character_icon \u276f
set -g tide_character_vi_icon_default \u276e
set -g tide_character_vi_icon_replace \u25b6
set -g tide_character_vi_icon_visual V
set -g tide_cmd_duration_bg_color C4A000
set -g tide_cmd_duration_color 000000
set -g tide_cmd_duration_decimals 0
set -g tide_cmd_duration_icon \uf252
set -g tide_cmd_duration_threshold 3000
set -g tide_context_always_display false
set -g tide_context_bg_color 444444
set -g tide_context_color_default D7AF87
set -g tide_context_color_root D7AF00
set -g tide_context_color_ssh D7AF87
set -g tide_context_hostname_parts 1
set -g tide_crystal_bg_color FFFFFF
set -g tide_crystal_color 000000
set -g tide_crystal_icon \ue62f
set -g tide_direnv_bg_color D7AF00
set -g tide_direnv_bg_color_denied FF0000
set -g tide_direnv_color 000000
set -g tide_direnv_color_denied 000000
set -g tide_direnv_icon \u25bc
set -g tide_distrobox_bg_color FF00FF
set -g tide_distrobox_color 000000
set -g tide_distrobox_icon \U000f01a7
set -g tide_docker_bg_color 2496ED
set -g tide_docker_color 000000
set -g tide_docker_default_contexts default colima
set -g tide_docker_icon \uf308
set -g tide_elixir_bg_color 4E2A8E
set -g tide_elixir_color 000000
set -g tide_elixir_icon \ue62d
set -g tide_gcloud_bg_color 4285F4
set -g tide_gcloud_color 000000
set -g tide_gcloud_icon \U000f02ad
set -g tide_git_bg_color 4E9A06
set -g tide_git_bg_color_unstable C4A000
set -g tide_git_bg_color_urgent CC0000
set -g tide_git_color_branch 000000
set -g tide_git_color_conflicted 000000
set -g tide_git_color_dirty 000000
set -g tide_git_color_operation 000000
set -g tide_git_color_staged 000000
set -g tide_git_color_stash 000000
set -g tide_git_color_untracked 000000
set -g tide_git_color_upstream 000000
set -g tide_git_icon \uf1d3
set -g tide_git_truncation_length 24
set -g tide_git_truncation_strategy
set -g tide_go_bg_color 00ACD7
set -g tide_go_color 000000
set -g tide_go_icon \ue627
set -g tide_java_bg_color ED8B00
set -g tide_java_color 000000
set -g tide_java_icon \ue256
set -g tide_jobs_bg_color 444444
set -g tide_jobs_color 4E9A06
set -g tide_jobs_icon \uf013
set -g tide_kubectl_bg_color 326CE5
set -g tide_kubectl_color 000000
set -g tide_kubectl_icon \U000f10fe
set -g tide_left_prompt_frame_enabled true
set -g tide_left_prompt_items vi_mode os pwd git newline
set -g tide_left_prompt_prefix
set -g tide_left_prompt_separator_diff_color \ue0bc
set -g tide_left_prompt_separator_same_color \ue0b1
set -g tide_left_prompt_suffix \ue0b0
set -g tide_nix_shell_bg_color 7EBAE4
set -g tide_nix_shell_color 000000
set -g tide_nix_shell_icon \uf313
set -g tide_node_bg_color 44883E
set -g tide_node_color 000000
set -g tide_node_icon \ue24f
set -g tide_os_bg_color 5277C3
set -g tide_os_color FFFFFF
set -g tide_os_icon \uf313
set -g tide_php_bg_color 617CBE
set -g tide_php_color 000000
set -g tide_php_icon \ue608
set -g tide_private_mode_bg_color F1F3F4
set -g tide_private_mode_color 000000
set -g tide_private_mode_icon \U000f05f9
set -g tide_prompt_add_newline_before true
set -g tide_prompt_color_frame_and_connection 585858
set -g tide_prompt_color_separator_same_color 949494
set -g tide_prompt_icon_connection ' '
set -g tide_prompt_min_cols 34
set -g tide_prompt_pad_items true
set -g tide_prompt_transient_enabled false
set -g tide_pulumi_bg_color F7BF2A
set -g tide_pulumi_color 000000
set -g tide_pulumi_icon \uf1b2
set -g tide_pwd_bg_color 3465A4
set -g tide_pwd_color_anchors E4E4E4
set -g tide_pwd_color_dirs E4E4E4
set -g tide_pwd_color_truncated_dirs BCBCBC
set -g tide_pwd_icon \uf07c
set -g tide_pwd_icon_home \uf015
set -g tide_pwd_icon_unwritable \uf023
set -g tide_pwd_markers .bzr .citc .git .hg .node-version .python-version .ruby-version .shorten_folder_marker .svn .terraform Cargo.toml composer.json CVS go.mod package.json
set -g tide_python_bg_color 444444
set -g tide_python_color 00AFAF
set -g tide_python_icon \U000f0320
set -g tide_right_prompt_frame_enabled true
set -g tide_right_prompt_items status cmd_duration context jobs direnv node python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell nix_env crystal elixir
set -g tide_right_prompt_prefix \ue0b2
set -g tide_right_prompt_separator_diff_color \ue0ba
set -g tide_right_prompt_separator_same_color \ue0b3
set -g tide_right_prompt_suffix
set -g tide_ruby_bg_color B31209
set -g tide_ruby_color 000000
set -g tide_ruby_icon \ue23e
set -g tide_rustc_bg_color F74C00
set -g tide_rustc_color 000000
set -g tide_rustc_icon \ue7a8
set -g tide_shlvl_bg_color 808000
set -g tide_shlvl_color 000000
set -g tide_shlvl_icon \uf120
set -g tide_shlvl_threshold 1
set -g tide_status_bg_color 2E3436
set -g tide_status_bg_color_failure CC0000
set -g tide_status_color 4E9A06
set -g tide_status_color_failure FFFF00
set -g tide_status_icon \u2714
set -g tide_status_icon_failure \u2718
set -g tide_terraform_bg_color 800080
set -g tide_terraform_color 000000
set -g tide_terraform_icon
set -g tide_time_bg_color D3D7CF
set -g tide_time_color 000000
set -g tide_time_format
set -g tide_toolbox_bg_color 613583
set -g tide_toolbox_color 000000
set -g tide_toolbox_icon \ue24f
set -g tide_vi_mode_bg_color_default 949494
set -g tide_vi_mode_bg_color_insert 87AFAF
set -g tide_vi_mode_bg_color_replace 87AF87
set -g tide_vi_mode_bg_color_visual FF8700
set -g tide_vi_mode_color_default 000000
set -g tide_vi_mode_color_insert 000000
set -g tide_vi_mode_color_replace 000000
set -g tide_vi_mode_color_visual 000000
set -g tide_vi_mode_icon_default D
set -g tide_vi_mode_icon_insert I
set -g tide_vi_mode_icon_replace R
set -g tide_vi_mode_icon_visual V
