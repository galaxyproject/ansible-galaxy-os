FROM toolshed/requirements

RUN apt-get -qq update && apt-get install --no-install-recommends -y apt-transport-https  software-properties-common && \
    apt-add-repository -y ppa:ansible/ansible && \
    apt-get -qq update && \
    apt-get -qq install ansible && \
    apt-get purge -y software-properties-common

RUN mkdir /tmp/ansible
WORKDIR /tmp/ansible
ADD . /tmp/ansible
RUN ansible-playbook -i localhost, local.yml \
    -e "@defaults/main.yml" \
    -e "install_maintenance_packages=false" \
    -e "postgres_user_uid=1550" \
    -e "postgres_user_gid=1550" \
    -e "galaxy_user_uid=1450" \
    -e "galaxy_user_gid=1450"
