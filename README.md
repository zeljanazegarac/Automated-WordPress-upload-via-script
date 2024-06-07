This script automates the setup of a WordPress environment on a freshly installed Linux machine. It installs NGINX, MariaDB, PHP, configures the database, and sets up WordPress.


## Prerequisites
- A Linux machine with `dnf` package manager.
- `sudo` privileges.

## Usage
1. Clone this repository:
   ```bash
   git clone https://github.com/zeljanazegarac/Automated-WordPress-upload-via-script.git
   cd Automated-WordPress-upload-via-script
   ```

2. Run the setup script:
   ```bash
   bash setup-wordpress.sh
   ```

3. Open your browser and go to `http://localhost` to complete the WordPress installation.

## Configuration

The script sets up the following default values:
- Database Name: `wordpress`
- Database User: `wp_user`
- Database Password: `password`

You can modify these values by editing the script before running it.
