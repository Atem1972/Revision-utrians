

### for loop

ex1
for item  in 'serge':      # we can still say  , for i in 'serge':
                                             #   print(i)    
    print(item)   ## this will run 5 time in a row , it will run first time creat value s, second time create value e  till it finish

ex2
for col in ['red','black','orang','yellow']:
    print('col')  # first it will print red,black,orang,yellow

ex3
for col in ['red','black','orang','yellow']:  
   if len(col)< 4:  # this condition means go to my list of colour above loop through it pick for me colour with less than 4 letters
       print(col)   # output red

 ex4
for col in ['red','black','orang','yellow']:  
   if len(col)< 4:  # this condition means go to my list of colour above loop through it pick for me colour with less than 4 letters
       Winning_color=col   # here will just declear a new variable for the output 'red'
       print(Winning_color)   # output red      


ex5
 d= ['f','l','fd', 'sfd']     
 e= []
 for i in d:
    e.appen(i.upper())
print(e)      


ex
go to the variable student if u see any names 'atem valery' 'besong' remove them from that list
go to this variable call emaill send this file to email having .net in it



### while loop ()true or false

ex
count =0
while count < 6:
   print("hello") # output infinit
#to break out of the loop add  count+=1


#how to get out of a loop

count =0
while count < 6:
   print("hello") 
   if count == 2:
      break      ## we can use <continue> instead of break if will want to keep looping 
   count+=1

