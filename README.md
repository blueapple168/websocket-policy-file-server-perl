# Setting Up A Flash Socket Policy File

Flash Player 9 (version 9.0.124.0 and above) implemented a strict new access policy for Flash applications (such as chat clients or games) that make Socket or XMLSocket connections to a remote host. It now requires the presence of a socket policy file on the server. (This means you need to have control of the server in order to implement these changes. If you've written a flash app that makes a connection to a server you don't own, you're out of luck, unless that server sets up their own socket policy.)

In earlier versions of Flash Player, if the server didn't have a socket policy, your Flash application could still connect. Now if there's no policy, your application will not connect.

When the Flash Player tries to make a connection, it checks in two places for the socket policy:

Port 843. If you are the administrator of a webserver and you have root access, you can set up an application to listen on this port and return a server-wide socket policy.
The destination port. If you're running your own xml server, you can configure it to send the socket policy file.
The Flash player always tries port 843 first; if there's no response after 3 seconds, then it tries the destination port.

In either case, when the Flash player makes a connection, it sends the following XML string to the server:

<policy-file-request/>
Your server then must send the following XML in reply:
```
<cross-domain-policy>
     <allow-access-from domain="*" to-ports="*" />
</cross-domain-policy>
```
* is the wildcard and means "all ports/domains". If you want to restrict access to a particular port, enter the port number, or a list or range of numbers.

Since the Flash Player always tries port 843 first, if there's nothing listening on that port, then the Flash clients are going to experience a 3-second delay when trying to connect to your server. Even if you set up a policy file on the destination port, there will still be the delay. For fastest response times, you should set up a server-wide socket policy server on port 843.

A Simple XML Server For Your Socket Policy File
I've written a simple Perl socket server that will listen on port 843 and return a global socket policy file. The source code is available below.

socketpolicy.pl [View Source](http://www.lightsphere.com/dev/articles/socketpolicy.pl.html)

socketpolicy.tar.gz [download](http://www.lightsphere.com/dev/articles/socketpolicy.tar.gz)

To start the server (on a unix host), you'll need to su to root and then run the following:
```
./socketpolicy.pl > /dev/null &
```
Since you want the server to run all the time (even after a reboot), you should also add it to your rc.local file.

What about crossdomain.xml?
The crossdomain.xml file affects HTTP, HTTPS and FTP access to content on your webserver. This file has no effect on socket connections. You must set up a socket policy server to allow Flash-based socket access.

What About secure="true"?
You don't have to specify the secure="true" or secure="false" option (although you may, if you want to require secure connections).

Adobe recommends against using the secure="true" directive in socket policy files that are not served from local sockets (i.e., from socket servers running on the same computer as Flash Player). Flash Player will generate warnings in the policy file log if it finds secure="true" in a socket policy file that does not appear to have come from the local host. Flash Player will in fact honor secure="true" in non-local socket policy files, but only because it is not possible for Flash Player to detect with 100% reliability whether a socket connection is to the local host or not.

## Additional Resources
##### [Apache module for Policy File](http://www.beamartyr.net/articles/adobepolicyfileserver.html)
##### Adobe: [Setting up a socket policy file server](http://www.adobe.com/devnet/flashplayer/articles/socket_policy_files.edu.html)

## Other Issue Flash Player doesn't connect to socket policy file server - gives SecurityError #2048 ...
There was a global configuration file mms.cfg on the machine that set DisableSockets=1. This casued the SecurityError and prevented Flash Player from connecting to the policy file server. Set it to 0 (which is the default) and everything worked. For details on this file, see [flash_player_admin_guide (http://www.adobe.com/content/dam/Adobe/en/devnet/flash/articles/flash_player_admin_guide/flash_player_admin_guide.pdf) Chapter 4.

