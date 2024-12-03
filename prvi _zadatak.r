# SETUP
# VARIJABLE ODLUKE

#x1 - lokalni distributer
#x2 - solarna elektrana 10 KW
#x3 - solarna elektrana 30 KW
#x4 - vjetrotrubine

# OGRANIČENJA
# 10x2 + 30x3 + 1x4 >= 30 KW
# x1 + 10x2 + 30x3 + 1x4 >= 100 KW
# 79000 x2 + 195000 x3 + 8000 x4 <= 215000

# FUNKCIJA CILJA
# min((43.51 * x1) + ((79000+50)*x2) + ((195000+60)*x3)+((8000+40)*x4)+ 55.03)
# odnosno
# min(43.51 x1 + 79050 x2 + 195060 x3 + 8040 x4 + 55.03) 

# Instalacija i učitavanje lpSolve paketa
install.packages("lpSolve")
library(lpSolve)

# Definiranje ciljne funkcije
obj <- c(43.51, 79050, 195060, 8040)

# Definiranje matrice ograničenja
const_mat <- matrix(c(0, 10, 30, 1,   # 10x2 + 30x3 + x4 >= 30
              1, 10, 30, 1,   # x1 + 10x2 + 30x3 + x4 >= 100
              0, 79000, 195000, 8000), # 79000x2 + 195000x3 + 8000x4 <= 215000
            nrow=3, byrow=TRUE)

# Smjerovi ograničenja
const_dir <- c(">=", ">=", "<=")

# Desne strane ograničenja
rhs <- c(30, 100, 215000)

# Rješavanje problema linearnog programiranja
rjesenje <- lp("min", obj, const_mat, const_dir, rhs, compute.sens=TRUE)

# Prikaz rezultata
print("Optimalne vrijednosti varijabli:")
print(rjesenje$solution)
print(paste("Minimalni trošak:", rjesenje$objval))
