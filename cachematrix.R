################################################################################
##                              cachematrix.R  
##
## Provides a pair of functions that give the user a matrix with a cached-inverse,
## for use in those cases where this will provide a speed advantage.
## (ie: the inverse will be needede more than once)
################################################################################

## When given a matrix, this routine returns a list-object containing it along 
## with the cached inverse
makeCacheMatrix <- function(x = matrix()) {
   cachedInverse <<- NULL
   matrix <- x
   list(matrix = matrix, cachedInverse = cachedInverse)
}

## For the given list-object, this routine returns the cached-inverse if it is available.
## If not, it computes the inverse, caches it, and returns the inverse.
cacheSolve <- function(listObj = list(), ...) {
   if (is.null(cachedInverse)) {
      message("computing the inverse!")
      cachedInverse <<- solve(listObj$matrix)
   }
   return(cachedInverse)
}

################################################################################
## to test:
##
## > A <- matrix( c(2, 4, 3, 1), nrow=2, ncol = 2, byrow = TRUE)
## > B <- makeCacheMatrix(A)
## > A %*% cacheSolve(B)
##   computing the inverse!
##   [,1] [,2]
##   [1,]    1    0
##   [2,]    0    1
## > A %*% cacheSolve(B)
##   [,1] [,2]
##   [1,]    1    0
##   [2,]    0    1
##
################################################################################
