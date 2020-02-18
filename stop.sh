#!/bin/bash

kind delete cluster
sudo route -n delete 172.17.255/24 10.0.75.2