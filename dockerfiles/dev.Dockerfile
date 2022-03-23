# Remeber to run it from the root of the project
# docker build --rm --tag ins_fhir_pkg_img -f dockerfiles/dev.Dockerfile .
# docker run --rm -it --name ins_fhir_pkg_container ins_fhir_pkg_img
# docker exec -it ins_fhir_pkg_container bash

FROM ubuntu:18.04 as start_image

ARG dockerfile_dir=dockerfiles

RUN apt update && \
    apt-get -y install software-properties-common && \
    add-apt-repository -y ppa:git-core/ppa

RUN apt update && apt install -y curl git nano jq

FROM start_image as set_up_asdf

WORKDIR /root

RUN git clone https://github.com/asdf-vm/asdf.git ./.asdf --branch v0.9.0
COPY ${dockerfile_dir}/asdf_bashrc.sh ./
RUN cat asdf_bashrc.sh >> ~/.bashrc
RUN ["/bin/bash", "-c", "-i", "asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git && asdf install dotnet-core 3.1.417 && asdf global dotnet-core 3.1.417"]
RUN ["/bin/bash", "-c", "-i", "dotnet tool install -g firely.terminal"]
COPY ./install_fhir_packages.sh ./
RUN chmod u+x ./install_fhir_packages.sh
