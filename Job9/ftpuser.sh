i=$(cat ftpuser.csv | wc -l)
for h in $(eval echo "{2..$i..1}");
	do
	recup[$h]=$(sed -n "$h p" ftpuser.csv)
	for k in {1..3..1}
	do
		infos[$k]=$(echo ${recup[$h]} | cut -d ',' -f$k)
		infos[$k]=$(echo ${infos[$k]} | cut -d ' ' -f$k)
	done
	case ${infos[3]} in
		Sudo*)
			sudo useradd -m ${infos[1]}
			sudo usermod -aG sudo ${infos[1]}
			sudo adduser ${infos[1]} ftp
			echo "${infos[1]}:${infos[2]}" | sudo chpasswd
			echo "L'utilisateur ${infos[1]} a été crée et ajouté aux groupes sudo et ftp"
			;;
		*)
			sudo useradd -m ${infos[1]}
			sudo adduser ${infos[1]} ftp
			echo "${infos[1]}:${infos[2]}" | sudo chpasswd
			echo "L'utilisateur ${infos[1]} a été crée et ajouté au groupe ftp"
		;;
	esac
done
