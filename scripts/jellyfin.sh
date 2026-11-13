docker stop jellyfin
docker rm jellyfin
docker run -d \
  --name=jellyfin \
  --net=host \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e JELLYFIN_PublishedServerUrl="http://$(ip route get 1.1.1.1 | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}'):8096" \
  -v /home/ronnas/Videos/jellyfin-server/config:/config \
  -v /home/ronnas/Videos/plex-server/filmes:/filmes \
  -v /home/ronnas/Videos/plex-server/animes:/animes \
  -v /home/ronnas/Videos/plex-server/series:/series \
  --restart unless-stopped \
  lscr.io/linuxserver/jellyfin:latest
sleep 5
xdg-open http://localhost:8096/
