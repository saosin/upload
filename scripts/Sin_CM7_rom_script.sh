#!/bin/bash


echo "
You are using sin_Rom_script to build a CyanogenMod7 Firmware for SEMC Anzu LT15i device, this process takes about 1 - 6 hours !!,.. Can we start?? (y/n)"
read _clear
if [ "$_clear" != "y" ]; then echo  "\You sir/madam are an #epicfail (jk). Please read the above and try again."; exit 0; fi


# Setting up Superuser permissions

cd;
echo -e "Let's BEGIN!"
echo "Please provide sudo pass"
sudo echo "ok!"

##add repo for java and get dependencies for 32bit linux

#sudo add-apt-repository "deb http://archive.canonical.com/ maverick partner"
sudo add-apt-repository "deb http://archive.canonical.com/ lucid partner"

sudo apt-get update;
##apt-get files needed to build
echo -e

#sudo apt-get install -y git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.6-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev sun-java6-jdk pngcrush schedtool

##find if x64 or 32bit (uname -m)
#if [ `uname -m | sed 's/x86_//;s/i[3-6]86/32/'` != "32" ]; then
#  sudo apt-get install -y g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline5-dev gcc-4.3-multilib g++-4.3-multilib
#fi



### additional files needed for build


sudo apt-get install nautilus-open-terminal
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install make
sudo apt-get install gcc
sudo apt-get install g++
sudo apt-get install libc6-dev
sudo apt-get install flex
sudo apt-get install bison
sudo apt-get install patch
sudo apt-get install texinfo
sudo apt-get install libncurses-dev
sudo apt-get install git-core gnupg
sudo apt-get install flex bison gperf libsdl-dev libesd0-dev libwxgtk2.6-dev build-essential zip curl
sudo apt-get install ncurses-dev
sudo apt-get install zlib1g-dev
sudo apt-get install valgrind
sudo apt-get install python2.6
sudo apt-get update
sudo apt-get install sun-java6-jdk
sudo apt-get install libx11-dev


##get the sdk/adb/fastboot
echo
echo
echo Download the Android SDK/ADB needed to extract the proprietary files from your phone
echo -e "\033[1mDo you have SDK/ADB installed?\033[0m (y/n)?"
read -n1 -p ""
echo
[[ $REPLY = [nN] ]] && 	{
		##the android-sdk name changes every time google releases a new sdk. inform me to update
		wget http://dl.google.com/android/android-sdk_r13-linux_x86.tgz;
		tar xvzf android-sdk_r*.tgz;
		mv android-sdk_r* ~/;
		cd ~/android-sdk*;
		cd tools;
		./android update sdk -u;
		./android update adb;
		cd ~/android-sdk*/platform-tools/;
		##fastboot will be downloaded from my dropbox dir. if update available please inform me
		wget http://dl.dropbox.com/u/6751304/fastboot;
		sudo cp adb /usr/bin/adb;
		sudo cp fastboot /usr/bin/fastboot;
		sudo chmod 755 /usr/bin/adb;
		sudo chmod 755 /usr/bin/fastboot;

echo -e "First step Done!."

} || echo "You already have the files, skiped";

echo
echo


##download repo which is a tool to download source code:

mkdir -p ~/bin
curl "http://php.webtutor.pl/en/wp-content/uploads/2011/09/repo"> ~/bin/repo
chmod a+x ~/bin/repo


##Download CyanogenMod SourceCode


cd
mkdir -p ~/bin

if [[ -d ~/android/system ]] ; then
            echo '~/android/system' 'Dir Exists'
        else
            mkdir -p ~/android/system
        fi


##get repo
curl https://raw.github.com/android/tools_repo/master/repo > ~/bin/repo
chmod a+x ~/bin/repo
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
export PATH=$PATH:$HOME/bin

cd ~/android/system/


#mkdir -p ~/android/system
#cd ~/android/system/
#repo init -u git://github.com/CyanogenMod/android.git -b gingerbread
#repo sync -j16 
#repo sync




##initialize repo
repo init -u git://github.com/CyanogenMod/android.git -b gingerbread --repo-url=git://github.com/android/tools_repo.git
echo -e "Repo initialized! (Please note that this take some hours to complete."
repo sync -j8
while [ "$yyn" != "y" ]; do
echo -e "\033[1m Did the repo synchronization completed successfully? (y/n)"
read yyn
echo -e "\033[1m Doublechecking..."
repo sync
done
echo -e "First sync completed! (that took some time didn't it)."

echo

_udev_v="skip"
_idev_p="skip"
_incompatible="0"



#!/bin/bash


echo "
Now we get the device files and vendor and SEMC vendor files .. This takes only a few minutes, can we start? (y/n)"
read _clear
if [ "$_clear" != "y" ]; then echo -e "\You sir/madam are an #epicfail (jk). Please read the above and try again.
\033[0m"; exit 0; fi



mkdir -p ~/android/system/device/semc
cd ~/android/system/device/semc/

git clone git://github.com/CyanogenMod/android_device_semc_mogami-common.git -b gingerbread mogami-common

git clone git://github.com/CyanogenMod/android_device_semc_msm7x30-common.git -b gingerbread msm7x30-common

git clone git://github.com/CyanogenMod/android_device_semc_anzu.git -b gingerbread anzu

cd ..

cd ..

cd ~/android/system/vendor/

git clone git://github.com/koush/proprietary_vendor_semc.git -b gingerbread semc


cd ..

mkdir -p ~/android/system/kernel

git clone git://github.com/JasonStein/BlendMIUI-FXP-kernel-msm7x30.git kernel

cd ..

echo " finished "

echo " first step done, thanks for using SinSCRIPT "
















