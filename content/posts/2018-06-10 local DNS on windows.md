---
title: Local DNS on windows - when "nslookup" works but "ping" fails
slug: local-dns-on-windows-nslookup-ping
type: post
date: 2018-06-10
---

After upgrading my router I somehow managed to break DNS name resolution on local network, but, obviously, only for Windows machines. After some trial and error, I managed to find relevant DHCP settings on my WRT3200ACM: IP reservation also allows to edit host name for that IP.

So, first part is done, DNS works:

```text
> nslookup ngst-osx
Server:  Linksys01640
Address:  192.168.1.1

Name:    ngst-osx
Address:  192.168.1.138
```

But next part is disappointing:

```text
> ping ngst-osx
Ping request could not find host ngst-osx. Please check the name and try again
```

How can this be? `nslookup` can definitely resolve the IP, so DNS works. After some googling around seems like the trick is to suffix it with a dot to make Windows host name resolution use DNS as the method.


```text

> ping ngst-osx.

Pinging ngst-osx [192.168.1.138] with 32 bytes of data:
Reply from 192.168.1.138: bytes=32 time=117ms TTL=64
Reply from 192.168.1.138: bytes=32 time=341ms TTL=64
```
