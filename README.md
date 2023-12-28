# Открытие файлов в Neovide из контекстного меню в Windows

1. Для начала устанавливаем Neovide - [https://github.com/neovide/neovide. ](https://github.com/neovide/neovide)Почему не использовать команду nvim из терминала Windows? Лично мне удобно иногда иметь возможность открывать файлы посредством Drag&Drop. Если это не ваш случай, то достаточно простого запуска NVim из терминала, но код в PowerShell скрипте придётся подкорректировать
2. Убираем анимацию курсора и уменьшаем размеры шрифта в Neovide. Просто поместите в init.lua следующий код  
```
if vim.g.neovide then
    vim.o.guifont = "Hack NF:h10" — text below applies for VimScript
    vim.g.neovide\_remember\_window\_size = true
    vim.g.neovide\_cursor\_animate\_command\_line = false
    vim.g.neovide\_cursor\_animation\_length = 0 
end
```
3. Устанавливаем Neovim-remote - [https://github.com/mhinz/neovim-remote](https://github.com/mhinz/neovim-remote) Это нам потребуется для запуска сервера, который слушает команды. Команды будем передавать чтобы открывались файлы в новой вкладке уже запущенного процесса, а не в новом процессе.
4. Скачиваем PowerShell скрипт файл в любую удобную директорию [run_neovide.ps1](files/run_neovide.ps1) или создаём новый с кодом ниже:  
```
param($asset)
$env:NVIM\_LISTEN\_ADDRESS = "\\.\pipe\nvim-nvr"
function nvd {neovide —multigrid — —listen "$env:NVIM\_LISTEN\_ADDRESS" $args}
function nvr {if (-not (Test-Path $env:NVIM\_LISTEN\_ADDRESS)) {nvd $args } else {if ($args) {nvim —server "$env:NVIM\_LISTEN\_ADDRESS" —remote $args}}}
nvr $asset
``` 
5. Правим код в .reg файле, заменив слово **YOURPATH** на путь, где лежит ваш run_neovide.ps1 файл. Название диска тоже потребуется изменить, если сохранили не на диске C:\. Также убедитесь, что файл сохранён в кодировке Windows 1251, иначе в меню будут кракозябры вместо кириллицы.  
   [run_neovide.reg](files/run_neovide.reg)
6. Запускаем .reg файл и видим в контекстном меню новый пункт 'Открыть в Neovide'
