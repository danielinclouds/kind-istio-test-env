
# kind-istio-test-env
-----

## Prereqs
You need to configure dedicated network interface to connect from local machine to Istio on Kind.  
[docker-tuntap-osx](https://github.com/AlmirKadric-Published/docker-tuntap-osx)  
[KIND and Load Balancing with MetalLB on Mac](https://www.thehumblelab.com/kind-and-metallb-on-mac/)  

## Create cluster
`./start.sh`

## Cleanup 
`./stop.sh`