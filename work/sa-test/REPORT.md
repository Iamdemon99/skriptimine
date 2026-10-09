# Arvestustöö raport

- **Nimi:** Eesnimi Perekonnanimi
- **Variant:** A
- **Kuupäev:** 09.10.2026

---

## Probleem 1
- **Skript:** `scripts/system_info.sh`
- **Mida skript näiliselt tegi:** Kuvas süsteemi üldinfot.
- **Mis oli tegelikult vale:** Väljad olid vahetuses (hostname vs whoami, uname -m vs uname -r, date vs uptime, Swap vs Mem).
- **Kuidas vea avastasin:** Kontrollisin käske terminalis eraldi.
- **Millise käsuga kontrollisin:** `hostname`, `whoami`, `uname -r`, `free -m`
- **Parandus:** Asendati käsud õigetega (`hostname`, `whoami`, `uname -r`, `uptime -p`, `/Mem:/`).
- **Kuidas kontrollisin pärast parandust:** Käivitasin `bash scripts/system_info.sh`.

## Probleem 2
- **Skript:** `scripts/disk_check.sh`
- **Mida skript näiliselt tegi:** Kontrollis kettakasutuse protsenti.
- **Mis oli tegelikult vale:** `df -h /` 4. veerg on vaba ruum (Avail), mitte kasutuse protsent (Use%).
- **Kuidas vea avastasin:** Vaatasin `df -h /` väljundit.
- **Millise käsuga kontrollisin:** `df -h / | awk '{print $5}'`
- **Parandus:** Muudeti awk veerg 5-ks (`$5`), eemaldati `%` märk ja parandati võrdlus `-le`.
- **Kuidas kontrollisin pärast parandust:** Käivitasin skripti ja vaatasin väljundit.

## Probleem 3
- **Skript:** `scripts/service_check.sh`
- **Mida skript näiliselt tegi:** Kontrollis, kas teenus töötab.
- **Mis oli tegelikult vale:** `systemctl list-unit-files` kontrollib vaid faili olemasolu kettal, mitte teenuse töötamist.
- **Kuidas vea avastasin:** Vaatasin `systemctl list-unit-files` käitumist.
- **Millise käsuga kontrollisin:** `systemctl is-active <teenus>`
- **Parandus:** Kasutati käsku `systemctl is-active --quiet "$service"`.
- **Kuidas kontrollisin pärast parandust:** Testisin töötava ja mittetöötava teenusega.

## Probleem 4
- **Skript:** `scripts/user_check.sh`
- **Mida skript näiliselt tegi:** Kontrollis kasutaja olemasolu.
- **Mis oli tegelikult vale:** Otsiti `/etc/group` failist, kus on grupid, mitte kasutajad.
- **Kuidas vea avastasin:** Vaatasin koodis faili teed.
- **Millise käsuga kontrollisin:** `id <kasutaja>`
- **Parandus:** Asendati otsing käsuga `id "$username" &>/devnull`.
- **Kuidas kontrollisin pärast parandust:** Testisin olemasoleva ja olematu kasutajaga.

## Probleem 5
- **Skript:** `scripts/user_check.sh`
- **Mida skript näiliselt tegi:** Kontrollis otsingu tulemust.
- **Mis oli tegelikult vale:** Tingimus `[ "$matches" -ge 0 ]` oli alati tõene (`grep -c` annab alati >= 0).
- **Kuidas vea avastasin:** Kontrollisin `if` loogikat.
- **Millise käsuga kontrollisin:** `grep -c "olematu" /etc/group`
- **Parandus:** Kontrollitakse otse käsu `id` tagastuskoodi.
- **Kuidas kontrollisin pärast parandust:** Veendusin, et olematu kasutaja annab vea.

## Probleem 6
- **Skript:** `scripts/backup.sh`
- **Mida skript näiliselt tegi:** Loos `.tar.gz` varukoopia.
- **Mis oli tegelikult vale:** Käsuga `find ... > "$ARCHIVE"` kirjutati arhiivifaili sisse vaid teksti kujul nimekiri.
- **Kuidas vea avastasin:** Vaatasin loodud arhiivi sisu.
- **Millise käsuga kontrollisin:** `tar -tzf backup_*.tar.gz`
- **Parandus:** Asendati tegeliku pakkimiskäsuga `tar -czf "$ARCHIVE" -C "$BACKUP_SOURCE" .`.
- **Kuidas kontrollisin pärast parandust:** Kontrollisin arhiivi sisu käsuga `tar -tzf`.

---

## Uus funktsionaalsus
- **Mida lisasin:** Logifailide vaatamise skript `scripts/view_logs.sh` ning täiendasin pea-menüüd `main.sh`.
- **Kuidas käivitada:** Käivita `main.sh` ja vali `6`.
- **Kuidas kontrollisin, et tulemus on õige:** Veendusin logifaili viimase 10 rea kuva õigsuses.

---

## Probleemide lühikokkuvõte
- **system_info.sh:** Väljad ja käsud olid vahetuses (kuvas RAM-i asemel Swap-mälu ning uptime'i asemel kuupäeva).
- **disk_check.sh:** Luges `df` käsu 4. veerust vaba ruumi mahtu, mitte 5. veerust tegelikku kasutusprotsenti.
- **service_check.sh:** Kontrollis vaid teenuse faili olemasolu kettal (`list-unit-files`), mitte seda, kas teenus reaalselt töötab (`is-active`).
- **user_check.sh (asukoht):** Otsis kasutajat failist `/etc/group`, mis sisaldab gruppe, mitte kasutajad.
- **user_check.sh (loogika):** Kontrollis tingimust `>= 0`, mis oli alati tõene, sest `grep -c` tagastab alati vähemalt nulli.
- **backup.sh:** Suunas `find` käsu väljundi otse faili, tekitades `.tar.gz` nimega tavalise tekstifaili, mitte tegelikku pakitud arhiivi.
