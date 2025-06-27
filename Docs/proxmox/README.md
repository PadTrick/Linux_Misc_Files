# Proxmox Installation auf Debian 12

### **1. Anleitung für Hetzner-Server (feste IP: 162.55.3.163)**
#### **Schritt 1: Proxmox installieren**
```bash
apt update && apt install curl -y
curl -o /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg http://download.proxmox.com/debian/proxmox-release-bookworm.gpg
echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
```

##### Falls kein Proxmox VE Enterprise Abonnement vorhanden ist, diese Zeile mit benutzen.
```bash
echo '# deb https://enterprise.proxmox.com/debian/pve bookworm InRelease' > /etc/apt/sources.list.d/pve-enterprise.list
```
##### Danach die Repos Updaten und die Pakete installieren.
```bash
apt update && apt full-upgrade -y
apt install proxmox-ve postfix open-iscsi
```

### **Server NEUSTARTEN**

#### **Schritt 2: Netzwerk konfigurieren (`/etc/network/interfaces`)**
```plaintext
auto lo
iface lo inet loopback

# Haupt-Interface (Hetzner-IP)
auto enp5s0
iface enp5s0 inet static
    address 162.55.3.163/26
    gateway 162.55.3.1
    up route add -net 162.55.3.0 netmask 255.255.255.192 gw 162.55.3.1 dev enp5s0

# Proxmox-Bridge für VMs (private IP)
auto vmbr0
iface vmbr0 inet static
    address 10.0.0.1/24 
    bridge_ports none
    bridge_stp off
    bridge_fd 0
```

#### **Schritt 3: NAT für VMs einrichten (Internet-Zugriff)**
```bash
# IPv4/IPv6-Weiterleitung dauerhaft aktivieren
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/' /etc/sysctl.conf
sysctl -p

# Firewall-NAT für IPv4 (Internet für VMs)
iptables -t nat -A POSTROUTING -s '10.0.0.0/24' -o enp5s0 -j MASQUERADE
apt install iptables-persistent -y
```

#### **Schritt 4: Dienste neu starten**
```bash
systemctl restart networking pve-cluster pveproxy
```

---

### **Schritt 1: DHCP-Server auf Proxmox einrichten (empfohlen)**  
Damit VMs automatisch IPs erhalten, installiere `dnsmasq` als DHCP-Server:  
```bash
apt install dnsmasq
```  

#### **Konfiguration (`/etc/dnsmasq.conf`)**  
```plaintext
interface=vmbr0
dhcp-range=10.0.0.100,10.0.0.200,255.255.255.0
dhcp-option=3,10.0.0.1 
dhcp-option=6,8.8.8.8 
```  
Starten:  
```bash
systemctl restart dnsmasq
```  

---

### **Schritt 2: Statische IP in der Gast-VM (Debian) setzen**  
Falls du **keinen DHCP-Server** nutzen möchtest, konfiguriere die VM manuell:  

#### **In der VM (`/etc/network/interfaces`)**  
Muss nicht zwingend editiert werden, es reicht auch erstmal nur im Installer des OS einzugeben und später manuell einzustellen.

```plaintext
auto ens18  # Name des VM-Netzwerkinterfaces (ggf. anpassen)
iface ens18 inet static
    address 10.0.0.2/24     # Beliebige IP im Subnetz
    gateway 10.0.0.1         # Proxmox-Bridge als Gateway
    dns-nameservers 8.8.8.8  # DNS-Server
```  
Anwenden:  
```bash
systemctl restart networking
```  

---

#### **Zugriff auf Proxmox:**
- Webinterface: `https://162.55.3.163:8006`
- Firewall-Regel im Hetzner Robot: Erlaube Port `8006`.

---

### **Bei Internet Problemen der VM (Proxmox-Host)**
```bash
# NAT & Forwarding
iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -o enp0s31f6 -s 10.0.0.0/24 -j MASQUERADE
iptables -A FORWARD -i vmbr0 -o enp0s31f6 -j ACCEPT
iptables -A FORWARD -i enp0s31f6 -o vmbr0 -m state --state RELATED,ESTABLISHED -j ACCEPT
echo 1 > /proc/sys/net/ipv4/ip_forward

# dnsmasq neustarten
systemctl restart dnsmasq
```

---

Bei Problemen mit dem Installer (zB bei Debian), während der Installation:
Im Proxmox Webinterface -> VM -> Hardware -> Network
- Network Adapter auf E1000 setzen
- Firewall deaktivieren.
Nach abgeschlossener Installation:
- Network Adapter auf VirtIO setzen
- Firewall aktivieren

---

### **Feste IPs für VMs nach der Installation einrichten**

Nachdem DHCP für die Erstinstallation funktioniert, können Sie feste IPs in den VMs vergeben. Hier ist die saubere Vorgehensweise:

---

#### **1. Feste IP in der VM konfigurieren (Debian/Ubuntu)**
In der VM (nach der Installation):
```bash
sudo nano /etc/network/interfaces
```
**Beispiel für feste IP 10.0.0.100/24:**
```bash
auto eth0
iface eth0 inet static
    address 10.0.0.100/24
    gateway 10.0.0.1
    dns-nameservers 8.8.8.8
```
**Anwenden:**
```bash
sudo systemctl restart networking
```

---

#### **2. DHCP-Reservation im Proxmox-Host (optional)**
Damit die VM immer dieselbe IP via DHCP erhält, bearbeiten Sie `/etc/dnsmasq.conf` auf dem Host:
```bash
dhcp-host=52:54:00:12:34:56,10.0.0.100  # MAC-Adresse der VM + gewünschte IP
```
**MAC-Adresse der VM finden:**
```bash
qm config <VM-ID> | grep net0
```

**Anwenden:**
```bash
systemctl restart dnsmasq
```

---

#### **3. Port-Weiterleitung für Services (Beispiel SSH)**
Auf dem **Proxmox-Host**:
```bash
# SSH (Port 22 der VM → Port 22100 auf dem Host)
iptables -t nat -A PREROUTING -p tcp --dport 22100 -j DNAT --to-destination 10.0.0.100:22
iptables -A FORWARD -p tcp -d 10.0.0.100 --dport 22 -j ACCEPT

# Oder für einen Webserver (Port 80 → 22101)
iptables -t nat -A PREROUTING -p tcp --dport 22101 -j DNAT --to-destination 10.0.0.100:80
iptables -A FORWARD -p tcp -d 10.0.0.100 --dport 80 -j ACCEPT
```

---

### **Empfohlene IP-Vergabe**
| **VM-Zweck**       | **IP**         | **Externe Ports**  |
|--------------------|----------------|--------------------|
| SSH-Server         | 10.0.0.100/24  | 22100 → 22         |
| Webserver          | 10.0.0.101/24  | 22101 → 80         |
| Datenbank          | 10.0.0.102/24  | (Nur intern)       |

---

### **Wichtig:**
1. **Firewall in der VM** anpassen (falls aktiv):
   ```bash
   sudo ufw allow 22/tcp  # Für SSH
   sudo ufw allow 80/tcp  # Für Webserver
   ```
2. **Regeln dauerhaft speichern** (Proxmox-Host):
   ```bash
   apt install iptables-persistent
   netfilter-persistent save
   ```