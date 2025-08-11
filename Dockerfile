FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# ❶ 32bit ライブラリが本当に不要なら :i386 行を丸ごと削る
RUN apt-get update && apt-get install -y \
	git wget unzip ant openjdk-8-jdk openjdk-8-jre-headless \
	&& ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
	&& echo $TZ > /etc/timezone \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& rm -rf /var/lib/apt/lists/*

# ❷ i386 が必要なら ①→②→③ を１行で
# RUN dpkg --add-architecture i386 && \
#     apt-get update && \
#     apt-get install -y git wget unzip ant openjdk-8-jdk openjdk-8-jre-headless \
#       libc6:i386 libstdc++6:i386 libncurses5:i386 libbz2-1.0:i386 zlib1g:i386 && \
#     ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
#     echo $TZ > /etc/timezone && \
#     dpkg-reconfigure -f noninteractive tzdata && \
#     rm -rf /var/lib/apt/lists/*

# ❸ 以下はソース取得→ビルド→サーバ起動
RUN git clone --depth=1 https://github.com/naijo-akira/onemake.git /opt/ai2 \
	&& cd /opt/ai2 \
	&& git submodule update --init --recursive

WORKDIR /opt/ai2/appinventor
RUN ANT_OPTS="-Xmx2G" ant MakeAuthKey && \
	ANT_OPTS="-Xmx2G" ant  || true

ENV GAE_VER=1.9.98
RUN wget -q -O /tmp/gae.zip https://storage.googleapis.com/appengine-sdks/featured/appengine-java-sdk-${GAE_VER}.zip && \
	unzip /tmp/gae.zip -d /opt && rm /tmp/gae.zip
ENV PATH="/opt/appengine-java-sdk-${GAE_VER}/bin:${PATH}"
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

WORKDIR /opt/ai2/appinventor
EXPOSE 8888
ENTRYPOINT ["/opt/appengine-java-sdk-1.9.98/bin/dev_appserver.sh"]
CMD ["--port=8888","--address=0.0.0.0","appengine/build/war/"]
