FROM napolitano/centos-jre8

MAINTAINER Axel Napolitano <docker.2015@skjt.de>

ENV TEAMCITY_VERSION 9.1

VOLUME ["/var/lib/teamcity"]

RUN mkdir -p /var/lib/teamcity
RUN groupadd -g 999 teamcity
RUN useradd -u 999 -g teamcity -d /var/lib/teamcity teamcity
RUN chown -R teamcity:teamcity /var/lib/teamcity
RUN chmod -R u+rwx /var/lib/teamcity
RUN yum -y install wget
RUN wget http://download.jetbrains.com/teamcity/TeamCity-$TEAMCITY_VERSION.tar.gz
RUN echo "4fb84758df13126f79f0a9f42aa662569f5454e2c0457e40c9f42882a036e9a7	*TeamCity-$TEAMCITY_VERSION.tar.gz" >> SHA256SUM
RUN sha256sum -c SHA256SUM
RUN rm -f SHA256SUM
RUN ls -la
RUN mv TeamCity-$TEAMCITY_VERSION.tar.gz /opt
RUN pushd /opt && tar -xvzf TeamCity-$TEAMCITY_VERSION.tar.gz && popd
RUN yum -y remove wget
RUN chown -R teamcity:teamcity /opt/TeamCity

USER teamcity

EXPOSE 8111

CMD ["/opt/TeamCity/bin/teamcity-server.sh", "run"]