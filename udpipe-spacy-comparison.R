library(udpipe)
library(spacyr)
library(data.table)

##############################################################################################
## UD_French-Sequoia
##  + Evaluation data from https://github.com/UniversalDependencies/UD_French-Sequoia
##  + udpipe + spacy were trained on the same data
##  + Note: no xpos in this treebank
##############################################################################################
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_French-Sequoia/master/fr_sequoia-ud-test.conllu", 
              destfile = "gold.conllu")

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "french-sequoia", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "fr", python_executable = "C:/Users/Jan/Anaconda3/python.exe")
names(sentences) <- sprintf("%s %s", seq_along(sentences), sentences)
x <- spacy_parse(sentences, pos = TRUE, tag = TRUE, lemma = TRUE, dependency = TRUE, entity = FALSE)
sum(duplicated(x[, c("doc_id", "sentence_id", "token_id")]))
x$sentence <- x$doc_id
x$feats <- sapply(strsplit(x$tag, "__"), FUN=function(x) if(length(x) == 1) return(NA) else tail(x, 1))
x$upos <- x$pos
x$dep_rel <- txt_recode(x$dep_rel, from = "ROOT", to = "root")
x$head_token_id <- ifelse(x$dep_rel == "root", 0, x$head_token_id)
cat(as_conllu(x), file = file("predictions_spacy.conllu", encoding = "UTF-8"))
spacy_finalize()

## Compare evaluations
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")

##############################################################################################
## UD_Dutch
##  + Evaluation data from https://github.com/UniversalDependencies/UD_Dutch
##  + udpipe + spacy were trained on the same data
##  + Note: spacy seems to have completely changed the content of xpos or was it built on a historical conllu file?
##############################################################################################
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_Dutch/master/nl-ud-dev.conllu", 
              destfile = "gold.conllu")

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "dutch", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "nl", python_executable = "C:/Users/Jan/Anaconda3/python.exe")
names(sentences) <- sentences
x <- spacy_parse(sentences, pos = TRUE, tag = TRUE, lemma = TRUE, dependency = TRUE, entity = FALSE)
sum(duplicated(x[, c("doc_id", "sentence_id", "token_id")]))
x$sentence <- x$doc_id
x$xpos <- sapply(strsplit(x$tag, "__"), FUN=function(x) head(x, 1))
x$feats <- sapply(strsplit(x$tag, "__"), FUN=function(x) if(length(x) == 1) return(NA) else tail(x, 1))
x$upos <- x$pos
x$dep_rel <- txt_recode(x$dep_rel, from = "ROOT", to = "root")
x$head_token_id <- ifelse(x$dep_rel == "root", 0, x$head_token_id)
cat(as_conllu(x), file = file("predictions_spacy.conllu", encoding = "UTF-8"))
spacy_finalize()

## Compare evaluations
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")


##############################################################################################
## UD_Spanish-Ancora
##  + Evaluation data from https://github.com/UniversalDependencies/UD_Spanish-Ancora
##  + udpipe + spacy were trained on the same data
##############################################################################################
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_Spanish-Ancora/master/es_ancora-ud-test.conllu", 
              destfile = "gold.conllu")

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "spanish-ancora", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "es", python_executable = "C:/Users/Jan/Anaconda3/python.exe")
names(sentences) <- sprintf("%s %s", seq_along(sentences), sentences)
x <- spacy_parse(sentences, pos = TRUE, tag = TRUE, lemma = TRUE, dependency = TRUE, entity = FALSE)
sum(duplicated(x[, c("doc_id", "sentence_id", "token_id")]))
x$sentence <- x$doc_id
x$xpos <- sapply(strsplit(x$tag, "__"), FUN=function(x) head(x, 1))
x$feats <- sapply(strsplit(x$tag, "__"), FUN=function(x) if(length(x) == 1) return(NA) else tail(x, 1))
x$upos <- x$pos
x$dep_rel <- txt_recode(x$dep_rel, from = "ROOT", to = "root")
x$head_token_id <- ifelse(x$dep_rel == "root", 0, x$head_token_id)
cat(as_conllu(x), file = file("predictions_spacy.conllu", encoding = "UTF-8"))
spacy_finalize()

## Compare evaluations
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")


##############################################################################################
## UD_Portuguese
##  + Evaluation data from https://github.com/UniversalDependencies/UD_Portuguese
##  + udpipe + spacy were trained on the same data
##  + Note: spacy does not return morphological features
##############################################################################################
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_Portuguese/master/pt-ud-test.conllu", 
              destfile = "gold.conllu")

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "portuguese", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "pt", python_executable = "C:/Users/Jan/Anaconda3/python.exe")
names(sentences) <- sprintf("%s %s", seq_along(sentences), sentences)
x <- spacy_parse(sentences, pos = TRUE, tag = TRUE, lemma = TRUE, dependency = TRUE, entity = FALSE)
sum(duplicated(x[, c("doc_id", "sentence_id", "token_id")]))
x$sentence <- x$doc_id
x$xpos <- x$tag
x$upos <- x$pos
x$dep_rel <- txt_recode(x$dep_rel, from = "ROOT", to = "root")
x$head_token_id <- ifelse(x$dep_rel == "root", 0, x$head_token_id)
cat(as_conllu(x), file = file("predictions_spacy.conllu", encoding = "UTF-8"))
spacy_finalize()

## Compare evaluations
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")


##############################################################################################
## UD_English: 
##  + Evaluation data from https://github.com/UniversalDependencies/UD_English
##  + udpipe was trained on UD_English while spacy was trained on OntoNotes which is a different treebank than the udpipe model which makes comparison tricky
##  + Note: spacy does not return morphological features + it seems that dependency relationships do not follow the same format as universaldependencies.org
##############################################################################################
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_English/master/en-ud-dev.conllu", 
              destfile = "gold.conllu")

## having problems with the output of spacyr which does unexpected things on strange characters, make them ASCII for now - it is English so that won't matter
gold <- readLines("gold.conllu", encoding = "UTF-8")
gold <- iconv(gold, from = "UTF-8", to = "ASCII//TRANSLIT", sub = "?")
gold <- gsub("\\\\", "//", gold)
writeLines(gold, con = file("gold.conllu", encoding = "UTF-8"))
gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "english", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "en", python_executable = "C:/Users/Jan/Anaconda3/python.exe")
names(sentences) <- sprintf("%s %s", seq_along(sentences), sentences)
x <- spacy_parse(sentences, pos = TRUE, tag = TRUE, lemma = TRUE, dependency = TRUE, entity = FALSE)
sum(duplicated(x[, c("doc_id", "sentence_id", "token_id")]))
x$sentence <- x$doc_id
x$xpos <- x$tag
x$upos <- x$pos
x$dep_rel <- txt_recode(x$dep_rel, from = "ROOT", to = "root")
x$head_token_id <- ifelse(x$dep_rel == "root", 0, x$head_token_id)
cat(as_conllu(x), file = file("predictions_spacy.conllu", encoding = "UTF-8"))
spacy_finalize()

## Compare evaluations
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")

##############################################################################################
## UD_Italian
##  Not doing this as license seems to be incorrect from spacy: https://github.com/explosion/spaCy/issues/1865
##############################################################################################
