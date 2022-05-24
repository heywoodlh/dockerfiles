## msfbox

This Docker image allows a user to access Metasploit in a web browser or via SSH.


## Usage:

```bash
docker run -d --name msfbox \
	&& -p 4200:4200 \ # Web port
	&& -p 2022:22 \ # SSH port
	heywoodlh/msfbox 
```

If you choose to SSH into the container, the default credentials are `msfbox:msfbox`.
