#syntax=docker/dockerfile:1
# Set the ubuntu filesystem
FROM debian
# Expose port 80 and port 4242
EXPOSE 80
EXPOSE 4242
# Update & upgrade OS packages
RUN apt update &&\
	apt -y upgrade
# Install nginx and remove temp instalation files
RUN apt install -y nginx &&\
apt install -y openssh-server &&\
apt install -y tor
# Copy my custom config files
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/
COPY torrc /etc/tor/torrc
COPY sshd_config /etc/ssh/sshd_config

RUN cd /etc/ssh && ssh-keygen -f user_ca
RUN scp ~/.ssh/id_rsa_cterrasid.pub root@ft_onion:/etc/ssh/
RUN ssh-keygen -s user_ca -I user_cterrasid -n cterrasid,root -V +52w id_rsa_cterrasid.pub
RUN scp root@ft_onion:/etc/ssh/id_rsa_cterrasid-cert.pub ~/.ssh/
RUN ssh -i ~/id_rsa_cterrasid-cert.pub root@ft_onion

ENTRYPOINT nginx; service ssh start ; tor;
# Command, IDK
CMD ["nginx", "-g", "daemon off;"]
