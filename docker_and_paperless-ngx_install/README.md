### **1. Debian 12 einrichten**

#### 1.1. Hinzufügen des Desktopusers zu den Sudoern
Nach der Installation, logge dich als `root` ein und füge den Desktopbenutzer zur Gruppe der `sudo`-Benutzer hinzu:
```bash
su -
sudo usermod -aG sudo <USERNAME>
```

#### 1.2. Aktivierung nicht freier Pakete
Füge die folgenden Repositories zu deiner `sources.list` hinzu/ändere vorhandene, um nicht freie Pakete wie `contrib`, `non-free` und `non-free-firmware` zu aktivieren:
```bash
# Editiere /etc/apt/sources.list und füge die folgenden Repositories hinzu/ändere vorhandene
deb http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main contrib non-free non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free non-free-firmware
```

#### 1.3. Update und 32-bit Unterstützung aktivieren
Aktualisiere die Paketliste und aktiviere die 32-bit Architektur (falls benötigt):
```bash
sudo apt update
sudo dpkg --add-architecture i386
```


### **2. Docker auf Debian 12 installieren**

#### **2.1 Vorbereitung: Paketquellen aktualisieren**
```bash
sudo apt update && sudo apt upgrade -y
```

#### **2.2 Erforderliche Abhängigkeiten installieren**
```bash
sudo apt install -y ca-certificates curl gnupg
```

#### **2.3 Offiziellen Docker GPG-Schlüssel hinzufügen** (überschreiben falls vorhanden)
```bash
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

#### **2.4 Docker-Repository zu Debian hinzufügen**
```bash
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

#### **2.5 Docker installieren**
```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

#### **2.6 Docker-Dienst starten & aktivieren**
```bash
sudo systemctl enable --now docker
```

#### **2.7 Benutzer zur Docker-Gruppe hinzufügen (optional, um Docker ohne `sudo` zu nutzen)**
```bash
sudo usermod -aG docker $USER
newgrp docker
```

#### **2.8 Test: Docker läuft?**
```bash
docker run hello-world
```
→ Wenn eine Willkommensnachricht erscheint, ist Docker korrekt installiert.


### **3. Offizielle Paperless-ngx Installation mit dem Installationsskript (Debian 12)**

#### **3.1. Voraussetzung: Docker ist installiert**
*(Falls noch nicht geschehen – siehe Schritt 2 der Anleitung oder:)*  
```bash
sudo apt update && sudo apt install -y curl
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
newgrp docker
```

#### **3.2. Installationsskript ausführen**
```bash
bash -c "$(curl --location --silent --show-error https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/install-paperless-ngx.sh)"
```
Das Skript führt automatisch folgende Schritte aus:
1. Erstellt ein Verzeichnis (standardmäßig `/home/<USERNAME>/paperless-ngx`).  
2. Lädt die aktuellen `docker-compose.yml` und `.env`-Dateien herunter.  
3. Startet Paperless-ngx mit Docker Compose.  

#### **3.3. Interaktive Konfiguration**
Das Skript fragt während der Installation:
- **Installationspfad** (Standard: `/home/<USERNAME>/paperless-ngx`).  
- **URL**: Hier muss zwingend http oder https vor der IP stehen.
- **Port** (Standard: `8000`).  
- **Database backend**: mariadb (hab nur das getestet)
- **OCR-Sprache** (z. B. `deu` für Deutsch, habe bei Tests das default Eng gelassen).  
- habe soweit alles einfach mit Enter belassen.
- **Media folder**: ./media 
- **Data folder**: ./data
- **Database folder**: ./database
- **Admin-Benutzername/Passwort** (für die Weboberfläche). **WICHTIG**: Passwort muss mindest 8 Zeichenlang sein, ansonsten wird man beim aufrufen des Webinterfaces aufgefordert einen Adminaccount anzulegen.

#### **3.4. Abschluss**
Nach erfolgreicher Installation:
- Paperless-ngx läuft unter: **`http://<deine-server-ip>:8000`**
- Sollte der Paperless-ngx Container nicht laufen:
```bash
cd ~/paperless-ngx
docker compose up -d
```
- Die Konfigurationsdateien liegen im gewählten Installationspfad (z. B. `/home/<USERNAME>/paperless-ngx>`).  
