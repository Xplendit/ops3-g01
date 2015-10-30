#
# Github fetch/upload script v 1.1
#
menu(){
PS3='Voor welke repository ben je aan het werken?: '
options=("Linux" "Projecten" )
select opt1 in "${options[@]}"
do
	case $opt1 in
		"Linux")
		# Verander dit in de juist locatie van je linux repository
			cd enterprise-linux-labo/
			clear
			break
			;;
		"Projecten")
		# Idem hier
			cd ops3-g01/
			clear
			break
			;;
	esac
done
}
menu
while true
do
PS3='Wat wil je doen?: '
options=("Ophalen" "Posten" "Status" "Return" "Stoppen" )
select opt in "${options[@]}"
do
    case $opt in
        "Ophalen")
			clear
            git fetch
			git pull
			break
            ;;
        "Posten")
			echo "Geef een message op: "
			read msg
			clear
            git add -A
			git commit -m "$msg"
			git push
			break
            ;;
        "Status")
			clear
            git status
			break			
			;;
		"Return")
			clear
			menu
			break
			;;
        "Stoppen")
            exit
            ;;
        *) echo invalid option;;
    esac
done
done