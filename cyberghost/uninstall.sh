#!/bin/bash

	# if user is not running the command as root
	if [ "$UID" -ne 0 ]; then

		# output message
		echo "Please run the installer with SUDO!"

		# stop script
		exit
	fi

	# output message
	echo -e "Checking for installed packages ...\n"

	# define installed packages
    requiredPackages=(openvpn resolvconf wireguard)

	# loop through packages
    for package in "${requiredPackages[@]}"; do

		# set package
		p="$package"

		# if package is opwireguardenvpn
		if [ "$package" == "wireguard" ]; then

			# change package name
			p="wg"
		fi

		# check and get exit code if package is installed
        responseCode=$(which "$p" > /dev/null 2>&1 ; echo "$?")

		# output message
		echo -n "Check if package \"$package\" is installed ... "

		# if package is installed
		if [ "$responseCode" == "0" ]; then

			# output message
			echo "Yes ..."

			# remove configuration files
			echo -n "Do you want to uninstall the package \"$package\"? [Y/n]: "
			read option

			# if configuration files can be removed
			if [ "$option" == "Y" ] || [ "$option" == "y" ]; then

				# uninstall package
				apt remove --purge "$package" -y > /dev/null 2>&1

				# output message
				echo -e "The \"$package\" was unistalled ..."
			else

				# output message
				echo -e "Skipping uninstall ..."
			fi
		else

			# output message
			echo -e "No. Skipping ..."
		fi
	done

	# output message
	echo -e "\nContinue ...\n"

	# uninstall application
	cyberghostvpn --uninstall
