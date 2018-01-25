This uses the CONLL-U evaluation script available at http://universaldependencies.org/conll17/eval.zip to make a comparison regarding accuracy between UDPipe models and Spacy models which are trained on the same treebanks. 

- It does this for French (Sequioa treebank), Dutch (UD_Dutch treebank), Spanish (Ancora treebank), Portuguese (UD_Portuguese treebank) and English. 
- The models were trained on the same treebanks except for English. Only for English the models of udpipe are constructed on a different treebank (UD_English) than the model which was built by spacy (Ontonotes).
- Training for the udpipe models is openly available at https://github.com/bnosac/udpipe.models.ud. For the spacy models, we took the models currently available for download as in python -m spacy download es (spaCy Version: 2.0.5).
- Code was run on 25/01/2018. 

Below the output is reported from the CONLL17 evaluation scripts for the udpipe and spacy models. 
The most used results are the one from AligndAcc which indicates Gold accuracies which means that if we know the tokenisation, how good would the parts-of-speech tagging, morphological feature tagging and dependency parsing be.

# French Sequioa

Evaluation data from https://github.com/UniversalDependencies/UD_French-Sequoia

Notes: This treebank does not contain xpos so measures of XPOS are irrelevant.

## udpipe

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     99.80 |     99.83 |     99.82 |
Sentences  |     96.55 |     98.25 |     97.39 |
Words      |     98.87 |     99.34 |     99.11 |
UPOS       |     95.75 |     96.21 |     95.98 |     96.84
XPOS       |     98.87 |     99.34 |     99.11 |    100.00
Feats      |     94.82 |     95.27 |     95.05 |     95.90
AllTags    |     93.78 |     94.23 |     94.00 |     94.85
Lemmas     |     96.77 |     97.23 |     97.00 |     97.88
UAS        |     84.61 |     85.01 |     84.81 |     85.58
LAS        |     81.77 |     82.16 |     81.96 |     82.70
```

## spacy

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     97.53 |     98.80 |     98.16 |
Sentences  |     78.49 |     88.82 |     83.33 |
Words      |     94.41 |     92.69 |     93.54 |
UPOS       |     90.43 |     88.79 |     89.60 |     95.79
XPOS       |     94.41 |     92.69 |     93.54 |    100.00
Feats      |     89.68 |     88.05 |     88.86 |     95.00
AllTags    |     88.10 |     86.50 |     87.29 |     93.32
Lemmas     |     80.52 |     79.05 |     79.78 |     85.29
UAS        |     75.71 |     74.33 |     75.01 |     80.19
LAS        |     71.32 |     70.02 |     70.66 |     75.54
```

# Dutch

Evaluation data from https://github.com/UniversalDependencies/UD_Dutch

Notes: Spacy seems to have completely changed the content of xpos/morphological features or was it built on a historical conllu file?

## udpipe

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     99.72 |     99.61 |     99.67 |
Sentences  |     93.93 |     96.94 |     95.41 |
Words      |     99.72 |     99.61 |     99.67 |
UPOS       |     95.17 |     95.06 |     95.11 |     95.43
XPOS       |     92.50 |     92.39 |     92.44 |     92.75
Feats      |     93.95 |     93.85 |     93.90 |     94.22
AllTags    |     91.61 |     91.51 |     91.56 |     91.87
Lemmas     |     96.10 |     95.99 |     96.04 |     96.36
UAS        |     82.76 |     82.67 |     82.72 |     82.99
LAS        |     79.11 |     79.02 |     79.07 |     79.33
```

## spacy

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     96.44 |     98.55 |     97.48 |
Sentences  |     81.72 |     90.25 |     85.77 |
Words      |     96.44 |     98.55 |     97.48 |
UPOS       |     75.20 |     76.85 |     76.01 |     77.98
XPOS       |      0.00 |      0.00 |      0.00 |      0.00
Feats      |     13.05 |     13.34 |     13.19 |     13.53
AllTags    |      0.00 |      0.00 |      0.00 |      0.00
Lemmas     |     72.97 |     74.57 |     73.76 |     75.66
UAS        |     72.51 |     74.10 |     73.30 |     75.19
LAS        |     62.75 |     64.13 |     63.43 |     65.07
```

# Spanish-Ancora

Evaluation data from https://github.com/UniversalDependencies/UD_Spanish-Ancora

Notes: None

## udpipe

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     99.97 |     99.98 |     99.97 |
Sentences  |     98.73 |     99.36 |     99.04 |
Words      |     99.96 |     99.95 |     99.96 |
UPOS       |     98.15 |     98.14 |     98.14 |     98.18
XPOS       |     98.15 |     98.14 |     98.14 |     98.18
Feats      |     97.57 |     97.57 |     97.57 |     97.61
AllTags    |     96.90 |     96.89 |     96.89 |     96.93
Lemmas     |     98.06 |     98.05 |     98.05 |     98.09
UAS        |     87.50 |     87.49 |     87.49 |     87.53
LAS        |     84.43 |     84.42 |     84.42 |     84.46
```

## spacy

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     99.23 |     99.69 |     99.46 |
Sentences  |     98.44 |     99.24 |     98.84 |
Words      |     98.88 |     98.99 |     98.93 |
UPOS       |     94.23 |     94.34 |     94.28 |     95.30
XPOS       |     96.96 |     97.08 |     97.02 |     98.06
Feats      |     96.53 |     96.64 |     96.58 |     97.62
AllTags    |     93.02 |     93.12 |     93.07 |     94.07
Lemmas     |     80.20 |     80.29 |     80.24 |     81.11
UAS        |     86.67 |     86.77 |     86.72 |     87.66
LAS        |     83.96 |     84.06 |     84.01 |     84.92
```

# Portuguese

Evaluation data from https://github.com/UniversalDependencies/UD_Portuguese

Notes: spacy does not return morphological features resulting in incorrect evaluation numbers for spacy on Feats and AllTags

## udpipe

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     99.70 |     99.70 |     99.70 |
Sentences  |     94.90 |     97.48 |     96.17 |
Words      |     99.53 |     99.63 |     99.58 |
UPOS       |     96.29 |     96.38 |     96.34 |     96.74
XPOS       |     72.95 |     73.02 |     72.99 |     73.30
Feats      |     93.40 |     93.49 |     93.45 |     93.84
AllTags    |     71.81 |     71.89 |     71.85 |     72.15
Lemmas     |     96.84 |     96.93 |     96.88 |     97.29
UAS        |     85.76 |     85.84 |     85.80 |     86.17
LAS        |     82.48 |     82.56 |     82.52 |     82.87
```

## spacy

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     95.32 |     98.10 |     96.69 |
Sentences  |     87.50 |     93.92 |     90.60 |
Words      |     90.32 |     86.21 |     88.22 |
UPOS       |     82.41 |     78.65 |     80.48 |     91.23
XPOS       |     60.34 |     57.59 |     58.94 |     66.81
Feats      |     30.47 |     29.09 |     29.76 |     33.74
AllTags    |     24.23 |     23.13 |     23.66 |     26.83
Lemmas     |     74.53 |     71.13 |     72.79 |     82.51
UAS        |     72.51 |     69.21 |     70.82 |     80.28
LAS        |     68.10 |     64.99 |     66.51 |     75.39
```

# English (mark udpipe trained on UD_English, spacy was trained on Ontonotes)

Evaluation data from https://github.com/UniversalDependencies/UD_English

Notes:

- udpipe was trained on UD_English while spacy was trained on OntoNotes which is a different treebank than the udpipe model which makes comparison tricky
- spacy does not return morphological features + it seems that dependency relationships do not follow the same format as universaldependencies.org giving probably false evaluation metrics on UAS and LAS

## udpipe

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     99.13 |     98.91 |     99.02 |
Sentences  |     94.57 |     97.35 |     95.94 |
Words      |     99.13 |     98.91 |     99.02 |
UPOS       |     93.76 |     93.55 |     93.65 |     94.58
XPOS       |     93.11 |     92.91 |     93.01 |     93.93
Feats      |     94.56 |     94.35 |     94.46 |     95.39
AllTags    |     91.69 |     91.49 |     91.59 |     92.50
Lemmas     |     96.20 |     95.99 |     96.10 |     97.05
UAS        |     82.39 |     82.21 |     82.30 |     83.12
LAS        |     79.07 |     78.90 |     78.99 |     79.77
```

## spacy

```
> system("python conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")
Metrics    | Precision |    Recall |  F1 Score | AligndAcc
-----------+-----------+-----------+-----------+-----------
Tokens     |     96.21 |     98.23 |     97.21 |
Sentences  |     89.37 |     94.96 |     92.08 |
Words      |     96.21 |     98.23 |     97.21 |
UPOS       |     79.89 |     81.56 |     80.71 |     83.03
XPOS       |     89.43 |     91.30 |     90.35 |     92.95
Feats      |     32.39 |     33.07 |     32.73 |     33.67
AllTags    |     27.38 |     27.95 |     27.67 |     28.46
Lemmas     |     81.55 |     83.26 |     82.39 |     84.76
UAS        |     55.58 |     56.74 |     56.16 |     57.77
LAS        |     41.78 |     42.65 |     42.21 |     43.42
```

# Italian

Not executed as license seems to be incorrect from spacy: https://github.com/explosion/spaCy/issues/1865

# German

Not executed as built on different treebank
