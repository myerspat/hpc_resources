# Getting Started with AIMS HPCs

To get access to one of the clusters within AIMS send a Slack message to the HPC Manager including the following

- What I need the machines for. Research? Explain.
- What hardware I will primarily use. CPU or GPU?

Download the UMICH VPN at https://its.umich.edu/enterprise/wifi-networks/vpn/getting-started. This must always be active when accessing any UMICH system. 

Assuming your reasons for needing access to an AIMS system are adequate the HPC Manager will create a username and password that will look like

- Username: `<your-unique-name>`
- Password: `<your-unique-name>1234`

You can then SSH into the system by running `ssh <your-unique-name>@ners-aims0X.engin.umich.edu>`, where `X` is the AIMS machine the HPC Manager is giving you access. You'll be prompted to change your password and then you're ready to go.

To simplify SSHing, you can add the following to your local `~/.ssh/config`:
```
Host aims0X
	HostName ners-aims0X.engin.umich.edu
	User <your-unique-name>
	ControlMaster auto
	ControlPersist 8620
	ServerAliveInterval 60
```
Now you can SSH in by running `ssh aims0X`.