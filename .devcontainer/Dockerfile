FROM ubuntu:focal

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update && \
	apt-get install -y sudo && \
	apt-get install -y software-properties-common --no-install-recommends

RUN apt-get install -y git curl unzip && \
	# add-apt-repository ppa:deadsnakes/ppa && \
	# apt-get update && \
	# apt-get install -y wget curl git python3.10 python3-distutils gpg-agent unzip xz-utils zip libglu1-mesa --no-install-recommends && \
	# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
	# python3 get-pip.py && \
	# pip install jupyterlab pylint pycodestyle autopep8 && \
    git clone https://github.com/flutter/flutter.git -b stable --depth 1

ENV PATH "$PATH:/flutter/bin"

RUN flutter config --no-analytics --enable-web && \
    flutter precache --no-android && \
	flutter doctor

# RUN rm get-pip.py && \
# 	apt-get autoremove -y && \
# 	apt-get clean -y && \
# 	rm -rf /var/lib/apt/lists/*

RUN groupadd --gid $USER_GID $USERNAME && \
	useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME && \
	echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
	chmod 0440 /etc/sudoers.d/$USERNAME && \
	chown -R $USERNAME /flutter/ && \
	chown -R $USERNAME /root/
