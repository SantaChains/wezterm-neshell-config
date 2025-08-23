# WezTerm Nushell 别名配置
# 针对 Nushell 优化的常用别名和函数

# ============================================================================
# 系统导航别名
# ============================================================================

# 快速目录导航
alias ll = ls -la
alias la = ls -a
alias l = ls

# 快速返回上级目录
def --env ".." [] { cd .. }
def --env "..." [] { cd ../.. }
def --env "...." [] { cd ../../.. }

# ============================================================================
# Git 相关别名
# ============================================================================

alias gs = git status
alias ga = git add
alias gc = git commit -m
alias gp = git push
alias gl = git log --oneline -10
alias gd = git diff
alias gb = git branch
alias gco = git checkout

# ============================================================================
# 开发工具别名
# ============================================================================

# Node.js 相关
alias ni = npm install
alias nr = npm run
alias ns = npm start
alias nt = npm test

# Python 相关
alias py = python
alias pip3 = python -m pip

# Rust 相关 (Nushell 生态)
alias rr = cargo run
alias rb = cargo build
alias rt = cargo test

# ============================================================================
# 系统工具别名
# ============================================================================

# 清屏
alias cls = clear

# 快速编辑配置文件
def edit-wezterm [] {
    code $"($env.USERPROFILE)\\.config\\wezterm\\wezterm.lua"
}

def edit-nu-config [] {
    code $nu.config-path
}

# 系统信息
def sysinfo [] {
    sys | select host
}

# 网络测试
def ping-test [host: string] {
    ping $host
}

# ============================================================================
# 文件操作别名
# ============================================================================

# 创建目录并进入
def --env mkcd [path: string] {
    mkdir $path
    cd $path
}

# 快速查找文件
def ff [pattern: string] {
    find . -name $"*($pattern)*"
}

# 文件大小统计
def du [] {
    ls | get size | math sum
}

# ============================================================================
# WezTerm 特定功能
# ============================================================================

# 重新加载 WezTerm 配置
def reload-wezterm [] {
    print "重新加载 WezTerm 配置..."
    # Nushell 中可以通过快捷键 Ctrl+Shift+R 重载
}

# 显示 WezTerm 信息
def wezterm-info [] {
    print $"WezTerm 配置路径: ($env.USERPROFILE)\\.config\\wezterm"
    print "配置文件: wezterm.lua"
    print "模块目录: config/"
    print "默认 Shell: Nushell"
}

# ============================================================================
# Nushell 特色功能
# ============================================================================

# 美化的进程列表
def psl [] {
    ps | sort-by cpu | reverse | first 10
}

# 端口占用检查
def port-check [port: int] {
    netstat -ano | find $"($port)"
}

# 快速 JSON 格式化
def json-pretty [file: string] {
    open $file | to json -i 2
}

# 环境变量快速查看
def envs [] {
    $env | transpose key value | sort-by key
}

print "WezTerm Nushell 别名配置已加载"