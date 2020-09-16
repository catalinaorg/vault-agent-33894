# Purpose

This repo create a VM with Vault Enterprise and makes configuration for Vault Agent


# How to use it

* clone this repo

* place Vault Enterprise(1.5.0+prem) binary in the folder *utils*

* start VM

` $ vagrant up`

* connect to VM

` $ vagrant ssh`

* run Vault Agent

` $ sudo vault agent -config=agent-config.hcl -log-level=debug`
