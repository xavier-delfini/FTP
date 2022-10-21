i=$(cat ftpuser.csv | wc -l)
for h in $(eval echo "{2..$i..1}");
	do
	recup[$h]=$(sed -n "$h p" ftpuser.csv)
	for k in {1..5..1}
	do
		infos[$k]=$(echo ${recup[$h]} | cut -d ',' -f$k)
		infos[$k]=$(echo ${infos[$k]} | cut -d ' ' -f$k)
	done
	user[$h]=${infos[2]}"-"${infos[3]}
	case ${infos[5]} in
		Admin*)
			sudo useradd -m -u ${infos[1]} -p ${infos[4]} --gid root ${user[$h]}
			echo "L'utilisateur ${user[$h]}a été crée et est passé root"
			;;
		*)
			sudo useradd -m -u ${infos[1]} -p ${infos[4]} ${user[$h]}
			echo "L'utilisateur ${user[$h]} a été crée et est passé simple utilisateur"
		;;
	esac
done
