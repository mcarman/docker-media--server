## my personal basic media server

or my attempts to run a media server (one of various flavors) in docker for arm 64 bit machines. Why? My brother has been buying movies on disc for 20 years. He decided to rip them to a hard drive. 

This is a front end for about 550 movies that he purchased over the years. 

This media server is plex based with:

- plex aids:
     - tautulli
     - plex meta manager (TBD)
- frontends
     - heindall
     - dashy
- Orchestration
     - Portainer
- logging
     - Dozzle
- file hharing (no smb1)
     - samba
     - wsdd
     - avahi
- network tools
     - smokeping
- music and podcasts
     - airsonic 
     - musicbrains (tbd)
- utilities
     - watchtower
- maybe some day
     - traefik
     - syncthing
     - monitoring stack (grafana/prometheus or influxdb)
     - webtools NG
     - tiny media manager (they charge now. y estoy muy codo)


A second stack with the arrs is in process. (built on top of this stack).  

Everything here is pretty basic, cadged from github and aother places. Heimdall is the main interface. Heimdall is clean, easy to impliment, and almost impossible to screw up. From heimdall you can jump to dashy wich has more toys to play with. I have only scratched the surface of dashy. I like it. I can mix web tools and server apps and scripts in one interface. I am not wild about the themes, but that is a quibble. 

Plex vs. kodi vs. jelly. The others are good. I started with minidlna. I loved minidlna. but it lacked the bells and whistles that my users wanted. Wirh plex meta manager (still giving n=me issues) and Plex you can build a nice interface with links to info about the movie, actors, etc. I makes browsing and movie selection easier.  

Plex is a pain in some ways, but getting basic lowend cable channels for $5 a month can not be overlooked. No more Hulu/youtube or Netflix. I am down to amazon prime, plex, and Disney/ESPN. If I allocate half of amazon prime subscription fee to media, my total is about 82. Any time you can get it under 100, great. 

samba is a blackhole of energy. Please tell nme someone has a slick, light weight equivalent that does not torture people with mixed networks (linux, mac, windoews).I spent as much time on samba as I did on all the other containers combined. 

Hardware: Mostly Pi4B with 4 GB of RAM, swap was disabled in favor of zfs. I will add my primary sources at the bottom of this file someday. The standard pi config and command line changes have been made. The Pis are wired to the network. I disabled bt and wifi do free up osme resources, to the point of taking them out to the kernal. It frees up a tiny bit of resources. 

Eventually, I want to compile the apps atively on the pi. This may be a bit of a stretch. The literature says a 10% performance boost with native compilation. That might give me enough juice to get after the video/sound sync that occasionally pops up. Docker also provides some interesting options, where you can have a container that spits ot a binary that can be incorporated into the build.  

I have tried ti integrate trafik into the mix, with limited sucess. 

If you have not guessed by now, I am not a computer scientist. I am a scientist, molecular biologist. I am working on AI/bio interfaces. Old fashioned stuff, like building out a knowledge base for ALzheimers where papers are combined to generate a synthesis of the topic with probability estimates of the 'truthiness' of each node. Maybe some new relationships may opo up. Slow going. 

