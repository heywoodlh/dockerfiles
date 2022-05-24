This is an unofficial, multiarch build of the Metasploit Framework using [the Omnibus installer](https://github.com/rapid7/metasploit-omnibus).

The Dockerfile for this image is here: https://github.com/heywoodlh/dockerfiles/blob/master/metasploit/Dockerfile

The Github Action to build this image is here: https://github.com/heywoodlh/actions/blob/master/.github/workflows/metasploit-buildx.yml

## Usage: 

Here are some example aliases you could use with a POSIX compliant shell (BASH, ZSH, etc.):

```
alias msfconsole='mkdir -p ~/.local/metasploit && docker run -it --rm --net host -v ~/.local/metasploit/:/root/.msf4 -w /root/session -v $(pwd):/root/session heywoodlh/metasploit msfconsole $@'
alias msfvenom='mkdir -p ~/.local/metasploit && docker run -it --rm -v ~/.local/metasploit/:/root/.msf4 -w /root/session -v $(pwd):/root/session heywoodlh/metasploit msfvenom $@'
```

A very simple `docker-compose.yml` file is available here: https://github.com/heywoodlh/dockerfiles/blob/master/metasploit/docker-compose.yml

## Issues:

If issues are encountered with this image [feel free to open an issue](https://github.com/heywoodlh/dockerfiles/issues/new).
