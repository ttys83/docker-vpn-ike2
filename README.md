# docker-vpn-ike2

First, you need add a user|password pair in clients file. There is already 3 clients added, be free to change, remove or add clients as you wish.
Now, you can build and run your vpn server, just execute run-vpn.sh and it build image and run docker container for you.
After the script is done, run 
    sudo docker logs vpn-ike2 
You will see secrets and key, neccessary to set up your clients.
Please, look this guide to configure clients:
    https://www.digitalocean.com/community/tutorials/how-to-set-up-an-ikev2-vpn-server-with-strongswan-on-ubuntu-16-04#step-7-â-testing-the-vpn-connection-on-windows,-ios,-and-macos

Useful commands:

Command for run docker container:
    sudo docker container run -v ${VPN-IKE2-DIR}/vpn-certs:/vpn-certs --privileged -p 500:500/udp -p 4500:4500/udp --name vpn-ike2 -d vpn-ike2

Show container's log:
    sudo docker logs vpn-ike2

Log in to the container:
    sudo docker exec -it vpn-ike2 env TERM=xterm bash -l