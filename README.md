# AS-MONU-CYBER-NOV-2021
AS Monash CyberSecurity Bootcamp

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

<img src="Diagrams/Anthony Skerman Wk 13 HW ELK Diagram . Project.drawio.jpg" alt="ELK Project Diagram" />


These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook / yml files may be used to install only certain pieces of it, such as Filebeat.



**Config Web VM with Docker**

    ---
    - name: Config Web VM with Docker
      hosts: webservers
      become: true
      tasks:
        - name: docker.io
          apt:
            update_cache: yes
            name: docker.io
            state: present

        - name: Install pip3
          apt:
            name: python3-pip
            state: present

        - name: Install Docker python module
          pip:
            name: docker
            state: present

        - name: download and launch a docker web container
          docker_container:
            name: dvwa
            image: cyberxsecurity/dvwa
            state: started
            restart_policy: always
            published_ports: 80:80

        - name: Enable docker service
          systemd:
            name: docker
            enabled: yes

**Configure Elk VM with Docker**

    ---
    - name: Configure Elk VM with Docker
      hosts: elk
      remote_user: rtadmin
      become: true
      tasks:
        # Use apt module
        - name: Install docker.io
          apt:
            update_cache: yes
            name: docker.io
            state: present

          # Use apt module
        - name: Install pip3
          apt:
            force_apt_get: yes
            name: python3-pip
            state: present

          # Use pip module
        - name: Install Docker python module
          pip:
            name: docker
            state: present

          # Use sysctl module
        - name: Use more memory
          sysctl:
            name: vm.max_map_count
            value: "262144"
            state: present
            reload: yes

          # Use docker_container module
        - name: download and launch a docker elk container
          docker_container:
            name: elk
            image: sebp/elk:761
            state: started
            restart_policy: always
            published_ports:
              - 5601:5601
              - 9200:9200
              - 5044:5044

          # Use systemd module
        - name: Enable service docker on boot
          systemd:
            name: docker
            enabled: yes


**Playbook to install & configure Filebeat**
  
    ---
    - name: Playbook to install & configure Filebeat
    hosts: webservers
    remote_user: rtadmin
    become: true
    tasks:

    - name: Download the Filebeat installation file
      command:
        cmd: curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.2-amd64.deb
        creates: filebeat-7.6.2-amd64.deb

    - name: Install Filebeat
      command: sudo dpkg -i filebeat-7.6.2-amd64.deb

    - name: Copy the Filebeat config file to the ElkVM
      copy:
        src: /etc/ansible/roles/filebeat-config.yml
        dest: /etc/filebeat/filebeat.yml

    - name: Enable Filebeat modules
      command: filebeat modules enable system

    - name: Filebeat setup
      command:  filebeat setup

    - name: Start Filebeat
      command: service filebeat start

    - name: Enable Filebeat service on boot
      systemd:
        name: filebeat
        enabled: yes
**Playbook to install & configure Metricbeat**

    ---
    - name: Playbook to install & configure Metricbeat
    hosts: webservers
    become: true
    tasks:

    - name: Download the Metricbeat installation file
      command:
        cmd: curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.2-amd64.deb
        creates: metricbeat-7.6.2-amd64.deb

    - name: Install Metricbeat
      command: sudo dpkg -i metricbeat-7.6.2-amd64.deb

    - name: Copy the Metricbeat config file to the ElkVM
      copy:
        src: /etc/ansible/roles/file/metricbeat-config.yml
        dest: /etc/metricbeat/metricbeat.yml

    - name: Enable Metricbeat modules
      command: metricbeat modules enable docker

    - name: Metricbeat setup
      command: metricbeat setup

    - name: Start Metricbeat
      command: service metricbeat start

    - name: Enable Metricbeat service on boot
      systemd:
        name: metricbeat
        enabled: yes


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
_Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table_.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.1   | Linux            |
| TODO     |          |            |                  |
| TODO     |          |            |                  |
| TODO     |          |            |                  |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox & ELK machines can accept connections from the Internet. Access to these machines are only allowed from the following IP address:
`159.***.***.167` (**IP Address redacted**)

Machines within the network can only be accessed by ansible container within JumpBox provisioner.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes/No              | 10.0.0.1 10.0.0.2    |
|          |                     |                      |
|          |                     |                      |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- _TODO: What is the main advantage of automating configuration with Ansible?_

The playbook implements the following tasks:
- _TODO: In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
- ...
- ...

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- _TODO: List the IP addresses of the machines you are monitoring_

We have installed the following Beats on these machines:
- _TODO: Specify which Beats you successfully installed_

These Beats allow us to collect the following information from each machine:
- _TODO: In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._