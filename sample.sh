
echo -e "MENU\n1)Create a new Account!\n2)Login into Existing Account!\n"

echo "Enter your choice:"
read ch
case $ch in

1)echo "Creating new Account...."
echo "Enter Username:"
read user
echo "Enter password:"
read -s pass

hash_pass=`echo $pass | sha256sum`

echo -e "THE DATABASE:\n"

mysql -u root -pmandar << EOF
use abcd;
insert into Storage (username,password) VALUES ("${user}","${hash_pass}");
select * from Storage;
EOF

#echo -e "USERNAME : $user\nPASSWORD: $pass\nHASED PASWWORD IS: ${hash_pass}"
;;


2)echo "Loging into Existinfg Account...."
echo "Enter Username":
read user
echo "Enter Password:"
read -s pass

hash_check=`echo $pass | sha256sum`

mysql -u root -pmandar<<EOF
use abcd;
select * from Storage where password = "${hash_check}"
AND username = "$user";

EOF

;;
esac



