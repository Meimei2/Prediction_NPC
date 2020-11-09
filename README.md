# Prediction_NPC
Prediction subtypes for nasopharyngeal carcinoma using random forest prediction model 

##File needed
1.TPM matrix with sample in columns and gene symbols in rows just like example.txt in provided data diretory;
2.path to the provided data directory;
3.install "mlbench" & "caret" R package previously.

##Usage
Rscript prediction.R matrix path/to/data

#File in data directory
example.txt:example TPM matrix;
example_results.txt:prediction results of example data;
genused.txt:Gene symbol needed for prediction;
rf_model.Rdata:The key random forest prediction model.
