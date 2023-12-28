param($asset)
$env:NVIM_LISTEN_ADDRESS = "\\.\pipe\nvim-nvr"
function nvd {neovide --multigrid -- --listen "$env:NVIM_LISTEN_ADDRESS" $args}
function nvr {if (-not (Test-Path $env:NVIM_LISTEN_ADDRESS)) {nvd $args } else {if ($args) {nvim --server "$env:NVIM_LISTEN_ADDRESS" --remote $args}}}
nvr $asset

