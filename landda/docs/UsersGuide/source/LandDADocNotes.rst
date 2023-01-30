:orphan:

Model 
Workflow
Database
Summary
Appendix

#set up a fresh directory somewhere on your system and download the data 
that you will need to run a cycle

wget https://epic-sandbox-srw.s3.amazonaws.com/land-da-data.tar.gz

#Untar the data. This will all be in a directory called land-release

tar xvfz land-da-data.tar.gz

#cd into the land-release directory

cd land-release/

#Shell into the singularity container (replace the path to 
ubuntu20.04-intel-spack-landda.img with the appropriate path on your 
system) and change the "-B /lustre:/lustre" with the root of your 
current filesystem (this allows you to copy files from the container to 
the land-release directory on your host system)

singularity shell -e -B /lustre:/lustre 
/lustre/ubuntu20.04-intel-spack-landda.img

# All the modules built into the container can be loaded up by sourcing 
the /opt/spack-stack/.bashenv file. After you source it, you can run 
"module list" to check

source /opt/spack-stack/.bashenv

# copy out the land-offline_workflow directory from the container to 
your host system alongside all the data directories

cp -r /opt/land-offline_workflow .

# cd into the newly copied land-offline_workflow directory

cd land-offline_workflow/

# Open submit_cycle.sh and look for the line that starts with "export 
LANDDAROOT=...."   Change the path to whatever is just above your 
land-release directory.

vi submit_cycle.sh

# Currently, the submit_cycle.sh script *cannot* be used directly as a 
batch script, but must be executed like a regular script from a compute 
node or desktop with 6+ cores. To allocate a compte node on Hera, run 
the following with the appropriate account -- "salloc -N 1 -A da-cpu -t 
0:30:00 -q debug"  Note that the script will start on the head node, but 
crashes because the ulimit -s can't be set to unlimited like it is on 
the compute nodes.

sh ./submit_cycle.sh settings_cycle_test

#If all goes well, a full cycle will run with DA and a forecast.

Please test this out and see if it works for you. There are some 
refinements to the container construction that need to be made, so I 
will try to work on those. I will also work on adding the capability to 
run the containerized system from outside singularity, which will allow 
a regular batch script to run as before.

Notes: 

- Define levels of support on the repo wiki and link in docs. 

