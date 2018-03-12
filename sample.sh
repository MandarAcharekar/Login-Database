
echo -e "MENU\n1)Create a new Account!\n2)Login into Existing Account!\n"

echo "Enter your choice:"
read ch
case $ch in

1)echo -e "\t\tCreating new Account...."
echo "Enter Username:"
read user
echo "Enter password:"
read -s pass

hash_pass=`echo $pass | sha256sum`

mysql -u root -pmandar << EOF
use abcd;
insert into Storage (username,password) VALUES ("${user}","${hash_pass}");
EOF

echo -e "\t$user ADDED INTO DATABASE!!\n"

#echo -e "USERNAME : $user\nPASSWORD: $pass\nHASED PASWWORD IS: ${hash_pass}"
;;


2)echo -e "\t\tLoging into Existinfg Account...."
echo "Enter Username":
read user
echo "Enter Password:"
read -s pass

hash_check=`echo $pass | sha256sum`


#echo -e "\nNOW BASH COMMANDS:"
my_user=$(echo "select username from Storage where password =\"${hash_check}\" AND username = \"$user\" ;" | mysql abcd -u root -pmandar -N )
my_pass=$(echo "select password from Storage where password=\"${hash_check}\" AND username=\"$user\";" | mysql abcd -u root -pmandar -N)

echo -e "USERNAME: $my_user\nPASSWORD: $my_pass\n"

user_len=$(expr length "$my_user") #Bcoz username takes 8 char. and 1 new line char.

user_pass=$(expr length "$my_pass") #bcoz password takes 9 char. and 1 new line char.

#echo "$user_len"
#echo "$user_pass"

#user_actual=$(echo $str | cut -d' ' -f 2)

if [ $user_len -gt 0 ]; then 
	echo -e "\t\tWELCOME $my_user !\n\t\tLOGIN SUCCESFULL!\n"
fi

;;
esac

echo -e "\t\tTHE DATABASE:\n"

mysql -u root -pmandar << EOF
use abcd;
select * from Storage;
EOF





