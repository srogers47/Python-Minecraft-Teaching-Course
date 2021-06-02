#!/bin/sh

#This is an executable file that will set up linux ubuntu.

#RUN in terminal with command: sudo ./initial_setup.sh
#sudo will prompt for a user password. When typing password, text will be hidden.  
#References: https://gist.github.com/bendavis78/37a2e8006c430dcd9b1194f63a62046d 

#Setup ubuntu vm 
echo "Initializing installation and setup script.  Watch terminal for script prompting keypresses."
sudo apt-get update 
sudo apt-get install python-software-properties python3 python3-pip idle3 git 
sudo apt-get install openjdk-8-jre-headless openjdk-8-jdk maven 

#Install minecraft.
sudo add-apt-repository ppa:flexiondotorg/minecraft
sudo apt update
sudo apt install minecraft

#Install and build Spigot -->  popular minecraft server that allows modding, 
mkdir ~/spigot
cd ~/spigot
wget "https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar"
git config --global --unset core.autocrlf
java -jar BuildTools.jar --rev 1.12.2

#Download and build RaspberryJuice --> Plugin for Spigot that facilitates python3 programming. 
git clone https://github.com/zhuowei/RaspberryJuice ~/spigot/RaspberryJuice
cd ~/spigot/RaspberryJuice
mvn package
mkdir ~/spigot/plugins
cp ~/spigot/RaspberryJuice/jars/raspberryjuice-1.11.jar ~/spigot/plugins/
echo "eula=true" > ~/spigot/eula.txt
#Create a start-up script in ~/spigot/start.sh 
sudo echo "#!/bin/sh" > ~/spigot/start.sh
sudo echo "sudo java -Xmx1024M -jar spigot-1.16.5.jar" >> ~/spigot/start.sh #If start.sh fails to open jar file, then run the code below in the terminal:
	#"cd ~/spigot"
	#"java -Xmx1024M -jar spigot-1.16.5.jar"

#If the program is still unable to access jar file try:
	#"java -Xmx1024 -jar BuildTools.jar" 
        #This should prompt a new download in spigot directory (spigot/) 	
	#lastly  run "java -Xmx1024M -jar spigot-1.16.5.jar"

sudo chmod +x ~/spigot/start.sh #Make start.sh an executable file 

#Install latest version of pymineapi -> we will use python3.8 to minimize potential dependency issues. 
sudo pip3 install git+https://github.com/py3minepi/py3minepi/ 
echo "Installation and setup complete! Test and validate install-setup by running: ./~/spigot/start.sh in the terminal.
This will start your spigot server. 
Next Start minecraft by clicking the newly created minecraft launcher/icon.
Login, press play, select multiplayer, Direct Connect. Type "localhost" then select "Join Server"
Last run "idle3" --> This will open a python3 interactive shell. 
Let's see if we can type into chat using the code below. 

from mcpi.minecraft import Minecraft
mc = Minecraft.create()
mc.postToChat('Hello world') 
" 
#That's it! This script will take some time to complete depending on network speed.  
	

#P.S. while waiting for your donwload to complete, check out these cool minecraft project repositories
		#https://github.com/search?q=user%3Amartinohanlon+minecraft
