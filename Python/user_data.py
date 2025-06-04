#user_data.py
input("what is ur name?")
To execute it run <pytho  user_data.py
- output what is ur name?

# how to take input store it in a variable then print it
ex 
Name = input("what is ur name?")
print(Name)
output what is ur name? , when the client insert his name, then the print function will display  it

ex3 #condition in input function

Name = input("what is ur name?")
print(Name)
if len(Name) <3:
 print("nName too short")  
else:
  print("Name looks good") 
run python user_data.py


# write a script to ask for email address
Email = input("input ur email")
print(Email)
if "@" in Email:      ## to check and remove space if found add <if "@" in Email.strip() 
 print("succesfull email")
else:
  print("invalite email formate") 

  #NB ALL DATA RECEIVE THROUGH INPUT COMES AS A STRING 



# how to strip a particular something from a list
ex
  Email = input("input ur email")
print(Email)
if "@" in Email.strip('%')     ## this .strip here means is and user add that charater strip it out
 print("succesfull email")
else:
  print("invalite email formate") 



  ##how to do script formating
  ex
  age = 30
  name ='sam'

  print(f"your name is: {name} and your age is: {age}") # this will take the value from the variable an put the carinbracket