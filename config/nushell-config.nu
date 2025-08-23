# Nushell 配置文件
# 用于自定义 Nushell 的行为和外观

# ============================================================================
# 移除启动欢迎信息和基础配置
# ============================================================================

# 设置环境变量来禁用启动横幅
$env.config = {
    show_banner: false,  # 禁用启动横幅
    footer_mode: 25,
    float_precision: 2,
    buffer_editor: "D:\\Users\\Jliu Pureey\\Downloads\\APP\\EmEditor\\EmEditor.exe",
    use_ansi_coloring: true,
    bracketed_paste: true,
    edit_mode: "emacs",
    shell_integration: {
        osc2: false,
        osc7: false,
        osc8: false,
        osc9_9: false,
        osc133: false,
        osc633: false,
        reset_application_mode: false,
    },
    render_right_prompt_on_last_line: false,
    use_kitty_protocol: false,
    highlight_resolved_externals: false,
    recursion_limit: 50,
    plugin_gc: {
        default: {
            enabled: true,
            stop_after: 10sec,
        },
        plugins: {},
    },
    hooks: {
        pre_prompt: [{ null }],
        pre_execution: [{ null }],
        env_change: {
            PWD: [{|before, after| null }],
        },
        display_output: "if (term size).columns >= 100 { table -e } else { table }",
        command_not_found: { null },
    },
    history: {
        max_size: 100_000,
        sync_on_enter: true,
        file_format: "plaintext",
        isolation: false,
    },
    completions: {
        case_sensitive: false,
        quick: true,
        partial: true,
        algorithm: "prefix",
        external: {
            enable: true,
            max_results: 100,
            completer: null,
        },
        use_ls_colors: true,
    },
    table: {
        mode: rounded,
        index_mode: always,
        show_empty: true,
        padding: { left: 1, right: 1 },
        trim: {
            methodology: wrapping,
            wrapping_try_keep_words: true,
            truncating_suffix: "...",
        },
        header_on_separator: false,
    },
    keybindings: [
        {
            name: completion_menu,
            modifier: none,
            keycode: tab,
            mode: [emacs vi_normal vi_insert],
            event: {
                until: [
                    { send: menu name: completion_menu },
                    { send: menunext },
                    { edit: complete },
                ],
            },
        },
        {
            name: history_menu,
            modifier: control,
            keycode: char_r,
            mode: [emacs, vi_insert, vi_normal],
            event: { send: menu name: history_menu },
        },
        {
            name: help_menu,
            modifier: none,
            keycode: f1,
            mode: [emacs, vi_insert, vi_normal],
            event: { send: menu name: help_menu },
        },
        {
            name: completion_previous_menu,
            modifier: shift,
            keycode: backtab,
            mode: [emacs, vi_normal, vi_insert],
            event: { send: menuprevious },
        },
        {
            name: escape,
            modifier: none,
            keycode: escape,
            mode: [emacs, vi_normal, vi_insert],
            event: { send: esc },
        },
        {
            name: cancel_command,
            modifier: control,
            keycode: char_c,
            mode: [emacs, vi_normal, vi_insert],
            event: { send: ctrlc },
        },
        {
            name: quit_shell,
            modifier: control,
            keycode: char_d,
            mode: [emacs, vi_normal, vi_insert],
            event: { send: ctrld },
        },
        {
            name: clear_screen,
            modifier: control,
            keycode: char_l,
            mode: [emacs, vi_normal, vi_insert],
            event: { send: clearscreen },
        },
        {
            name: newline_or_run_command,
            modifier: none,
            keycode: enter,
            mode: emacs,
            event: { send: enter },
        },
    ],
    menus: [
        {
            name: completion_menu,
            only_buffer_difference: false,
            marker: "| ",
            type: {
                layout: columnar,
                columns: 4,
                col_width: 20,
                col_padding: 2,
            },
            style: {
                text: green,
                selected_text: green_reverse,
                description_text: yellow,
            },
        },
        {
            name: history_menu,
            only_buffer_difference: true,
            marker: "? ",
            type: {
                layout: list,
                page_size: 10,
            },
            style: {
                text: green,
                selected_text: green_reverse,
                description_text: yellow,
            },
        },
        {
            name: help_menu,
            only_buffer_difference: true,
            marker: "? ",
            type: {
                layout: description,
                columns: 4,
                col_width: 20,
                col_padding: 2,
                selection_rows: 4,
                description_rows: 10,
            },
            style: {
                text: green,
                selected_text: green_reverse,
                description_text: yellow,
            },
        },
    ],
}

# ============================================================================
# 自定义提示符
# ============================================================================

# 定义简洁的左侧提示符
def create_left_prompt [] {
    let home = $nu.home-path
    let dir = match (do -i { $env.PWD | path relative-to $home }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let path_color = (ansi cyan_bold)  # 改为青色，更醒目
    $"($path_color)($dir)(ansi reset)"
}

# 定义右侧提示符 (显示 Git 分支)
def create_right_prompt [] {
    # Git 分支信息
    let git_branch = (do -i {
        git branch --show-current 2>nul
    })
    
    if ($git_branch | is-empty) {
        ""
    } else {
        $"(ansi light_blue)($git_branch)(ansi reset)"
    }
}

# 应用自定义提示符
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { || create_right_prompt }
$env.PROMPT_INDICATOR = { || "❯ " }
$env.PROMPT_INDICATOR_VI_INSERT = { || ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = { || "〉" }
$env.PROMPT_MULTILINE_INDICATOR = { || "::: " }

# ============================================================================
# 别名和快捷命令
# ============================================================================

# 常用别名
alias ll = ls -la
alias la = ls -a
alias cls = clear
alias .. = cd ..
alias ... = cd ../..
alias grep = rg
alias cat = bat
alias vim = nvim

# ============================================================================
# 环境变量管理 (借鉴优秀配置)
# ============================================================================

# 代理设置函数
def --env "proxy set" [] {
    load-env { 
        "HTTP_PROXY": "socks5://127.0.0.1:10808", 
        "HTTPS_PROXY": "socks5://127.0.0.1:10808" 
    }
    print "代理已启用"
}

def --env "proxy unset" [] {
    load-env { "HTTP_PROXY": "", "HTTPS_PROXY": "" }
    print "代理已禁用"
}

def "proxy check" [] {
    print "测试连接到 Google..."
    let resp = (do -i {
        curl -I -s --connect-timeout 2 -m 2 -w "%{http_code}" -o /dev/null www.google.com
    })
    
    if $resp == "200" {
        print "代理设置成功！"
    } else {
        print "代理设置失败或网络不可达"
    }
}

# 系统信息函数
def "sys info" [] {
    print $"操作系统: (sys host | get name)"
    print $"内核版本: (sys host | get kernel_version)"
    print $"CPU: (sys cpu | get brand | first)"
    print $"内存: (sys mem | get total | first | into string)"
}

# 快速目录跳转
def --env "goto home" [] { cd ~ }
def --env "goto desktop" [] { cd ~/Desktop }
def --env "goto downloads" [] { cd ~/Downloads }
def --env "goto documents" [] { cd ~/Documents }

# 文件操作增强
def "find file" [pattern: string] {
    ls **/* | where name =~ $pattern
}

def "find text" [text: string, path: string = "."] {
    rg $text $path --type-add 'config:*.{lua,nu,toml,yaml,yml,json}' -t config
}
