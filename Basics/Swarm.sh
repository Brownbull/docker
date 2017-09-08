# Basic commands on Swarm level
# Swarm are "Dockerized" Clusters that contains multiple nodes (physical or virtual machines)

# Create a Cluster
# Create VM
$ docker-machine create --driver virtualbox myvm1 # Create a VM (Mac, Win7, Linux)
$ docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1 # Win10

# See VMs registry
$ docker-machine ls

# Start a stopped VM
$ docker-machine start <VMname>

# Stop a VM
$ docker-machine stop <VMname>
$ docker-machine stop $(docker-machine ls -q) # Stop all running VMs

# copy files into a VM
$ docker-machine scp <inputfile.extension> myvm1:~ # ~ represents home directory on VM

# Swarm Creation on Cluster
  # Start Swarm in a VM (myvm1 on this case)
  $ docker-machine ssh myvm1 "docker swarm init" # myvm1 became the Swarm Manager Node
    # Error on toolbox? Copy the IP address for myvm1 by running docker-machine ls, then run the docker
    # swarm init command again, using that IP and specifying port 2377 (the port for swarm joins)
    # with --advertise-addr. For example:
    $ docker-machine ssh myvm1 "docker swarm init --advertise-addr 192.168.99.101:2377"

  # Get docker swarm join token
  $ docker-machine ssh myvm1 "docker swarm join-token -q worker"
    # obtained
    # SWMTKN-1-2o2vco5saxq7c5lcw33bbbg0km0nev3gl9x6s7x5kr5v7xyy48-661lfd4zuxtt99fnxbiplgcd9

  # Add Worker to Swarm using docker swarm join token
  $ docker-machine ssh myvm2 "docker swarm join \--token <token> \<ip>:<port>"
    # replacing
    # $ docker-machine ssh myvm2 "docker swarm join \--token SWMTKN-1-2o2vco5saxq7c5lcw33bbbg0km0nev3gl9x6s7x5kr5v7xyy48-661lfd4zuxtt99fnxbiplgcd9 \192.168.99.101:2377"
# Swarm Created

# SSH shell on VMs
# online
$ docker-machine ssh <VMname> # exit to finish
  $ exit # finish SSH shell
# batch
$ docker-machine ssh <VMname> "command" # echo, ps, cd, pwd, etc

# Shell commands for VM
  # leave Swarm
  $ docker swarm leave # for slave nodes
  $ docker swarm leave -f # on Swarm Manager node Stop Swarm
  $ docker swarm leave --force # kill him!

  # Swarm Manager commands
  # Start SSH Shell on Swarm Manager (myvm1 on this case)
  $ docker-machine ssh myvm1
  # See Swarm nodes
  $ docker node ls
  # inspect a node in a Cluster
  $ docker node inspect <nodeID>
  # Remove a node
  $ docker node rm <nodeID>
  # Deploy an App on a Cluster
  $ docker stack deploy -c docker-compose.yml getstartedlab # http://192.168.99.101/ or http://192.168.99.102/
  # See running images on Cluster
  $ docker stack ps getstartedlab
  # Shutdown an App on a Cluster
  $ docker stack rm getstartedlab
