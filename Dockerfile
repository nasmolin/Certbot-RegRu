# --------------------------------
# base image from docker registry
# --------------------------------
FROM mirror.gcr.io/alpine:latest

# --------------------------------
# ansible-core and dependencies install
# --------------------------------
RUN apk add \
    ansible-core \
    sshpass \
    py3-netaddr \
    openssh-client \
    ansible-lint && \
    rm -rf /var/cache/apk/*

# collections install
RUN ansible-galaxy collection install community.zabbix:==2.4.0

# --------------------------------
# hosts file and ansible.cfg default location is /etc/ansible/
# --------------------------------
COPY configs/ /etc/ansible/

# --------------------------------
# copy playbooks dir to workdir
# --------------------------------
COPY playbooks /Ansible
WORKDIR /Ansible

CMD ["/bin/sh"]

