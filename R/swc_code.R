# SWC R practice exercises
# January 5-6, 2015

#using assignment operators

#ex:
x<-5
x

#practice:
surveys<-read.csv(file="surveys.csv")
dim(surveys)
head(surveys)
#note: surveys<-read.csv(file="surveys.csv") will give you the same result; however it is not good programming practice

#if  you can't quite remember the command, you could search the help function
help.search("kruskal")

#reading in multiple data:
#just one:
in2<-read.csv(file="inflammation-02.csv", header=FALSE)
class(in2)      #what type of file you have
in2[31, 2]      #what was patient 30 doing on day 2?
in2[,2] #all of the patients on day 2
in2[1:4, 1:5] #patients 1-4, on days 1-5

#basic stats:

mean(in2[,7])   #mean value of all patients on day 7
min(in2[,7])    #minimum value

#across all days, across all patients:
avg_day_inflam<-apply(in2, MARGIN=2, mean)    #data, margin=going down a column, and then your function; read into an object (or vector)
avg_day_inflam
plot(avg_day_inflam)

max_day_inflam<-apply(in2, MARGIN=2, max)
plot(max_day_inflam)
min_day_inflam<-apply(in2, MARGIN=2, min)
plot(min_day_inflam)
sd_day_inflam<-apply(in2, MARGIN=2, sd)
plot(sd_day_inflam)

#basic functions:

#ex:
#define function
fahr_to_kelvin<-function(temp){
  kelvin<-(temp-32)*(5/9)+273.15
  return(kelvin)
}
#use function:
fahr_to_kelvin(7)
fahr_to_kelvin(32)

#ex2:
k_to_cels<-function(temp){
  cels<-temp-273.15
  return(cels)
}
k_to_cels(300)

#combining the two functions:
fahr_to_celsius<-function(temp){
  temp_k<-fahr_to_kelvin(temp)
  celsius<-(k_to_cels(temp_k))
  return(celsius)
}

#another function example:
vec<-c(1,2,3)   #a vector of three numbers
vec<-c("1", "2", "3") #a vector of number characters
best_practice<-c("write", "programs", "for", "people", "not", "computers")
#now want to put asterisks on each side of these?
asterisk<-"***"
#now create a function to do this:
new<-c(best_practice, asterisk)
new     #this is what you want to do

fence<-function(original, wrapper){
  result<-c(wrapper, original, wrapper)
  return(result)
}

fence(best_practice, asterisk)
#test it:
star<-"*"
fence(best_practice, star)

length(best_practice) #gives number of vectors??

#now, deal with real data and do a practical function
#want to create a function of four plots, with each of the previous summary stats we did
#takes file name as an argument, then display it
analyze<-function(file){
  file<-read.csv(file=file, header=FALSE)
  min<-apply(file, MARGIN=2, min) 
  max<-apply(file, MARGIN=2, max)
  mean<-apply(file, MARGIN=2, mean)
  par(mfrow=c(3,1))
  plot(min)
  plot(max)
  plot(mean)
}
analyze("inflammation-04.csv")

#now, to loop them:
#ex using best_practice:
length(best_practice)  #now make this a loop?
len<-0
for(v in best_practice){
  len<-len+1
}
len
#for each vector, go over one...

#another example:
values<-c(1,2,3)
values
#can you get these to loop?

mysum<-function(vec){
  total=0
  for (v in vec){
    total=total+v
  }
  return(total)
}
#v stands for anything you want (it is an element)
mysum(values)

##now, do this with your real data:
#creating a loop to batch analyze data:
list.files(pattern="csv")    #this will list all files with a pattern of csv
list.files(pattern="^inflammation(*)\\.csv$")     #read in all files that start with inflam and end with csv
list.files(pattern="^inflammation.+csv$")     #same thing, if you do not want to have the . in your identifier
  # ^=must be at the beginning
  # $=this is the ending
  # .+= * in R
filenames<-list.files(pattern="inflammation")   #read in all of your files

#now loop it:
for (f in filenames){
  print(f)
  analyze(f)
}


##now, write a function called analyze.all, that takes the file name pattern and does the analyze all
analyze.all<-function(batch){
  filenames<-list.files(pattern=batch)
  for (f in filenames){
    print(f)
    analyze(f)
  }
}
analyze.all("inflammation")


#test modification
#test again
