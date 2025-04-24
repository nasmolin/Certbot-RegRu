> ⚠️ **DEPRECATED PROJECT**  
> This project is no longer maintained.
> Please use the updated Python version instead: [Certbot-RegRu-Pyton](https://github.com/nasmolin/Certbot-Regru-Python)

# Certbot Regru Wildcard scripts

use python version

These scripts allow the creation of Let's Encrypt wildcard certificates on Regru managed domains. Certificates created using these scripts will have the Common Name (CN) set to the wildcard domain (e.g. "*.subdomain.example.com").

Note that these scripts require storing the credentials to the GoDaddy API on your server, which is generally not a very good idea.

## Usage
- Enter you [Certbot API] and domain information in the api-settings.sh file
- [OPTIONAL] Edit the certbot-renew-post-hook.sh script to execute actions after renewing a certificate (e.g. nginx reload)
- Request a new certificate by calling the certbot-request.sh script
	- ```/path/to/certbot-request.sh```
- Create a daily cronjob to automatically renew your certificate:
	- ```0 4 * * * /path/to/certbot-renew.sh```
- Modify the permissions of the api-settings.sh file so only the user running the cronjob is able to read it
	- ```chown root:root /path/to/api-settings.sh```
	- ```chmod 600 /path/to/api-settings.sh```


Your new certificate should be stored in /etc/letsencrypt/live/[DOMAIN]/

## Useful links
Reg.ru Api Doc https://www.reg.ru/reseller/api2doc
