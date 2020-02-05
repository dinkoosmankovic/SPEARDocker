# SPEARDocker

This is a repository for description of Docker image for SPEAR project.

# Build docker image

Please ensure that you have a working Ubuntu 18.04 installation with Docker. More info at https://docs.docker.com/install/.

First, clone this repository with:
```
$ git clone https://github.com/dinkoosmankovic/SPEARDocker.git
```
Then use:
```
$ cd SPEARDocker
$ docker build -t spear:beta .
```
This will build docker container from the Dockerfile. 

# Running the container

You can use gui-docker script to run the container:
```
$ ./gui-docker
```

If everything is ok, you will get command prompt of the container. To check if GUI is enabled, run the following:
```
$ source ~/ws_moveit/devel/setup.bash
$ roscore > /dev/null & rosrun rviz rviz
```
You should be able to see RViz window opened in your screen.

# Running xARM MoveIt

To run planning environment for xARM 6, run the following:
```
roslaunch xarm6_moveit_config demo.launch
```
You should be able to see RViz with planning panels opened in your screen.
