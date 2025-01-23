### **1. Skript mit `inotifywait`**
`inotifywait` ist Teil des Pakets `inotify-tools` und kann Änderungen in einem Verzeichnis überwachen und darauf reagieren.

#### **Schritte zur Einrichtung:**

1. **`inotify-tools` installieren:**
   Installieren Sie das Paket:
   ```bash
   sudo apt install inotify-tools
   ```

2. **Skript erstellen:**
   Erstellen Sie ein Bash-Skript, das das Quellverzeichnis überwacht und Änderungen synchronisiert:

   ```bash
   #!/bin/bash
    
   SOURCE="/home/padtrick/WebDev"
   TARGET="/var/www/html"
    
   # Funktion zur Synchronisierung von SOURCE nach TARGET
   sync_source_to_target() {
       rsync -av --delete "$SOURCE/" "$TARGET/"
       # Rechte im Zielverzeichnis anpassen
       chown -R www-data:www-data "$TARGET"
       chmod -R 755 "$TARGET"
   }
    
   # Funktion zur Synchronisierung von TARGET nach SOURCE
   sync_target_to_source() {
       rsync -av --delete "$TARGET/" "$SOURCE/"
       # Rechte im Quellverzeichnis beibehalten (hier: padtrick:padtrick)
       chown -R padtrick:padtrick "$SOURCE"
       chmod -R 755 "$SOURCE"
   }
    
   # Initiale Synchronisation
   sync_source_to_target
   sync_target_to_source
    
   # Überwachung starten
   inotifywait -m -r -e modify,create,delete,move "$SOURCE" "$TARGET" | while read -r path action file; do
       echo "Änderung erkannt: $action $file in $path"
       if [[ "$path" == "$SOURCE"* ]]; then
           echo "Synchronisiere $SOURCE -> $TARGET"
           sync_source_to_target
       elif [[ "$path" == "$TARGET"* ]]; then
           echo "Synchronisiere $TARGET -> $SOURCE"
           sync_target_to_source
       fi
   done
   ```

3. **Skript ausführbar machen:**
   Speichern Sie das Skript z. B. unter `/home/padtrick/sync_webdev.sh` und machen Sie es ausführbar:
   ```bash
   chmod +x /home/padtrick/sync_webdev.sh
   ```

4. **Skript starten:**
   Starten Sie das Skript im Hintergrund:
   ```bash
   nohup /home/padtrick/sync_webdev.sh &
   ```

5. **Automatischer Start beim Booten (optional):**
   Fügen Sie das Skript zu Ihrer Crontab hinzu:
   ```bash
   crontab -e
   ```
   Fügen Sie diese Zeile hinzu:
   ```bash
   @reboot /home/padtrick/sync_webdev.sh
   ```

---

### **2. Alternativer Ansatz: `rsync` mit Cron**
Falls keine Echtzeitüberwachung benötigt wird, können Sie `rsync` regelmäßig mit einem Cronjob ausführen.

#### **Schritte:**

1. **Rsync-Befehl testen:**
   Testen Sie den folgenden `rsync`-Befehl manuell:
   ```bash
   rsync -av --delete /home/padtrick/WebDev/ /var/www/html/
   chmod -R 755 /var/www/html
   chown -R www-data:www-data /var/www/html
   ```

2. **Cronjob einrichten:**
   Öffnen Sie die Crontab:
   ```bash
   crontab -e
   ```

   Fügen Sie den folgenden Cronjob hinzu, um das Verzeichnis alle 5 Minuten zu synchronisieren:
   ```bash
   */5 * * * * rsync -av --delete /home/padtrick/WebDev/ /var/www/html/ && chmod -R 755 /var/www/html && chown -R www-data:www-data /var/www/html
   ```

---

### **3. Erweiterung: Systemdienst für dauerhafte Überwachung**
Sie können das Bash-Skript als Systemdienst einrichten, um es professioneller zu gestalten.

#### **Dienstdatei erstellen:**
1. Erstellen Sie eine Systemd-Dienstdatei:
   ```bash
   sudo nano /etc/systemd/system/sync_webdev.service
   ```

2. Fügen Sie Folgendes ein:
   ```ini
   [Unit]
   Description=Synchronisiere WebDev mit Apache Document Root
   After=network.target
   
   [Service]
   ExecStart=/home/padtrick/sync_webdev.sh
   Restart=always
   User=root
   Group=root
   Environment=PATH=/usr/bin:/bin
   WorkingDirectory=/home/padtrick
   
   [Install]
   WantedBy=multi-user.target

   ```

3. Dienst starten und aktivieren:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable sync_webdev.service
   sudo systemctl start sync_webdev.service
   ```
