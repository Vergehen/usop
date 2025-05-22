#!/bin/bash
# Copyright (c) 2025 Bohdan Stroy
# Licensed under the MIT License. See LICENSE for details.

GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
YELLOW="\e[33m"
NC="\e[0m" # No Color

LANGUAGE="UA"

function set_language() {
    clear
    echo -e "${CYAN}Оберіть мову / Choose language:${NC}"
    echo "1. Українська"
    echo "2. English"
    read -p "Вибір / Choice: " lang
    case $lang in
        1) LANGUAGE="UA";;
        2) LANGUAGE="EN";;
        *) LANGUAGE="UA";;
    esac
    clear
}

function get_label() {
    case $LANGUAGE in
        UA)
            case $1 in
                title) echo "КОНСОЛЬ УПРАВЛІННЯ UBUNTU-СЕРВЕРА";;
                main1) echo "1. Керування веб-стеком";;
                main2) echo "2. Додати локальний домен";;
                main3) echo "3. Стан та керування службами";;
                main4) echo "4. Додаткові сервіси та інструменти";;
                main5) echo "5. Вихід";;
                change_lang) echo "6. Змінити мову";;
                prompt) echo "Ваш вибір: ";;
                tools_title) echo "Установка додаткових сервісів та інструментів:";;
                back) echo "0. Назад";;
                invalid) echo "Неправильний вибір!";;
                stack_title) echo "Керування компонентами веб-стеку:";;
                select_version) echo "Доступні версії:";;
                manual_install) echo "Введіть назву пакету для ручної установки:";;
            esac;;
        EN)
            case $1 in
                title) echo "UBUNTU SERVER CONTROL PANEL";;
                main1) echo "1. Web Stack Management";;
                main2) echo "2. Add Local Domain";;
                main3) echo "3. Services Status and Control";;
                main4) echo "4. Additional Services and Tools";;
                main5) echo "5. Exit";;
                change_lang) echo "6. Change Language";;
                prompt) echo "Your choice: ";;
                tools_title) echo "Install additional services and tools:";;
                back) echo "0. Back";;
                invalid) echo "Invalid choice!";;
                stack_title) echo "Manage Web Stack Components:";;
                select_version) echo "Available versions:";;
                manual_install) echo "Enter package name for manual install:";;
            esac;;
    esac
}

function show_menu {
    clear
    echo -e "${CYAN}"
    title="$(get_label title)"
    len=${#title}
    box_width=$((len + 8))
    top_border="┌$(printf '─%.0s' $(seq 1 $box_width))┐"
    middle_line="│    $title    │"
    bottom_border="└$(printf '─%.0s' $(seq 1 $box_width))┘"
    echo "$top_border"
    echo "$middle_line"
    echo "$bottom_border"
    echo -e "${NC}"
    echo "$(get_label main1)"
    echo "$(get_label main2)"
    echo "$(get_label main3)"
    echo "$(get_label main4)"
    echo "$(get_label main5)"
    echo "$(get_label change_lang)"
    echo
    read -p "$(get_label prompt)" choice
    case $choice in
        1) setup_stack_menu ;;
        2) add_domain ;;
        3) manage_modules_menu ;;
        4) extra_tools_menu ;;
        5) exit 0 ;;
        6) set_language ; show_menu ;;
        *) echo -e "${RED}$(get_label invalid)${NC}"; sleep 2; show_menu ;;
    esac
}

function setup_stack_menu {
    clear
    echo -e "${CYAN}$(get_label stack_title)${NC}"
    echo "1. Nginx"
    echo "2. Apache"
    echo "3. PHP"
    echo "4. MySQL"
    echo "5. phpMyAdmin"
    echo "6. Adminer"
    echo "7. Node.js"
    echo "8. Manual install"
    echo "$(get_label back)"
    read -p "$(get_label prompt)" choice
    case $choice in
        1) manage_component "nginx" ;;
        2) manage_component "apache2" ;;
        3) manage_component "php" ;;
        4) manage_component "mysql-server" ;;
        5) manage_component "phpmyadmin" ;;
        6) manage_component "adminer" ;;
        7) manage_component "nodejs" ;;
        8) manual_install_component ;;
        0) show_menu ;;
        *) echo -e "${RED}$(get_label invalid)${NC}"; sleep 2 ;;
    esac
    sleep 2
    setup_stack_menu
}

function manual_install_component {
    read -p "$(get_label manual_install) " pkg
    sudo apt install -y $pkg
    sleep 2
}

function show_versions {
    local component=$1
    apt-cache madison $component | awk '{print $3}' || echo "No versions found"
}

function manage_component {
    local component=$1
    clear
    echo -e "${CYAN}${component^^} MANAGEMENT${NC}"
    echo "1. Install (default version)"
    echo "2. Reinstall"
    echo "3. Remove"
    echo "4. Configure"
    echo "5. Show current version"
    echo "6. Show available versions"
    echo "7. Manual version install"
    echo "$(get_label back)"
    read -p "$(get_label prompt)" choice
    case $choice in
        1) sudo apt install -y $component ;;
        2) sudo apt install --reinstall -y $component ;;
        3) sudo apt purge --autoremove -y $component ;;
        4) sudo nano /etc/${component}/* 2>/dev/null || echo "No config file found." ;;
        5) $component -v 2>/dev/null || $component --version 2>/dev/null || echo "Version command not supported." ;;
        6) echo -e "${YELLOW}$(get_label select_version)${NC}"; show_versions $component ;;
        7) echo -e "${YELLOW}$(get_label select_version)${NC}"; show_versions $component; read -p "Version: " ver; sudo apt install -y ${component}=${ver} ;;
        0) setup_stack_menu ;;
        *) echo -e "${RED}$(get_label invalid)${NC}"; sleep 2 ;;
    esac
    sleep 2
    manage_component $component
}

function extra_tools_menu {
    clear
    echo -e "${CYAN}$(get_label tools_title)${NC}"
    echo "1. Docker & Docker Compose"
    echo "2. Redis"
    echo "3. MongoDB"
    echo "4. PostgreSQL"
    echo "5. Python + venv"
    echo "6. Let's Encrypt Certificates"
    echo "7. UFW / Firewall"
    echo "8. Monitoring (htop, glances)"
    echo "9. Security tools (SSH, fail2ban, swap, autostart)"
    echo "$(get_label back)"
    read -p "$(get_label prompt)" choice
    case $choice in
        1) sudo apt install docker.io docker-compose -y ;;
        2) sudo apt install redis -y ;;
        3) sudo apt install mongodb -y ;;
        4) sudo apt install postgresql -y ;;
        5) sudo apt install python3 python3-venv -y ;;
        6) sudo apt install certbot python3-certbot-nginx -y ;;
        7) sudo apt install ufw -y && sudo ufw enable ;;
        8) sudo apt install htop glances -y ;;
        9)
            sudo apt install fail2ban -y
            sudo systemctl enable fail2ban
            sudo systemctl start fail2ban
            sudo fallocate -l 2G /swapfile
            sudo chmod 600 /swapfile
            sudo mkswap /swapfile
            sudo swapon /swapfile
            echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
            ;;
        0) show_menu ;;
        *) echo -e "${RED}$(get_label invalid)${NC}"; sleep 2 ;;
    esac
    sleep 2
    extra_tools_menu
}

set_language
show_menu