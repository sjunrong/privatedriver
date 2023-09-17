load('data/aberrant_gens.rdata')
load('data/diffmirna_diffmrna.rdata')
load('networks/Maximal_FI.rdata')
diffusion=function(inter_FI,diffusion_matrix)
{degree=rowSums(inter_FI)
b=0.5
W=matrix(0,nrow=nrow(inter_FI),ncol = ncol(inter_FI),dimnames = list(row.names(inter_FI),colnames(inter_FI)))
for(i in 1:nrow(inter_FI))
{
  for(j in 1:ncol(inter_FI))
  {
    if(inter_FI[i,j]!=0)
    {
      W[i,j]=1/degree[i]
    }
  }
}
temp=diag(rep(1,nrow(W)))-(1-b)*W
F=b*solve(temp)
muts=c()
if(length(which(rowSums(diffusion_matrix)==0))>0)
{
  diffusion_matrix=diffusion_matrix[-which(rowSums(diffusion_matrix)==0),]
}
for(i in 1:nrow(diffusion_matrix))
{
  positions=which(diffusion_matrix[i,]!=0)
  mutation_weights=matrix(rep(1/length(positions),length(positions)),ncol=length(positions),byrow=F)%*%F[positions,]
  muts=rbind(muts,mutation_weights)
}
row.names(muts)=row.names(diffusion_matrix)
muts
}

diff_matrix1=diff_matrix[intersect(row.names(diff_matrix),colnames(aberrant_gens)),intersect(colnames(diff_matrix),row.names(aberrant_gens))]
aberrant_gens1=aberrant_gens[intersect(colnames(diff_matrix),row.names(aberrant_gens)),intersect(row.names(diff_matrix),colnames(aberrant_gens))]
diffusion_matrix=aberrant_gens1+t(diff_matrix1)
diffusion_matrix[which(diffusion_matrix==1)]=0
diffusion_matrix[which(diffusion_matrix==2)]=1
inter_FI=PPI1[intersect(colnames(PPI1),colnames(diffusion_matrix)),intersect(colnames(PPI1),colnames(diffusion_matrix))]
diffusion_matrix=diffusion_matrix[,intersect(row.names(inter_FI),colnames(diffusion_matrix))]
muts1=diffusion(inter_FI,diffusion_matrix)

inter_FI1=PPI1[intersect(colnames(PPI1),row.names(diff_matrix)),intersect(colnames(PPI1),row.names(diff_matrix))]
diff_matrix=diff_matrix[intersect(row.names(diff_matrix),row.names(inter_FI1)),]
diff_matrix=t(diff_matrix)
inter_FI1=t(inter_FI1)
diffs1=diffusion(inter_FI1,diff_matrix)

diffs1=diffs1[intersect(row.names(diffs1),row.names(muts1)),intersect(colnames(diffs1),colnames(muts1))]
muts1=muts1[intersect(row.names(diffs1),row.names(muts1)),intersect(colnames(diffs1),colnames(muts1))]
gene_matrix=diffs1*muts1