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
download.file(url = "https://github.com/UniversalDependencies/UD_French-Sequoia/archive/r2.0-test.zip",
              destfile = "r2.0-test.zip")
unzip("r2.0-test.zip", list = TRUE)
unzip("r2.0-test.zip", files = "UD_French-Sequoia-r2.0-test/fr_sequoia-ud-test.conllu", exdir = getwd(), junkpaths = TRUE)
file.copy("fr_sequoia-ud-test.conllu", "gold.conllu", overwrite = TRUE)

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "french-sequoia", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_download_model(language = "french-sequoia", udpipe_model_repo = "jwijffels/udpipe.models.ud.2.0")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "fr")
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
##############################################################################################
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_Dutch/master/nl-ud-test.conllu", 
              destfile = "gold.conllu")
download.file(url = "https://github.com/UniversalDependencies/UD_Dutch/archive/r2.0-test.zip",
              destfile = "r2.0-test.zip")
unzip("r2.0-test.zip", list = TRUE)
unzip("r2.0-test.zip", files = "UD_Dutch-r2.0-test/nl-ud-test.conllu", exdir = getwd(), junkpaths = TRUE)
file.copy("nl-ud-test.conllu", "gold.conllu", overwrite = TRUE)

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "dutch", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_download_model(language = "dutch", udpipe_model_repo = "jwijffels/udpipe.models.ud.2.0")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "nl")
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
## UD_Spanish-Ancora
##  + Evaluation data from https://github.com/UniversalDependencies/UD_Spanish-Ancora
##  + udpipe + spacy were trained on the same data
##############################################################################################
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_Spanish-Ancora/master/es_ancora-ud-test.conllu", 
              destfile = "gold.conllu")
download.file(url = "https://github.com/UniversalDependencies/UD_Spanish-Ancora/archive/r2.0-test.zip",
              destfile = "r2.0-test.zip")
unzip("r2.0-test.zip", list = TRUE)
unzip("r2.0-test.zip", files = "UD_Spanish-AnCora-r2.0-test/es_ancora-ud-test.conllu", exdir = getwd(), junkpaths = TRUE)
file.copy("es_ancora-ud-test.conllu", "gold.conllu", overwrite = TRUE)

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "spanish-ancora", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_download_model(language = "spanish-ancora", udpipe_model_repo = "jwijffels/udpipe.models.ud.2.0")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "es")
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
download.file(url = "https://github.com/UniversalDependencies/UD_Portuguese/archive/r2.0-test.zip",
              destfile = "r2.0-test.zip")
unzip("r2.0-test.zip", list = TRUE)
unzip("r2.0-test.zip", files = "UD_Portuguese-r2.0-test/pt-ud-test.conllu", exdir = getwd(), junkpaths = TRUE)
file.copy("pt-ud-test.conllu", "gold.conllu", overwrite = TRUE)

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "portuguese", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_download_model(language = "portuguese", udpipe_model_repo = "jwijffels/udpipe.models.ud.2.0")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "pt")
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
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_English/master/en-ud-test.conllu", 
              destfile = "gold.conllu")
download.file(url = "https://github.com/UniversalDependencies/UD_English/archive/r2.0-test.zip",
              destfile = "r2.0-test.zip")
unzip("r2.0-test.zip", list = TRUE)
unzip("r2.0-test.zip", files = "UD_English-r2.0-test/en-ud-test.conllu", exdir = getwd(), junkpaths = TRUE)
file.copy("en-ud-test.conllu", "gold.conllu", overwrite = TRUE)

gold <- readLines("gold.conllu", encoding = "UTF-8")
gold <- gold[-c(
  grep("newsgroup-groups.google.com_n3td3v_e874a1e5eb995654_ENG_20060120_052200-0011", gold):
  (grep("newsgroup-groups.google.com_n3td3v_e874a1e5eb995654_ENG_20060120_052200-0012", gold)-1))]
writeLines(gold, con = file("gold.conllu", encoding = "UTF-8"))
gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "english", udpipe_model_repo = "bnosac/udpipe.models.ud")
ud_model <- udpipe_download_model(language = "english", udpipe_model_repo = "jwijffels/udpipe.models.ud.2.0")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "en")
names(sentences) <- sprintf("%s %s", seq_along(sentences), sentences)
x <- spacy_parse(sentences, pos = TRUE, tag = TRUE, lemma = TRUE, dependency = TRUE, entity = FALSE)
sum(duplicated(x[, c("doc_id", "sentence_id", "token_id")]))
x$sentence <- x$doc_id
x$xpos <- x$tag
x$upos <- x$pos
x$dep_rel <- txt_recode(x$dep_rel, from = "ROOT", to = "root")
x$head_token_id <- ifelse(x$dep_rel == "root", 0, x$head_token_id)
x$lemma <- ifelse(x$lemma %in% "-PRON-", x$token, x$lemma)
cat(as_conllu(x), file = file("predictions_spacy.conllu", encoding = "UTF-8"))
spacy_finalize()

## Compare evaluations
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_udpipe.conllu")
system("python evaluation_script/conll17_ud_eval.py -v gold.conllu predictions_spacy.conllu")

##############################################################################################
## UD_Italian
##  + Evaluation data from https://github.com/UniversalDependencies/UD_Italian
##  + udpipe + spacy were trained on the same data
##  + Note that the license seems to be incorrect from spacy: https://github.com/explosion/spaCy/issues/1865
##############################################################################################
download.file(url = "https://raw.githubusercontent.com/UniversalDependencies/UD_Italian/master/it-ud-test.conllu", 
              destfile = "gold.conllu")
download.file(url = "https://github.com/UniversalDependencies/UD_Italian/archive/r2.0-test.zip",
              destfile = "r2.0-test.zip")
unzip("r2.0-test.zip", list = TRUE)
unzip("r2.0-test.zip", files = "UD_Italian-r2.0-test/it-ud-test.conllu", exdir = getwd(), junkpaths = TRUE)
file.copy("it-ud-test.conllu", "gold.conllu", overwrite = TRUE)

gold <- udpipe_read_conllu("gold.conllu")
sentences <- unique(gold$sentence)
sentences <- rle(gold$sentence)$values
sentences <- readLines("gold.conllu", encoding = "UTF-8")
sentences <- grep(pattern = "# text =", sentences, value=TRUE)
sentences <- gsub("# text = ", "", sentences)

## Annotation with UDPipe
ud_model <- udpipe_download_model(language = "italian", udpipe_model_repo = "jwijffels/udpipe.models.ud.2.0")
ud_model <- udpipe_load_model(ud_model$file)
anno <- udpipe_annotate(ud_model, sentences)
cat(anno$conllu, file = file("predictions_udpipe.conllu", encoding = "UTF-8"))
x <- as.data.frame(anno)

## Annotation with Spacy
spacy_initialize(model = "it")
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
