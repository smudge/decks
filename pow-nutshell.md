# Pow in a Nutshell
#### By me (smudge)

--
### (also puma-dev in a nutshell)

--

### (also "project cerberus")


---

### What is Pow?

#### http://cerberus.test -> actual app

--
- DNS Resolution
> cerberus.test -> localhost

--
- Port Mapping
> HTTP port 80 -> your app port 3456  
> HTTPS port 443 -> TLS proxy -> your app port 3456

--
- App Discovery
> ~/.pow/cerberus -> ~/src/cerberus

--
- Process Management
> Booting "cerberus" on port 3456  

---

### DNS Resolution

## /etc/hosts

This works:

```
127.0.0.1	localhost
127.0.0.1	cerberus.test
```
--
But not this:

```
127.0.0.1	*.test
```

---

### DNS Resolution

## /etc/resolver/test

This works for `*.test`!

```
nameserver 127.0.0.1
port 9253
```

...but now we need a DNS resolver!

---

### DNS Resolution

```
$ dscacheutil -q host -a name google.com
name: google.com
ipv6_address: 2607:f8b0:4004:815::200e

name: google.com
ip_address: 172.217.164.174
```
---

### DNS Resolution

```
0x0000   4500 0082 d9eb 0000 3a11 f873 c0a8 01c8        E.......:..s..e.
0x0010   c0a8 0164 0035 0268 006e ba41 ea1a 8183        .....5.h.n.A....
0x0020   0001 0000 0001 0000 0133 0234 3503 3139        .........3.45.19
0x0030   3103 3230 3605 646e 7362 6c05 736f 7262        1.206.dnsbl.sorb
0x0040   7303 6e65 7400 0001 0001 c019 0006 0001        s.net...........
0x0050   0000 0e10 002c 0772 626c 646e 7330 c01f        .....,.rbldns0..
0x0060   0364 6e73 0469 7375 7803 636f 6d00 431c        .dns.isux.com.C.
0x0070   e07e 0000 1c20 0000 1c20 0009 3a80 0000        .~..........:...
```
--
So we need a new process:
- Listens on a localhost port (e.g. 9253)
- Parses DNS queries from a series of bytes
- Replies with answers

--
- More on this later!

---

### App Discovery

```
$ cd ~/.pow
$ ln -s ~/src/cerberus
```

---

### Port Mapping

#### 80 -> 3000

- Firewall rule (pow)
```
echo "rdr pass on lo0 inet proto tcp from any to any port 80 -> 127.0.0.1 port 3000" |
sudo pfctl -a 'com.apple/250.InvokerFirewall' -f - -E
```
--

- Launch Daemon -> Unix Socket (puma-dev)

```
$ launchctl load ~/Library/LaunchAgents/io.puma.dev.plist
```

```xml
...
<key>KeepAlive</key>
<true/>
<key>RunAtLoad</key>
<true/>
<key>Sockets</key>
<dict>
  <key>Socket</key>
  <dict>
    <key>SockNodeName</key>
    <string>0.0.0.0</string>
    <key>SockServiceName</key>
    <string>80</string>
  </dict>
</dict>
...
```
---

### Process Manager

#### bundle exec rackup -p 3000

- Launch if not running
- Quit after inactivity

---

# Demo Time!

```
$ cat /etc/resolver/test
$ dscacheutil -flushcache
$ dscacheutil -q host -a name cerberus.test
$ ./pow-nutshell/cerberus --serve
$ echo "rdr pass on lo0 inet proto tcp from any to any port 80 -> 127.0.0.1 port 7878" |
sudo pfctl -a 'com.apple/250.InvokerFirewall' -f - -E
```

???

Speaker note: /etc/resolver/test should already contain this content:
```
nameserver 127.0.0.1
port 9253
```
