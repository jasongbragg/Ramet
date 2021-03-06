#' Mutate a vector of genotypes
#'
#' @param gv - a vector of genotypes, in 0, 1, 2 format [Required]
#' @param het2hom - mutation rate het to hom
#' @param het2hom - mutation rate hom to het
#' @param het2hom - mutation rate hom to hom
#' @return a list consisting of two matrices 
#' @author Jason Bragg (jasongbragg@gmail.com)
#' @export
mutate_genotypes <- function(gv, het2hom=0.01, hom2het=0.001, hom2hom=0.001) {

   ngv <- gv

   igv1 <- which(gv==1)
   igv0 <- which(gv==0)
   igv2 <- which(gv==2)

   # 1 to 0 or 2
   if (length(igv1 >=1 )) {
      nums_het2hom_02 <- rbinom(2,length(gv),het2hom)

      if ( sum(nums_het2hom_02) > 0 ) {
         sigv1 <- sample(igv1)

         imx0 <- nums_het2hom_02[1]
         if (imx0 > 0) {
           ngv[ sigv1[1:imx0] ] <- 0
         }

         imx2 <- nums_het2hom_02[2]
         if (imx2 > 0) {
           ngv[ sigv1[( imx0+1):(imx0+imx2) ] ] <- 2
         }

      } 
 
   }

   # 0 to 1 and 0 to 2
   if (length(igv0 >=1 )) {
      num_hom2het_01 <- rbinom(1,length(gv),hom2het)
      num_hom2hom_02 <- rbinom(1,length(gv),hom2hom)

      if ( (num_hom2het_01+num_hom2hom_02) > 0 ) {
         sigv0 <- sample(igv0)

         imx1 <- num_hom2het_01
         if (imx1 > 0) {
           ngv[ sigv0[1:imx1] ] <- 1
         }

         imx2 <- num_hom2hom_02
         if (imx2 > 0) {
           ngv[ sigv0[( imx1+1):(imx1+imx2) ] ] <- 2
         }

      } 
 
   }

   # 2 to 0 and 2 to 1
   if (length(igv2 >=1 )) {
      num_hom2het_21 <- rbinom(1,length(gv),hom2het)
      num_hom2hom_20 <- rbinom(1,length(gv),hom2hom)

      if ( (num_hom2het_21+num_hom2hom_20) > 0 ) {
         sigv2 <- sample(igv2)

         imx1 <- num_hom2het_21
         if (imx1 > 0) {
           ngv[ sigv2[1:imx1] ] <- 1
         }

         imx2 <- num_hom2hom_20
         if (imx2 > 0) {
           ngv[ sigv2[( imx1+1):(imx1+imx2) ] ] <- 0
         }

      } 
 
   }

   return(ngv)         
}
