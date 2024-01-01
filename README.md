This is my first project aiming to ensure the health of both hardware and software is optimal before being resold. 

I have plans to add more to this script in the future.
As of now, the script mainly runs baked in command prompt commands or powershell commands to check and restore any winows .iso issues
Currently there should be a loading bar for each script, asking the user if they want to move forward to prevent the same commands run over and over again. 

This is my first official project, I barely understand scripting languages as a whole.
Im hoping this works without any permissions/profiles on the image, this is mainly ment to simplify the process after a fresh windows install.

The master script is what calls upon all the other created tools in either html, batch, or powershell with little to no user based dependencies on a system. The reason for this is to ensure this can run on a fresh installation of windows to ensure a re-used or re-sold computer is applicable for sale. Not only this, but to make sure the customer gets the device in as good of condidtion that it can be before buying. This aims to reduce returns from individuals never updating their PC or being technologically illiterate.

The Update powershell script is one that must be run with a internet connection. This script is similar to a "sudo apt update && sudo apt upgrade -y" on a linux system. This works in the exact same mannor the Windows GUI using tools that are mostly baked into a windows system. This means grabbing the necessary updates to ensure all of the device is usable, and the image is up to date for the future customer. It is reccommended the system be restarted after running this script to install any/all updates.

The System Health Check runs other tools baked into windows from the beginning, ensuring the Windows image is healthy, storage and other hardware is working as it should, the storage is as open as possible, amongst other maitenance for both the Windows Image and the hardware itself. 

Finally, The Screen Test runs a basic test to ensure there are no dead pixels along with making sure there is no burn in on oled screens. First opens a HTML script that can filter through different colors including red,green,blue,white,black, and grey. After this there is a long list of songs and knock off movies to hopefully get some smiles. 
The HTML script uses the space bar or ' ' to select the next color
To exit the script press the key 'Q'

Throughout the entire script, pressing the 'E' key will exit the script
At the end of the script, the 'S' key will shutdown the system immediatley after hitting enter

As of 1/1/24 there are plans to continue to add to this for a func check on a device. However I do not have very much to add at the moment but will continue to update this in the future. 
