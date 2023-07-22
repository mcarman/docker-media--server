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

Everything here is pretty basic, cadged from github and other places. Heimdall is the initial interface. Heimdall is clean, easy to impliment, and almost impossible to screw up. From heimdall you can jump to dashy which has more toys to play with. I have only scratched the surface of dashy. I like it. I can mix web tools and server apps and scripts in one interface. I am not wild about the themes, but that is a quibble. 

Plex vs. kodi vs. jelly. I went with plex. The others are good. I started with minidlna and loved minidlna. But it lacked the bells and whistles that my users wanted. With plex meta manager (still giving me issues) and Plex you can build a nice interface with links to info about the movie, actors, etc. It makes browsing and movie selection easier.  

Plex is a pain in some ways, but getting basic cable channels for $5 a month can not be overlooked. No more hulu/youtube or Netflix. I am down to amazon prime, plex, and Disney/ESPN. If I allocate half of my amazon prime subscription fee to media, my total is about $82/mo. Any time you can get it under 100, great. 

IPTV is something that should be considered.n Endless paasword and access issues coupled with clunky payment systems has made this a back burner issue.

samba is a blackhole of energy. Please tell me someone has a slick, light weight equivalent that does not torture people with mixed networks (linux, mac, windoews) access issues. I spent as much time on samba as I did on all the other containers combined. And I am still not thrilled. I used tini to keep samba up and running.  

Hardware: Mostly Pi4B with 4 GB of RAM and booted off of a USB 3.0 drive in one of the USB 3.0 connectors. Eventually an SSD will be subbed in. I used short fat power cords to eliminate potential resistance issues that could throttle the pis. The other USB 3.0 port was dedicated to an external HDD where the movies and music are locted. 

My primary sources will be added at the bottom of this file someday. The pis were set up as recommended by Raspberry, The standard pi config and command line changes were made, i.e. c groups were enabled. Swap was disabled in favor of ZRAM. The Pis are wired to the network on 1000 GB channels. I disabled bt and wifi to free up some resources (o the point of taking them out to the kernal). It frees up a tiny bit of resources. 

The pis were overclocked:
  - over_voltage = 6
  - arm_freq = 1950
  - gpu_freq = 650

GPU memory was limitied also. There are sources that claim you can go lower, but that was not so on my system.
  - gpu_mem = 256

 The required fan was added. The system rarely exceeds 60 C. 

Eventually, I want to compile the apps atively on the pi. This may be a bit of a stretch. The literature says a 10% performance boost with native compilation. That might give me enough juice to get after the video/sound sync that occasionally pops up. Docker also provides some interesting options, where you can have a container that spits ot a binary that can be incorporated into the build.  

I have tried ti integrate trafik into the mix, with limited sucess. 

If you have not guessed by now, I am not a computer scientist. I am a scientist, molecular biologist. I am working on AI/bio interfaces. Old fashioned stuff, like building out a knowledge base for ALzheimers where papers are combined to generate a synthesis of the topic with probability estimates of the 'truthiness' of each node. Maybe some new relationships may opo up. Slow going. 

Refs:

Overclock:
https://www.seeedstudio.com/blog/2020/02/12/how-to-safely-overclock-your-raspberry-pi-4-to-2-147ghz/