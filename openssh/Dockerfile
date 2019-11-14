FROM archlinux

RUN pacman -Sy --noconfirm openssh
RUN passwd -l root

RUN useradd -ms /bin/bash ssh-user
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g' /etc/ssh/sshd_config
RUN passwd -l ssh-user

EXPOSE 22
CMD ["/usr/bin/sshd", "-D", "-h", "/etc/ssh/ssh_host_rsa_key"]
