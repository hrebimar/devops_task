#!/bin/bash
#vytvoření sítě tak aby deploy fungoval s mými adresami
lxc network create cdnnet --type=bridge ipv4.address=10.250.112.1/24 ipv4.nat=true

