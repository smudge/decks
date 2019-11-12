# Pow in a Nutshell

### (also puma-dev)

#### Nathan Griffith

---

### What is Pow?

#### myapp.test -> actual app

---

### What is Pow?

- DNS Resolution (myapp.test -> localhost)
- Port Mapping (HTTP port 80 -> myapp port 3456)
- App Discovery (~/.pow/myapp -> ~/src/myapp)
- Process Management (Booting "myapp" on port 3456)

---

### DNS

- /etc/hosts (no)
- /etc/resolvers/test (yup!)

---

### DNS Resolver

dscacheutil -q host -a name myapp.test

???

dscacheutil -flushcache

---

### App Discovery

```
$ cd ~/.pow
$ ln -s ~/src/myapp
```

---

### Port Mapping

#### 80 -> 3000

- Firewall rules
- Launch Daemon "Socket"

???

echo "rdr pass on lo0 inet proto tcp from any to any port 80 -> 127.0.0.1 port 8080" | sudo pfctl -a 'com.apple/250.InvokerFirewall' -f - -E

---

### Process Manager

#### bundle exec rackup -p 3000

- Launch if not running
- Quit after inactivity

---

# Demo Time!

- dscacheutil -q host -a name cerberus.test
- echo "rdr pass on lo0 inet proto tcp from any to any port 80 -> 127.0.0.1 port 8080" | sudo pfctl -a 'com.apple/250.InvokerFirewall' -f - -E
