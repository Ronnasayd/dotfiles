docker stop plex
docker rm plex
docker run -d \
  --name=plex \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e VERSION=docker \
  -v /home/ronnas/Videos/plex-server/config:/config \
  -v /home/ronnas/Videos/plex-server/filmes:/filmes \
  -v /home/ronnas/Videos/plex-server/animes:/animes \
  -v /home/ronnas/Videos/plex-server/series:/series \
  --restart unless-stopped \
  lscr.io/linuxserver/plex:latest
sleep 5
xdg-open http://localhost:32400/web/
