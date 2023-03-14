# CyberPanel

Web Hosting Control Panel that uses OpenLiteSpeed as the underlying Web Server.

## Features & Services

- Different User Access Levels (via ACLs).
- Auto SSL.
- FTP Server.
- Light-weight DNS Server (PowerDNS).
- phpMyAdmin to manage DBs (MariaDB).
- Email Support (SnappyMail).
- File Manager.
- PHP Managment.
- Firewall (FirewallD & ConfigServer Firewall Integration).
- One-click Backups and Restores.

# Supported PHP Versions

- PHP 8.1
- PHP 8.0
- PHP 7.4
- PHP 7.3
- PHP 7.2
- PHP 7.1
- PHP 7.0
- PHP 5.6
- PHP 5.5
- PHP 5.4
- PHP 5.3

# Installation Instructions

For the default installation:

```
sh <(curl https://cyberpanel.net/install.sh || wget -O - https://cyberpanel.net/install.sh)
```

For your own custom repository (change the BASE_REPO and BASE_REPO_THEMES to your own repo):

Change the file install.sh in the root folder of your github from line 4 to line 15:

```bash
echo `
export GIT_PROVIDER="github.com"
export RAW_CONTENT="raw.githubusercontent.com"
export BASE_REPO="cyberpanel-dynamic/cyberpanel"
export BASE_REPO_THEMES="usmannasir/CyberPanel-Themes"
export GIT_REPO="https://$GIT_PROVIDER/$BASE_REPO"
export RAW_GIT_REPO="https://$RAW_CONTENT/$BASE_REPO"
export GIT_THEMES_REPO="https://$GIT_PROVIDER/$BASE_REPO_THEMES"
export RAW_GIT_THEMES_REPO="https://$RAW_CONTENT/$BASE_REPO_THEMES"
export GIT_API="https://api.$GIT_PROVIDER/repos/$BASE_REPO"
export GIT_API_THEMES="https://api.$GIT_PROVIDER/repos/$BASE_REPO_THEMES"
` >> /etc/profile.d/cyberpanel_env.sh
```

The values you can change are: GIT_PROVIDER, RAW_CONTENT, BASE_REPO, BASE_REPO_THEMES

After commiting your changes to the install.sh script, run this command (Replace cyberpanel-dynamic/cyberpanel to your git repo):

** notice that it changed to bash instead of sh due to simbaclaws's lack of competence in the field of bashisms **

```
bash <(curl https://raw.githubusercontent.com/cyberpanel-dynamic/cyberpanel/stable/install.sh || wget -O - https://raw.githubusercontent.com/cyberpanel-dynamic/cyberpanel/stable/install.sh)
```

# Upgrading CyberPanel

For the default installation:

```
sh <(curl https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh || wget -O - https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh)
```

For your own custom repository (change your-username and cyberpanel to your repository):

```
sh <(curl https://raw.githubusercontent.com/your-username/cyberpanel/stable/preUpgrade.sh || wget -O - https://raw.githubusercontent.com/your-username/cyberpanel/stable/preUpgrade.sh)
```

# Resources

- [Official Site.](https://cyberpanel.net)
- [Docs (Old).](https://docs.cyberpanel.net)
- [Docs (New).](https://community.cyberpanel.net/docs)
- [Changelog.](https://community.cyberpanel.net/t/change-logs/161)
- [Forums.](https://community.cyberpanel.net)
- [Discord.](https://discord.gg/g8k8Db3)
- [Facebook Group.](https://www.facebook.com/groups/cyberpanel)
- [YouTube Channel.](https://www.youtube.com/channel/UCS6sgUWEhaFl1TO238Ck0xw)
