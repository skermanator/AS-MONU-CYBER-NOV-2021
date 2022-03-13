# **Playbook to install & configure Metricbeat**

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