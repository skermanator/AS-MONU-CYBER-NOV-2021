# **Ansible Filebeat Playbook**
  
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