#Q1: Initialisation de la matrice de transition
x=matrix(data=c(0.2, 0.4, 0, 0.4, 0, 0, 0, 0, 0, 
                4/15, 0.2, 4/15, 0, 4/15, 0, 0, 0, 0,
                0, 0.4, 0.2, 0, 0, 0.4, 0, 0, 0, 
                4/15, 0, 0, 0.2, 4/15, 0, 4/15, 0, 0,
                0, 0.2, 0, 0.2, 0.2, 0.2, 0, 0.2, 0,
                0, 0, 4/15, 0, 4/15, 0.2, 0, 0, 4/15,
                0, 0, 0, 0.4, 0, 0, 0.2, 0.4, 0,
                0, 0, 0,0, 4/15, 0, 4/15, 0.2, 4/15,
                0, 0, 0, 0, 0, 0.4, 0, 0.4, 0.2), nrow=9, ncol=9, byrow=TRUE)

#Q2: Trajectoire de la souris dans l'intervalle [0, 100]
state <- rep(0, 101)
state[1] <- 4
for (i in 1:100){
  state[i+1] = sample(seq(1,9),1,prob=c(x[state[i],]),replace=TRUE)
}

  #Q3: Cas 5 : Estimation: temps 100, proba etat = 5
  state <- rep(0, 101)
  historic <- rep(0, 100)
  state[1] <- 4
  for (i in 1:10000){
    for (j in 1:100){
      state[j+1] <- sample(seq(1,9),1,prob=c(x[state[j],]),replace=TRUE)
    }
    historic[i] <- state[101]
  }
  count <- 0
  for (i in 1:10000){
    if (historic[i] == 5){
      count <- count + 1
    }
  }
  count <- count / 10000
  print(count)
  
  #Q3: Cas 5: Calcul analytique
  Produit <- x
  for (i in 1:100){
    Produit <- Produit %*% x
  }
  print (Produit[4,5])
  
  
  #Q3: Cas 9 : Estimation: temps 100, proba etat = 9
  state <- rep(0, 101)
  historic <- rep(0, 100)
  state[1] <- 4
  for (i in 1:10000){
    for (j in 1:100){
      state[j+1] <- sample(seq(1,9),1,prob=c(x[state[j],]),replace=TRUE)
    }
    historic[i] <- state[101]
  }
  count <- 0
  for (i in 1:10000){
    if (historic[i] == 9){
      count <- count + 1
    }
  }
  count <- count / 10000
  print (count)
  
  #Q3: Cas 9: Calcul analytique
  Produit <- x
  for (i in 1:100){
    Produit <- Produit %*% x
  }
  print (Produit[4, 9])

  
  
#Temps moyen où bout duquel la souris est dans l'état 3
historic <- rep(0, 10000)
for (i in 1:10000) {
  time = 0
  state <- 4
  while (state != 3){
    state <- sample(seq(1,9),1,prob=c(x[state,]),replace=TRUE);
    time <- time + 1;
  }
  historic[i] <- time
}
mean(historic)

#Proba que la souris passe dans l'état 9 avant l'état 3
state <- rep(0, 101)
count <- 0
for (i in 1:10000) {
  state <- 4
  while (state != 3){
    state <- sample(seq(1,9),1,prob=c(x[state,]),replace=TRUE);
    if(state == 9)
      count <- count + 1;
  }
}
count <- count / 10000
print(count)

#Estimation de la probabilité
count <- 0
for (i in 1:10000){
  if (historic[i] == 9){
    count <- count + 1
  }
}
count <- count / 10000
print (count)

#Q6 - Estimation de toutes les probas
Produit <- x
for (i in 1:100){
  Produit <- Produit %*% x
}
print (Produit[4,1])
print (Produit[4,2])
print (Produit[4,3])
print (Produit[4,4])
print (Produit[4,5])
print (Produit[4,6])
print (Produit[4,7])
print (Produit[4,8])
print (Produit[4,9])


