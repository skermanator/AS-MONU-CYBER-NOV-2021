# AS-MONU-CYBER-NOV-2021
AS Monash CyberSecurity Bootcamp

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

<img src="Diagrams/Anthony Skerman Wk 13 HW ELK Diagram.jpg" alt="ELK Project Diagram" />


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook / yml files may be used to install only certain pieces of it, such as Filebeat.

- <a href="https://github.com/skermanator/AS-MONU-CYBER-NOV-2021/blob/main/Ansible/Ansible%20DVWA%20Playbook.md">Ansible Web VM's deployment with DVWA Playbook</a>
- <a href="https://github.com/skermanator/AS-MONU-CYBER-NOV-2021/blob/main/Ansible/Ansible%20Hosts.md">Ansible Hosts</a>
- <a href="https://github.com/skermanator/AS-MONU-CYBER-NOV-2021/blob/main/Ansible/Ansible%20Configuration.md">Ansible Configuration</a>
- <a href="https://github.com/skermanator/AS-MONU-CYBER-NOV-2021/blob/main/Ansible/Ansible%20ELK%20Installation%20Playbook.md">Ansible ELK Installation and VM Configuration Playbook</a>
- <a href="https://github.com/skermanator/AS-MONU-CYBER-NOV-2021/blob/main/Ansible/Ansible%20Filebeat%20Playbook.md">Ansible Filebeat Playbook</a>
- <a href="https://github.com/skermanator/AS-MONU-CYBER-NOV-2021/blob/main/Ansible/filebeat-config.yml.md">Ansible Filebeat Config file</a>
- <a href="https://github.com/skermanator/AS-MONU-CYBER-NOV-2021/blob/main/Ansible/Ansible%20Metricbeat%20Playbook.md">Ansible Metricbeat Playbook</a> 
- <a href="https://github.com/skermanator/AS-MONU-CYBER-NOV-2021/blob/main/Ansible/metricbeat-config.yml.md">Ansible Metricbeat Config file</a>


This document contains the following details:
- Description of the Topology 
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available/redundancy, in addition to restricting traffic to the network.
- Adding a load balancer before the web servers helps mitigate downtime, whether this is due to a machine failing or from a DDoS attack. The load balancer distributes the request across multiple servers so that no one server is taking the bulk of the requests. Load Balances can also feature health checks for the servers to make sure they are still efficiently. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
- **What does Filebeat watch for?** *Filebeat monitors log files, collects log events and sends the data to either Logstash or Elasticsearch for indexing.*
- **What does Metricbeat record?** *Metricbeat looks at the systems metrics, collects and sends it to and output location, aka Elasticsearch or Logstash.*

The configuration details of each machine may be found below.

| Name     | Function       | IP Address | Operating System  |
|----------|----------------|------------|-------------------|
| Jump Box | Gateway        | 10.0.0.4   | Ubuntu 18.04 gen1 |
| Web 1    | Web App        | 10.0.0.8   | Ubuntu 18.04 gen1 |
| Web 2    | Web App        | 10.0.0.9   | Ubuntu 18.04 gen1 |
| Web 3    | Web App        | 10.0.0.10  | Ubuntu 18.04 gen1 |
| ELK      | Monitor System | 10.2.0.4   | Ubuntu 18.04 gen1 |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox & ELK machines can accept connections from the Internet. Access to these machines are only allowed from the following IP address:
`159.***.***.167` (**IP Address redacted**)

Machines within the network can only be accessed by ansible container within JumpBox provisioner.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible |       Allowed IP Addresses      |
|----------|:-------------------:|:-------------------------------:|
| Jump Box |         YES         |       159.***.***.167 ssh       |
| Web 1    |  via Load Balancer  | All port 80 http / Jump box ssh |
| Web 2    |  via Load Balancer  | All port 80 http / Jump box ssh |
| Web 3    |  via Load Balancer  | All port 80 http / Jump box ssh |
| ELK      |         Yes         |       159.***.***.167 http      |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous as the process can be replicated and deployed on large scale by adding more target IP addresses to the host file. This insures accurate deployment so every machine has the exact same loadout. 

The playbook implements the following tasks:
- Install docker.io
- Install pip3
- Install Docker python module
- Increase virtual memory
- Downloads and launch's a docker


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

<img src="Images/ELK%20Docker%20PS.png" alt="ELK Docker PS" />

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web 1: 10.0.0.8
- Web 2: 10.0.0.9
- Web 3: 10.0.0.10

We have installed the following Beats on these machines:
- MetricBeat & File Beat on all Web VM's

These Beats allow us to collect the following information from each machine:
- Filebeat collects logged events and forwards the data to Elasticsearch or logstash
- Metricbeat collects metrics and statistics from the servers and forwards the data to Elasticsearch or logstash for centralised monitoring.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbooks to Ansible Control Node.
- Update the hosts file to include the webservers and elks IP addresses (and uncomment the headers)
- Run the playbook, and navigate to 
  - Web Server: Load balancer public ip address `http://[Host IP]:5601`  
  - ELK: `http://[Host IP]:5601` to check that the installation worked as expected.


**Q&A**
- Which file is the playbook? 
  - There are a number of playbooks in this example. Playbooks generally end in `.yml` 
  - Ansible DVWA Playbook.yml
  - Ansible ELK Installation Playbook.yml
  - Ansible Filebeat Playbook.yml
  - Ansible Metricbeat Playbook.yml

- Where do you copy it?
  - `/etc/ansible/roles/files`
   
- _Which file do you update to make Ansible run the playbook on a specific machine?
  - `Ansible Host File`
-  How do I specify which machine to install the ELK server on versus which to install Filebeat on?
   - The Ansible host files has headers with IP addresses relating under it. In the playbook you set the target with the use of the headers. 
- Which URL do you navigate to in order to check that the ELK server is running?
  - `http://[Host IP]:5601`

