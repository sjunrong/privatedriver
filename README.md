# privatedriver
privatedriver is the first model for identifying subtype-specific driver genes that integrates genomics data from multiple institutional in a data privacy-preserving collaboration manner. Running privatedriver need to steps: mltigenomics data integration and collaborative traning across institutions.
1. Multigenomics data integration
   Input data arguments:
   a.load('data/aberrant_gens.rdata'): the combination of abberant genes.
   b.load('data/diffmirna_diffmrna.rdata'): the mRNAs which have been reglated by miRNAs.
   c.load('networks/Maximal_FI.rdata'):the generated networks with three sources.
   run the diffusion_combine.R
3. Collaborative training with simulated organizations
When generate the gene_matrix after diffusion. the federated learning can be empolyed to train the non-negative matrix factorization model in a collaborative manner.
The federated learning utilized the framework of Fate 1.40 which can be downloaded from online source (https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com/docker_standalone-fate-1.4.0.tar.gz). The privatedriver deployed on a standalone mode by using docker.
