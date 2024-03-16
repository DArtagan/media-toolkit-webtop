FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

ENV FILEBOT_VERSION 5.1.3

# Many of these come from filebot's Dockerfile: https://github.com/filebot/filebot-docker/blob/master/Dockerfile
RUN apt-get update \
 && mkdir -p /usr/share/man/man1/ \
 # Filebot dependencies
 && apt-get install -y \
    atomicparsley \
    curl \
    default-jre \
    ffmpeg \
    file \
    inotify-tools \
    libchromaprint-tools \
    libjna-java \
    openjfx \
    mediainfo \
    mkvtoolnix \
    unrar \
    zenity \
 && curl -fsSL "https://raw.githubusercontent.com/filebot/plugins/master/gpg/maintainer.pub" | gpg --dearmor --output "/usr/share/keyrings/filebot.gpg" \
 && echo "deb [arch=all signed-by=/usr/share/keyrings/filebot.gpg] https://get.filebot.net/deb/ universal main" | tee "/etc/apt/sources.list.d/filebot.list" \
 && apt-get update \
 && apt-get install -y --install-recommends filebot=$FILEBOT_VERSION \
 # Other utilities
 && apt-get install -y \
    handbrake \
    i3 \
    i3-wm \
    thunar \
 && apt-get autoclean \
 && rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY root/ /
