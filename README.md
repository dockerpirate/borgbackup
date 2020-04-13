## NOOB programmed this container, be careful

Fork of rhabbachi/docker-borgbackup 

```
$ docker run -d --name 'borgserver' \
  --network host \
  -v "$HOME/.ssh:/home/borg/.ssh" \
  -v "<path/to/backups/root/folder/>:/backups" \
  -v "</config>:/etc/periodic/" \
  --restart unless-stopped \
  dockerpirate/borgbackup
```
```
 -v "$HOME/log:/tmp/" (optionaly for logs)
```

borg_auto is a script to run borg, change parameters like USER, SERVER, REPOSITORY. Extend /backups folders if needed.
Put in folder /.ssh your key without password to acces remote server.

## On Client ($HOME/.ssh)
```
sudo ssh-keygen -a 100 -t ed25519
Enter file in which to save the key (/home/$USER/.ssh/id_ed25519): /home/$USER/.ssh/borgbackup
2x press enter (without password)
```

## Troubleshooting:
First time you have to run in container "borg_auto" manually, because to do some interactive commands.

```
docker exec -it borgbackup /bin/sh
sh /etc/periodic/hourly/borg_auto
and follow instruction
```
