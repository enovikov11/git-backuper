Scripts to backup your minecraft world into git.


Master world - world, which would overwrite changes in repository.
Slave world - world, which would prefer changes from origin.


1. Mount ssh key to `/root/.ssh/id_rsa`  
2. Mount master world into `/root/master`
3. Mount slave world into `/root/master`
4. Setup GIT_NAME, GIT_EMAIL

Credits to [docker-cron](https://github.com/Ekito/docker-cron)