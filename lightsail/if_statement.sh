#run ( manual test) to get some ways to write string and interger on if statement
chmod +x if_statement.sh
script
!#/bin/bash
#how to check if a file/directory exist 
if [-f /var/log/message]  or [-d /var/log/message]
then
    echo "file exist"
else
    echo "file does not exist ,creat it"
    sudo touch /etc/log/message
    ls /etc/log/message
    sudo echo "we live togeether" > /var/log/message
    cat /etc/log/message
fi     
            OR # if the is a particular line we will be using often then we can just creat a variable from it and only be calling it

file/directry = /var/log/message  # variable

if [-f $file/directry]  or [-d file/directry]
then
    echo "file exist"
else
    echo "file does not exit ,creat it"
    sudo touch $file/directry
    ls /etc/log/message
    sudo echo "we live togeether" > $file/directry
    cat $file/directry
fi 
 
 
 # how to stop people from have direct access to the above and only use the command to check if their file/directory/user/group exist
if [$# -lt 1]
then
    echo "provide a file/dir/user/group"
    echo " usage: $0 [dir-name]
    exit 99
fi    
file/directry = $1  # variable # and it can be $1,$2,$3 for different variable

if [-f $file/directry]  or [-d file/directry]
then
    echo "file exist"
else
    echo "file does not exit ,creat it"
    sudo touch $file/directry
    ls /etc/log/message
    sudo echo "we live togeether" > $file/directry
    cat $file/directry
fi 










#how to get information from ppl
echo "enter ur age:  "
read Age      # the read enable the user to read our question and the variable Age is to store the answer that was enter

# Validate that the input is a number
if ! [[ "$Age" =~ ^[0-9]+$ ]] 2>/dev/null    # OR [-Z $Age] || ! [$Age -eq $Age]  # the 2> is just to remove the unwanted message 
then
    echo "Only numbers are allowed"
     exit 1
fi 

   #validate to check if something was enter 
if [-z $Age]
 then
     echo "Age is required"
     exit 1
fi    

if ["$Age" -ge 22]
then
     echo "welcome to the club"
else
    echo "you are not allow in the club"
fi         


echo "enter ur age:  "
read Age      # the read enable the user to read our question and the variable Age is to store the answer that was enter

if ["$Age" -ge 22 ] &&  ["$Age" -lt 90] #OR THIS  ["$Age" -ge 22 -a "$Age" -lt 90]   # it shld not be less than 22 or greater than 90
then
     echo "welcome to the club"
elif ["$Age" -ge 90] 
then     
   echo "please use the left door"
elif [$Age -lt 10]  
then
    echo "take a seat outside"
  
else    
   echo "you are not allow in the club"
fi  




!#/bin/bash
echo $1 # first variable (agurment)
echo $2 #second variable(agurment)
echo $3 # third variable ..... etc(arguement)
echo $# it will give us the total number of agurment 
echo $@ it will list all the argument will enter
echo $0 it will tell you the name of the script file






