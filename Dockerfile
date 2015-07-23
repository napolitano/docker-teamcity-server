FROM napolitano/docker-centos7-jre8

MAINTAINER Axel Napolitano <docker.2015@skjt.de>

VOLUME ["/var/lib/teamcity"]

ENV TEAMCITY_VERSION 9.1
ENV TEAMCITY_SERVER_MEM_OPTS -Xmx750m -XX:MaxPermSize=270m
ENV TEAMCITY_DATA_PATH /var/lib/teamcity

RUN mkdir -p /var/lib/teamcity && \
	groupadd -g 999 teamcity && \
	useradd -u 999 -g teamcity -d /var/lib/teamcity teamcity && \
	chown -R teamcity:teamcity /var/lib/teamcity && \
	chmod -R ug+rwx /var/lib/teamcity && \
	yum -y install wget && \
	wget http://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.tar.gz && \
	echo "4fb84758df13126f79f0a9f42aa662569f5454e2c0457e40c9f42882a036e9a7	*TeamCity-$TEAMCITY_VERSION.tar.gz" >> SHA256SUM && \
	sha256sum -c SHA256SUM && \
	rm -f SHA256SUM && \
	tar -xvzf TeamCity-$TEAMCITY_VERSION.tar.gz && \
	rm -f TeamCity-$TEAMCITY_VERSION.tar.gz && \
	yum -y remove wget && \
	chown -R teamcity:teamcity TeamCity

USER teamcity

EXPOSE 8111

CMD ["./TeamCity/bin/teamcity-server.sh", "run"