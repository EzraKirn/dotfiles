show_module_git_repo_branch() {
  local index=$1
  local icon="$(get_tmux_option "@catppuccin_test_icon" "󰙨")"
  local color="$(get_tmux_option "@catppuccin_test_color" "$thm_blue")"
  local text="$(get_tmux_option "@catppuccin_test_text" "#(cd #{pane_current_path}; $HOME/dotfiles/tmux/catpuchinSubmodules/git_repo_branch.sh)" )"

  local module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
