# privatedriver
privatedriver is the first model for identifying subtype-specific driver genes that integrates genomics data from multiple institutional in a data privacy-preserving collaboration manner. It extends NMF to a federated learning framework by aggregating patient-specific gradients from multiple institutions to update the master model. It leverages the complementary patient information contained in multiple institutional datasets to improve the driver gene identification performance while avoiding privacy leakage. Running The operation of privatedriver involves two key steps: multi-genomic data integration and collaborative training across institutions.
1. Multigenomics data integration
   Input data arguments:
   a.load('data/aberrant_gens.rdata'): the combination of abberant genes.
   b.load('data/diffmirna_diffmrna.rdata'): the mRNAs which have been reglated by miRNAs.
   c.load('networks/Maximal_FI.rdata'):the generated networks with three sources.
   Running the diffusion_combine.R
Output data：
   gene_matrix:row is patient, column is genes, each entry is the diffusion score of patient i to gene j.
2. After generating the gene_matrix through the diffusion process, the non-negative matrix factorization model is trained collaboratively using federated learning. This federated learning approach leverages the Fate 1.40 framework, which can be downloaded from an online source (https://webank-ai-1251170195.cos.ap-guangzhou.myqcloud.com/docker_standalone-fate-1.4.0.tar.gz). The privatedriver is deployed in standalone mode via Docker. Fate 1.40 supports six classical recommendation algorithms, including the matrix factorization method utilized in this study. We enhanced the original matrix factorization code by incorporating non-negative constraints and adjusting parameters in the configuration file, dsl. The specific changes are outlined below:
 a.Added the parameter "embeddings_constraint=non_neg()" in the user and item Embedding function() of the backend.py file to ensure non-negative training.
 b.Configured the test_hetero_fm_train_job_conf file with multiple different guest IDs.
 c.Adjusted the parameter "cluster number of nsplit" based on the optimal cophenetic distance.
 d.Set the parameters as follows:
     "max_iter" to 1000
     "converge_func" to "diff"
     "batch_size" to "all"
     "optimizer" to "sgd"
     "penalty" to "L2"
These modifications enable the collaborative training of the non-negative matrix factorization model, providing improved performance and capabilities for your research.


