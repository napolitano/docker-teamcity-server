# JetBrains TeamCity 9.1 Docker Container

This container allows you to run TeamCity CI Version 9.1 from JetBrains easily. It is based on a Centos 7 / Oracle JRE 8.

You can find the container on docker hub:
https://registry.hub.docker.com/u/napolitano/docker-teamcity-server/

## Usage

If you want to test or evaluate TeamCity it is most convenient to use Kitematic, the GUI tool for docker. This can be found here: http://kitematic.com.

For production use it really depends on your requirements. The easiest way would be to start the container and use it with preset configuration and integrated database. 

    docker run -dt --name teamcity-server -p 8111:8111 napolitano/docker-teamcity-server

However you may want more performance, better scalability and reliability - in this case you need an additional database (e.g. postgres) and an external data store. 

While this is individual and may be different from user to user you may want to use docker hub to find suitable containers for your purposes.

## Build Agents

While there exist a lot of containers with build agents, they share all the same limitation: Linux only. However you can easily install and use build agents on all major platforms as long as they support java and at least JRE was installed and configured.

## Mac OS

If you want to run this container on Mac OS you might need to install boot2docker (https://github.com/boot2docker/osx-installer/releases/tag/v1.7.1)

### Build iOS Apps on OS-X

Building iOS Apps with TeamCity is relatively easy. You need the following ingredients.

- Apple Mac running OS-X
- XCode installed (including cli-Tools)
- Apple Developer Membership
- Certificates and Provisioning Profiles on your maschine
- Build agent installed

The only pitfall is, that provisioning profiles and certificates must be installed for the system user. Provisioning profiles can be found at "/Users/<username>/Library/MobileDevice/Provisioning Profiles - copy them to System/Library/MobileDevice/Provisioning Profiles (Create folders that do not exist)
