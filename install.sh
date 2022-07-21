#!/bin/bash
rm -f /etc/profile.d/cyberpanel_env.sh

export GIT_PROVIDER="github.com"
export RAW_CONTENT="raw.githubusercontent.com"
export BASE_REPO="cyberpanel-dynamic/cyberpanel"
export BASE_REPO_THEMES="usmannasir/CyberPanel-Themes"
export GIT_REPO="https://${GIT_PROVIDER}/${BASE_REPO}"
export RAW_GIT_REPO="https://${RAW_CONTENT}/${BASE_REPO}"
export GIT_THEMES_REPO="https://${GIT_PROVIDER}/${BASE_REPO_THEMES}"
export RAW_GIT_THEMES_REPO="https://${RAW_CONTENT}/${BASE_REPO_THEMES}"
export GIT_API="https://api.${GIT_PROVIDER}/repos/${BASE_REPO}"
export GIT_API_THEMES="https://api.${GIT_PROVIDER}/repos/${BASE_REPO_THEMES}"

cat << EOF > /etc/profile.d/cyberpanel_env.sh
export GIT_PROVIDER="${GIT_PROVIDER}"
export RAW_CONTENT="${RAW_CONTENT}"
export BASE_REPO="${BASE_REPO}"
export BASE_REPO_THEMES="${BASE_REPO_THEMES}"
export GIT_REPO="${GIT_REPO}"
export RAW_GIT_REPO="${RAW_GIT_REPO}"
export GIT_THEMES_REPO="${GIT_THEMES_REPO}"
export RAW_GIT_THEMES_REPO="${RAW_GIT_THEMES_REPO}"
export GIT_API="${GIT_API}"
export GIT_API_THEMES="${GIT_API_THEMES}"
EOF

. /etc/profile.d/cyberpanel_env.sh

DEFAULT_BRANCH="stable"

#Don't change this, it's meant for user input branch validation check (pattern)
BRANCH_CHECK="1.9.3"

check_valid_os() {
	OUTPUT=$(cat /etc/*release)
	if  echo $OUTPUT | grep -q "CentOS Linux 7" ; then
        	echo "Checking and installing curl and wget"
		yum install curl wget git jq -y 1> /dev/null
		yum update curl wget ca-certificates -y 1> /dev/null
                SERVER_OS="CentOS"
	elif echo $OUTPUT | grep -q "CentOS Linux 8" ; then
        	echo -e "\nDetecting Centos 8...\n"
		yum install curl wget git jq -y 1> /dev/null
		yum update curl wget ca-certificates -y 1> /dev/null
		SERVER_OS="CentOS8"
	elif echo $OUTPUT | grep -q "CloudLinux 7" ; then
        	echo "Checking and installing curl and wget"
		yum install curl wget git jq -y 1> /dev/null
		yum update curl wget ca-certificates -y 1> /dev/null
                SERVER_OS="CloudLinux"
        elif echo $OUTPUT | grep -q "AlmaLinux 8" ; then
		echo "Checking and installing curl and wget"
		yum install curl wget git jq -y 1> /dev/null
		yum update curl wget ca-certificates -y 1> /dev/null
        	SERVER_OS="AlmaLinux"
       elif echo $OUTPUT | grep -q "Rocky Linux" ; then
		echo "Checking and installing curl and wget"
		yum install curl wget git jq -y 1> /dev/null
		yum update curl wget ca-certificates -y 1> /dev/null
		SERVER_OS="RockyLinux"
	elif echo $OUTPUT | grep -q "Ubuntu 18.04" ; then
		apt install -y -qq wget curl git jq
                SERVER_OS="Ubuntu"
	elif echo $OUTPUT | grep -q "Ubuntu 20.04" ; then
		apt install -y -qq wget curl git jq
                SERVER_OS="Ubuntu20"
	elif echo $OUTPUT | grep -q "openEuler 20.03" ; then
        	echo -e "\nDetecting openEuler 20.03...\n"
        	yum install curl wget git jq -y 1> /dev/null
		yum update curl wget ca-certificates -y 1> /dev/null
		SERVER_OS="openEuler"
	elif echo $OUTPUT | grep -q "openEuler 22.03" ; then
        	echo -e "\nDetecting openEuler 22.03...\n"
       		SERVER_OS="openEuler"
		yum install curl wget git jq -y 1> /dev/null
		yum update curl wget ca-certificates -y 1> /dev/null
	else
                echo -e "\nUnable to detect your OS...\n"
                echo -e "\nCyberPanel is supported on Ubuntu 18.04, CentOS 7.x and CloudLinux 7.x...\n"
                exit 1
	fi

}

choose_branch() {
	echo -e "\nPress \e[31mEnter\e[39m key to continue with latest version or Enter specific version such 	as: \e[31m1.9.4\e[39m , \e[31m2.0.1\e[39m , \e[31m2.0.2\e[39m ...etc"
	printf "%s" ""
	read -r TMP_BRANCH
	
	if [[ $TMP_BRANCH = "" ]]; then
		echo -e "Branch name set to $DEFAULT_BRANCH"
		BRANCH_NAME=$DEFAULT_BRANCH
	else
		branch_check "$TMP_BRANCH"
	fi
	echo "export BRANCH_NAME=${BRANCH_NAME}" >> /etc/profile.d/cyberpanel_env.sh
}

branch_check() {
	if [[ "$1" = *.*.* ]]; then
	  	#check input if it's valid format as X.Y.Z
	  	OUTPUT=$(awk -v num1="$BRANCH_CHECK" -v num2="${1//[[:space:]]/}" '
	  	BEGIN {
	    		print "num1", (num1 < num2 ? "<" : ">="), "num2"
	  	}
	  	')
	  	if [[ $OUTPUT = *">="* ]]; then
	    		echo -e "\nYou must use version number higher than 1.9.4"
	    		exit
	  	else
	    		BRANCH_NAME="v${1//[[:space:]]/}"
	    		echo -e "\nSet branch name to $BRANCH_NAME..."
	  	fi
	elif [[ "$1" = "stable" ]]; then
		BRANCH_NAME="stable"
		echo -e "\nSet branch name to $BRANCH_NAME..."
	else
	  	echo -e "\nPlease input a valid format version number."
	  	exit
	fi
}

start_install_script() {
	rm -f cyberpanel.sh
	rm -f install.tar.gz
	curl --silent -o cyberpanel.sh "$RAW_GIT_REPO/$BRANCH_NAME/cyberpanel.sh"
	chmod +x cyberpanel.sh
	./cyberpanel.sh $@
}

check_valid_os
choose_branch
start_install_script
