#!/bin/bash

	# if user is not running the command as root
#	if [ "$UID" -ne 0 ]; then

		# output message
#		echo "Please run the installer with SUDO!"

		# stop script
#		exit
#	fi

	# check update
#	apt update > /dev/null 2>&1

	# output message
	echo -e "\nCyberGhost Installer ...\n"

	# get GLIBC version
	#glibcVersion=$(ldd --version | grep -i ldd | awk -F' ' {'print $5'})
	
	# get distribution version
	#ubuntuDistroVersion=$(lsb_release -sr)
	#distroName=$(lsb_release -a | grep -i "Distributor ID:" | awk -F' ' {'print $3'})
	#distroVersion=$(lsb_release -a | grep -i "Release:" | awk -F' ' {'print $2'})	

	echo "Checking if glibc version is compatible"
	

	# check if GLIBC version is compatible
	#if [ "$ubuntuDistroVersion" == "16.04" ]; then
			
	#	if [ "$glibcVersion" == "2.23" ] ; then

	#		echo "The glibc version is compatible, continue..."

	#	else

	#		echo "THe glibc version is incompatible, exiting setup..."
#			exit
#
#		fi

#	elif [ "$ubuntuDistroVersion" == "18.04" ] || [ "$distroName" == "LinuxMint" ]; then#
		
#		if [ "$glibcVersion" == "2.27" ]; then
		
#			echo "The glibc version is compatible, continue..."
		
#		else
		
#			echo "The glibc version is incompatible, exiting setup..."
#			exit
#
#		fi
#
#	elif [ "$ubuntuDistroVersion" == "19.10" ]; then
#
#		if [ "$glibcVersion" == "2.30" ]; then
#
#			echo "The glibc version is compatible, continue..."

#		else

#			echo "The glibc version is incompatible, exiting setup..."
#			exit
#		fi

#	elif [ "$distroName" == "Kali" ] || [ "$ubuntuDistroVersion" == "19.04" ] || [ "$ubuntuDistroVersion" == "20.04" ]; then
#
#		if [ "$glibcVersion" == "2.29" ] || [ "$glibcVersion" == "2.31" ] || [ "$glibcVersion" == "2.30" ]; then

#			echo "The glibc version is compatible, continue..."
		
#		else

#			echo "The glibc version is incompatible, exiting setup..."
#			exit
#		
#		fi

#	elif [ "$distroName" == "Linuxmint" ] && [ "$distroVersion" == "20" ]; then
		
#		if [ "$glibcVersion" == "2.31" ]; then
#			echo "The glibc version is compatible, continue..."
#		else
#			echo "The glibc version is incompatible, exiting setup..."
##		fi
#
#	else

		echo "Couldn't detect a valid version of your distribution."
		echo "Make sure you have downloaded the correct install package for your distribution"
		echo "Note: We support only the following distributions for Debian based OS:"
		echo ""
		echo "-Ubuntu 16.04 "
		echo "-Ubuntu 18.04 "
		echo "-Ubuntu 19.04 "
		echo "-Ubuntu 19.10 "
		echo "-Ubuntu 20.04 "
		echo "-Linux Mint 19.2 "
		echo "-Linux Mint 20"
		echo "-PopOS 19.10 "
		echo "-Kali 2019/2020 (glibc version should be 2.29/2.30/2.31 in order to work) "
#		exit

#	fi			


	# define required packages
    requiredPackages=(curl openvpn resolvconf wireguard)

	# loop through packages
    for package in "${requiredPackages[@]}"; do

		# set package
		p="$package"

		# if package is opwireguardenvpn
		if [ "$package" == "wireguard" ]; then

			# check if wireguard ppa exist
			responseCode=$(grep ^ /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -c wireguard)

			# if ppa does not exist
			if [ "$responseCode" == "0" ]; then

				# install wireguard ppa
				add-apt-repository -y ppa:wireguard/wireguard > /dev/null 2>&1
				apt update > /dev/null 2>&1
			fi

			# change package name
			p="wg"
		fi

		# check if package is installed and get exit code
        responseCode=$(which "$p" > /dev/null 2>&1; echo "$?")

		# output message
		echo -n "Check if \"$package\" package is already installed ... "

		# if package is installed
        if [ "$responseCode" == "0" ]; then

			# output message
			echo "Yes"

			# if package is openvpn
			if [ "$package" == "openvpn" ]; then

				# get openvpn version
				openvpnVersion=$(openvpn --version | head -n 1 | awk '{print $2}')

				# get major version
				majorVersion=$(echo "$openvpnVersion" | awk -F. '{print $1}')

				# get minor version
				minorVersion=$(echo "$openvpnVersion" | awk -F. '{print $2}')

				# output message
				echo -n "Checking OpenVPN version ... "

				if [ $majorVersion -ge 2 ] && [ $minorVersion -gt 3 ]; then

					# output message
					echo "Latest ..."
				else

					# output message
					echo "The OpenVPN version is too old ... "
					echo "Removing old package ... "

					# uninstall package
					apt remove "$package" -y > /dev/null 2>&1

					# output message
					echo -n "Installing new package ... "
					curl -s https://swupdate.openvpn.net/repos/repo-public.gpg | apt-key add -
					echo "deb http://build.openvpn.net/debian/openvpn/stable xenial main" > /etc/apt/sources.list.d/openvpn-aptrepo.list
					apt update > /dev/null 2>&1
					apt install "$package" -y > /dev/null 2>&1

					# output message
					echo "Done."
				fi
			fi
        else

			# output message
            echo -n "No, installing ... "

			if [ "$package" == "openvpn" ]; then

				# get openvpn version from apt
				openvpnVersion=$(apt show openvpn|grep "Version:" | awk '{ print $2 }')
				version=$(echo "$openvpnVersion"| awk -F'-' '{print $1}')
				
				# get major version
				majorVersion=$(echo "$version" | awk -F. '{print $1}')

				# get minor version
				minorVersion=$(echo "$version" | awk -F. '{print $2}')

				# if version is lower then 2.4
				if [ $majorVersion -ge 2 ] && [ $minorVersion -lt 4 ]; then
					curl -s https://swupdate.openvpn.net/repos/repo-public.gpg | apt-key add -
					echo "deb http://build.openvpn.net/debian/openvpn/stable xenial main" > /etc/apt/sources.list.d/openvpn-aptrepo.list
					apt update > /dev/null 2>&1
				fi
			fi


			# install package
            apt install "$package" -y > /dev/null 2>&1

			# output message
            echo "Done."
        fi
    done

	# output message
	echo "Continue ..."

	# if directory exist
	if [ -d /usr/local/cyberghost ]; then

		# remove directory
		rm -rf /usr/local/cyberghost
	fi

	echo "Installing application ..."

	# if logs directory does not exist
	if [ ! -d /usr/local/cyberghost ]; then

		# create logs directory if not exist
		mkdir /usr/local/cyberghost
	fi

	# copy certificates to local directory
	cp -r cyberghost/* /usr/local/cyberghost

	# change directory permissions
	chmod -R 755 /usr/local/cyberghost

	# output message
	echo "Create symlinks ..."

	# if symlink exist
	if [ -L /usr/bin/cyberghostvpn ]; then

		# remove old symlink
		rm /usr/bin/cyberghostvpn
	fi

	# create symlink
	ln -sf /usr/local/cyberghost/cyberghostvpn /usr/bin/cyberghostvpn

	# setup application
	cyberghostvpn --setup
