wheel<- c("DD","7","BBB","BB","B","C","0")
combos <- expand.grid(wheel,wheel,wheel,stringsAsFactors = FALSE)

prob <- c("DD"=0.03,"7"=0.03,"BBB"=0.06,"BB"=0.1,"B"=0.25,"C"=0.01,"0"=0.52)

combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]

combos$prob = combos$prob1 * combos$prob2 * combos$prob3
wheel <- c("DD","7","BBB","BB","B","C","0")

combos$prize <- NA
for(i in 1:nrow(combos)){
  symbols <- c(combos[i,1],combos[i,2],combos[i,3])
  combos$prize[i] <- score(symbols)
}
head(combos,3)

sum(combos$prize * combos$prob)

score <- function(symbols){
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B","BB","BBB")
  #assign prize
  if(diamonds == 3){
    prize <- 100
  } else if(same){
    payouts <- c("7"=80,"BBB"=40,"BB"=25,"B"=10,"C"=10,"0"=0)
    prize <- unname(payouts[slots[1]])
  } else if(all(bars)){
    prize <- 5
  } else if(cherries > 0){
    prize <- c(0,2,5)[cherries + diamonds + 1]
  } else {
    prize <- 0
  }
  #double the prize for each diamond
  prize * 2^diamonds  
}



