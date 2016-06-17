# RAW-deploy
Deployment Scripts for the RAW DB Engine

## Installation

1. Requirements:
   * docker version 1.10+
   * htpasswd

2. Clone this repository:
  ```!sh
  git clone https://github.com/HBPSP8Repo/RAW-deploy.git
  ```

3. Remove the ```data/remove.me``` file, and add your data in that folder, or alternatively, edit ```env.sh``` so that ```docker_data_folder```points to your data folder.
  ```!sh
  export docker_data_folder="${PWD}/data"
  ```

4. Generate an ```raw-admin/conf/.htpasswd``` file:
  ```!sh
  $ cd RAW-deploy
  $ htpasswd -c raw-admin/conf/.htpasswd <username>
  ```
  
  Provide a password when requested. This is a **weak security scheme**, make sure to set up appropriately your network.

5. Start the RAW engine container and the associated containers with:
  ```!sh
  $ ./start-all.sh
  ```
  The docker images will be downloaded and started. You will have the admin interface available on http://localhost by default.

  If this is not possible, adapt ```./start-admin-basic.sh``` to bind another host port.
