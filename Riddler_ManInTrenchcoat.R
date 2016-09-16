#########################################
# 538's Riddler - Man in the Trenchcoat #
#########################################
# A man in a trench coat approaches you and pulls an envelope from his pocket. 
# He tells you that it contains a sum of money in bills, anywhere from $1 up to $1,000. 
# He says that if you can guess the exact amount, you can keep the money. After each of 
# your guesses he will tell you if your guess is too high, or too low. But! You only get 
# nine tries. What should your first guess be to maximize your expected winnings?


n<-100000
ok<-data.frame(Guessed=rep(NA,n),Initial_Guess=rep(NA,n),Actual_Amt=rep(NA,n))
for(i in 1:n){
  amt<-sample(1:1000,1)
  init_guess<-guess<-sample(1:1000,1)
  j<-1
  yep<-FALSE
  up_lim<-1000
  low_lim<-0
  
  while(j<=9){
    if(guess == amt){
      yep<-TRUE
      break
      }
    else if(guess < amt){
      low_lim<-guess
      guess<-round(mean(c(low_lim,up_lim)))
      }
    else if(guess > amt){
      up_lim<-guess
      guess<-round(mean(c(low_lim,up_lim)))
      }
    j<-j+1
    }
  ok[i,]<-c(yep,init_guess,amt)
}


sum(ok[,1])
mean(ok[ok[,1]==1,2])

hist(ok[ok[,1]==1,2],breaks=100)

plot(table(ok[ok[,1]==1,2])/n,type="l")
plot((table(ok[ok[,1]==1,2])/n)*as.numeric(names(table(ok[ok[,1]==1,2]))))

cbound<-cbind(as.numeric(names(table(ok[ok[,1]==1,2]))),(table(ok[ok[,1]==1,2])/n)*as.numeric(names(table(ok[ok[,1]==1,2]))))
cbound[cbound[,2]==max(cbound[,2]),]

# answers gotten from running this sim multpile times: 760, 746, 771, 743, 756
# actual answer (from 538's site answer) is 745





plot(1:1000,table(ok[ok[,1]==1,2]))

plot(smooth.spline(table(ok[ok[,1]==1,2])/1000,nknots=20),type="l")
