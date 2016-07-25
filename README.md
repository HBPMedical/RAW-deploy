# RAW-deploy
Deployment Scripts for the RAW DB Engine

## Installation

1. Requirements:
   * docker compose 1.6.2+
   * docker engine 1.10+
   * htpasswd

2. Clone this repository:
  ```!sh
  git clone https://github.com/HBPSP8Repo/RAW-deploy.git
  ```

3. Generate an ```raw-admin/conf/.htpasswd``` file:
  ```!sh
  $ cd RAW-deploy
  $ htpasswd -c raw-admin/conf/.htpasswd <username>
  ```
  
  Provide a password when requested. This is a **weak security scheme**, make sure to set up appropriately your network.

4. Remove the ```data/remove.me``` file, and add your data in that folder, or alternatively, set raw_data_root like:
  ```!sh
  $ cd RAW-deploy
  $ raw_data_root=<path to data folder> ./start <options>
  ```

5. Start the RAW engine container and the associated containers with:
  ```!sh
  $ ./start.sh single up
  ```
  The docker images will be downloaded and started. You will have the admin interface available on http://localhost by default.

6. For more options and configuration, see the online help of ```docker-compose``` and ```start.sh```.
