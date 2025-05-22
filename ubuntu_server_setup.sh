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
                domain_title) echo "Додавання локального домену";;
                domain_empty) echo "Ім'я домену не може бути порожнім.";;
                domain_exists) echo "Домен вже існує у /etc/hosts.";;
                domain_added) echo "Домен додано у /etc/hosts.";;
                nginx_created) echo "Конфігурацію Nginx створено та перезавантажено.";;
                service_title) echo "Стан та керування службами";;
                action_prompt) echo "Оберіть дію: ";;
                invalid_service) echo "Неправильний вибір служби.";;
                install_default) echo "1. Встановити (версія за замовчуванням)";;
                reinstall) echo "2. Перевстановити";;
                remove) echo "3. Видалити";;
                configure) echo "4. Налаштувати";;
                current_version) echo "5. Показати поточну версію";;
                available_versions) echo "6. Показати доступні версії";;
                manual_version) echo "7. Встановити конкретну версію";;
                no_config) echo "Конфігураційний файл не знайдено.";;
                version_not_supported) echo "Команда версії не підтримується.";;
                domain_prompt) echo "Введіть ім'я домену (наприклад, mysite.local): ";;
                nginx_confirm) echo "Створити конфігурацію Nginx для %s? (т/н): ";;
                start) echo "1. Запустити %s";;
                stop) echo "2. Зупинити %s";;
                restart) echo "3. Перезапустити %s";;
                status) echo "4. Статус %s";;
                press_enter) echo "Натисніть Enter для повернення...";;
                docker) echo "1. Docker та Docker Compose";;
                redis) echo "2. Redis";;
                mongodb) echo "3. MongoDB";;
                postgresql) echo "4. PostgreSQL";;
                python) echo "5. Python та venv";;
                letsencrypt) echo "6. Let's Encrypt SSL-сертифікати";;
                firewall) echo "7. UFW / Брандмауер";;
                monitoring) echo "8. Моніторинг (htop, glances)";;
                security) echo "9. Безпека (SSH, fail2ban, swap, автозапуск)";;
                version_prompt) echo "Версія: ";;
                no_versions) echo "Версії не знайдено";;
                no_services) echo "Немає встановлених служб.";;
                must_install) echo "Спочатку встановіть компоненти через меню 'Керування веб-стеком'.";;
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
                domain_title) echo "Add Local Domain";;
                domain_empty) echo "Domain name cannot be empty.";;
                domain_exists) echo "Domain already exists in /etc/hosts.";;
                domain_added) echo "Domain added to /etc/hosts.";;
                nginx_created) echo "Nginx config created and reloaded.";;
                service_title) echo "Services Status and Control";;
                action_prompt) echo "Choose action: ";;
                invalid_service) echo "Invalid service selection.";;
                install_default) echo "1. Install (default version)";;
                reinstall) echo "2. Reinstall";;
                remove) echo "3. Remove";;
                configure) echo "4. Configure";;
                current_version) echo "5. Show current version";;
                available_versions) echo "6. Show available versions";;
                manual_version) echo "7. Manual version install";;
                no_config) echo "No config file found.";;
                version_not_supported) echo "Version command not supported.";;
                domain_prompt) echo "Enter domain name (e.g., mysite.local): ";;
                nginx_confirm) echo "Create Nginx config for %s? (y/n): ";;
                start) echo "1. Start %s";;
                stop) echo "2. Stop %s";;
                restart) echo "3. Restart %s";;
                status) echo "4. Status %s";;
                press_enter) echo "Press Enter to return...";;
                docker) echo "1. Docker & Docker Compose";;
                redis) echo "2. Redis";;
                mongodb) echo "3. MongoDB";;
                postgresql) echo "4. PostgreSQL";;
                python) echo "5. Python + venv";;
                letsencrypt) echo "6. Let's Encrypt Certificates";;
                firewall) echo "7. UFW / Firewall";;
                monitoring) echo "8. Monitoring (htop, glances)";;
                security) echo "9. Security tools (SSH, fail2ban, swap, autostart)";;
                version_prompt) echo "Version: ";;
                no_versions) echo "No versions found";;
                no_services) echo "No services installed.";;
                must_install) echo "Please install components via 'Web Stack Management' menu first.";;
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
    
    if any_component_installed; then
        echo "$(get_label main3)"
        services_installed=true
    else
        services_installed=false
    fi
    
    echo "$(get_label main4)"
    echo "$(get_label main5)"
    echo "$(get_label change_lang)"
    echo
    read -p "$(get_label prompt)" choice
    case $choice in
        1) setup_stack_menu ;;
        2) add_domain ;;
        3) 
            if $services_installed; then
                manage_modules_menu
            else
                echo -e "${RED}$(get_label invalid)${NC}"
                sleep 2
                show_menu
            fi ;;
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
    apt-cache madison $component | awk '{print $3}' || echo "$(get_label no_versions)"
}

function is_package_installed() {
    local package_name=$1
    dpkg -l | grep -q "^ii  $package_name "
    return $?
}

function has_systemd() {
    [ -d /run/systemd/system ] && return 0 || return 1
}

function service_control() {
    local action=$1
    local service=$2
    
    if has_systemd; then
        case "$action" in
            start) sudo systemctl start "$service" ;;
            stop) sudo systemctl stop "$service" ;;
            restart) sudo systemctl restart "$service" ;;
            reload) sudo systemctl reload "$service" ;;
            enable) sudo systemctl enable "$service" ;;
            status) sudo systemctl status "$service" ;;
        esac
    else
        case "$action" in
            start) 
                if [ -f "/etc/init.d/$service" ]; then
                    sudo /etc/init.d/"$service" start
                else
                    echo -e "${YELLOW}Service control not available in this environment.${NC}"
                fi ;;
            stop)
                if [ -f "/etc/init.d/$service" ]; then
                    sudo /etc/init.d/"$service" stop
                else
                    echo -e "${YELLOW}Service control not available in this environment.${NC}"
                fi ;;
            restart)
                if [ -f "/etc/init.d/$service" ]; then
                    sudo /etc/init.d/"$service" restart
                else
                    echo -e "${YELLOW}Service control not available in this environment.${NC}"
                fi ;;
            reload)
                if [ -f "/etc/init.d/$service" ]; then
                    sudo /etc/init.d/"$service" reload
                elif [ "$service" = "nginx" ]; then
                    sudo nginx -s reload
                else
                    echo -e "${YELLOW}Service reload not available in this environment.${NC}"
                fi ;;
            enable)
                if has_systemd; then
                    sudo systemctl enable "$service"
                else
                    echo -e "${YELLOW}Service autostart not supported in this environment.${NC}"
                    if [ -f "/etc/init.d/$service" ]; then
                        sudo update-rc.d "$service" defaults
                    fi
                fi ;;
            status)
                if [ -f "/etc/init.d/$service" ]; then
                    sudo /etc/init.d/"$service" status
                elif [ "$service" = "nginx" ]; then
                    ps aux | grep "[n]ginx" || echo "Nginx is not running"
                elif [ "$service" = "apache2" ]; then
                    ps aux | grep "[a]pache2" || echo "Apache is not running"
                elif [ "$service" = "mysql" ]; then
                    ps aux | grep "[m]ysqld" || echo "MySQL is not running"
                else
                    ps aux | grep "$service" || echo "$service process not found"
                fi ;;
        esac
    fi
}

function get_installed_components() {
    local installed_components=()
    local components=("nginx" "apache2" "php" "mysql-server" "phpmyadmin" "adminer" "nodejs" "postgresql" "redis-server" "docker.io" "fail2ban" "ssh")
    
    for component in "${components[@]}"; do
        if is_package_installed "$component"; then
            installed_components+=("$component")
        fi
    done
    
    echo "${installed_components[@]}"
}

function any_component_installed() {
    local components=("nginx" "apache2" "php" "mysql-server" "phpmyadmin" "adminer" "nodejs" "postgresql" "redis-server" "docker.io" "fail2ban" "ssh")
    
    for component in "${components[@]}"; do
        if is_package_installed "$component"; then
            return 0
        fi
    done
    
    return 1
}

function manage_component {
    local component=$1
    clear
    echo -e "${CYAN}${component^^} MANAGEMENT${NC}"
    echo "$(get_label install_default)"
    echo "$(get_label reinstall)"
    echo "$(get_label remove)"
    echo "$(get_label configure)"
    echo "$(get_label current_version)"
    echo "$(get_label available_versions)"
    echo "$(get_label manual_version)"
    echo "$(get_label back)"
    read -p "$(get_label prompt)" choice
    case $choice in
        1) sudo apt install -y $component ;;
        2) sudo apt install --reinstall -y $component ;;
        3) sudo apt purge --autoremove -y $component ;;
        4) sudo nano /etc/${component}/* 2>/dev/null || echo "$(get_label no_config)" ;;
        5) 
            if [ "$component" = "nginx" ]; then
                nginx -v 2>&1 || echo "$(get_label version_not_supported)"
            else
                $component -v 2>/dev/null || $component --version 2>/dev/null || echo "$(get_label version_not_supported)"
            fi ;;
        6) echo -e "${YELLOW}$(get_label select_version)${NC}"; show_versions $component ;;
        7) echo -e "${YELLOW}$(get_label select_version)${NC}"; show_versions $component; read -p "$(get_label version_prompt)" ver; sudo apt install -y ${component}=${ver} ;;
        0) setup_stack_menu ;;
        *) echo -e "${RED}$(get_label invalid)${NC}"; sleep 2 ;;
    esac
    sleep 2
    manage_component $component
}

function add_domain {
    clear
    echo -e "${CYAN}$(get_label domain_title)${NC}"
    read -p "$(get_label domain_prompt)" domain
    if [[ -z "$domain" ]]; then
        echo -e "${RED}$(get_label domain_empty)${NC}"
        sleep 2
        show_menu
        return
    fi

    if ! grep -q "$domain" /etc/hosts; then
        echo "127.0.0.1 $domain" | sudo tee -a /etc/hosts > /dev/null
        echo -e "${GREEN}$(get_label domain_added)${NC}"
    else
        echo -e "${YELLOW}$(get_label domain_exists)${NC}"
    fi

    prompt=$(printf "$(get_label nginx_confirm)" "$domain")
    read -p "$prompt" confirm
    if [[ "$confirm" == "y" || "$confirm" == "т" ]]; then
        sudo bash -c "cat > /etc/nginx/sites-available/$domain" <<EOF
server {
    listen 80;
    server_name $domain;
    root /var/www/$domain;
    index index.html index.htm;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF
        sudo mkdir -p /var/www/$domain
        echo "<h1>$domain works!</h1>" | sudo tee /var/www/$domain/index.html > /dev/null
        sudo ln -sf /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/
        sudo nginx -t && service_control reload nginx
        echo -e "${GREEN}$(get_label nginx_created)${NC}"
    fi

    sleep 3
    show_menu
}

function manage_modules_menu {
    clear
    echo -e "${CYAN}$(get_label service_title)${NC}"
    
    all_services=("nginx" "apache2" "mysql" "postgresql" "redis-server" "docker.io" "fail2ban" "ssh")
    
    installed_services=()
    for svc in "${all_services[@]}"; do
        if is_package_installed "$svc"; then
            installed_services+=("$svc")
        fi
    done
    
    if [ ${#installed_services[@]} -eq 0 ]; then
        echo -e "${YELLOW}$(get_label no_services)${NC}"
        echo -e "${YELLOW}$(get_label must_install)${NC}"
        sleep 3
        show_menu
        return
    fi
    
    i=1
    for svc in "${installed_services[@]}"; do
        echo "$i. $svc"
        ((i++))
    done
    echo "$(get_label back)"
    read -p "$(get_label prompt)" svc_index

    if [[ "$svc_index" == "0" ]]; then
        show_menu
        return
    fi

    if (( svc_index >= 1 && svc_index <= ${#installed_services[@]} )); then
        svc_name=${installed_services[$((svc_index - 1))]}
        printf "$(get_label start)\n" "$svc_name"
        printf "$(get_label stop)\n" "$svc_name"
        printf "$(get_label restart)\n" "$svc_name"
        printf "$(get_label status)\n" "$svc_name"
        echo "$(get_label back)"
        read -p "$(get_label action_prompt)" action
        case $action in
            1) service_control start $svc_name ;;
            2) service_control stop $svc_name ;;
            3) service_control restart $svc_name ;;
            4) service_control status $svc_name ;;
            0) manage_modules_menu ;;
            *) echo -e "${RED}$(get_label invalid)${NC}";;
        esac
    else
        echo -e "${RED}$(get_label invalid_service)${NC}"
    fi

    read -p "$(get_label press_enter)" _
    manage_modules_menu
}

function extra_tools_menu {
    clear
    echo -e "${CYAN}$(get_label tools_title)${NC}"
    echo "$(get_label docker)"
    echo "$(get_label redis)"
    echo "$(get_label mongodb)"
    echo "$(get_label postgresql)"
    echo "$(get_label python)"
    echo "$(get_label letsencrypt)"
    echo "$(get_label firewall)"
    echo "$(get_label monitoring)"
    echo "$(get_label security)"
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
            service_control enable fail2ban
            service_control start fail2ban
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
