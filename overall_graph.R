library(data.table)
x <- readLines("README.md")
x <- grep("^Tokens|^Sentences|^Words|^UPOS|^XPOS|^Feats|^AllTags|^Lemmas|^UAS|^LAS|^CLAS", x, value=TRUE)
x <- lapply(x, FUN=function(x) data.frame(t(trimws(strsplit(x, "\\|")[[1]]))))
x <- rbindlist(x, fill = TRUE)
colnames(x) <- c("metric", "precision", "recall", "f1", "alignedacc")
x$treebank <- unlist(lapply(c("French Sequioa", "Dutch", "Spanish-Ancora", "Portuguese", "Italian", "English"),
                     FUN=function(x) rep(x, 11*2)))
x$model <- unlist(lapply(c("French Sequioa", "Dutch", "Spanish-Ancora", "Portuguese", "Italian", "English"),
                            FUN=function(x) c(rep("UDPipe", 11), rep("spaCy", 11))))
x$precision <- as.numeric(as.character(x$precision))
x$recall <- as.numeric(as.character(x$recall))
x$f1 <- as.numeric(as.character(x$f1))
x$alignedacc <- as.numeric(as.character(x$alignedacc))

library(lattice)
x$treebank <- factor(x$treebank)
x <- x[order(x$treebank), ]
x <- subset(x, !(treebank %in% "French Sequioa" & metric == "XPOS"))
x <- subset(x, !(treebank %in% "Portuguese" & metric == "Feats"))
x <- subset(x, !(treebank %in% "Portuguese" & metric == "XPOS"))
x <- subset(x, !(treebank %in% "English" & metric == "Feats"))
x <- subset(x, !(treebank %in% "English" & metric == "UPOS"))
#x <- subset(x, treebank != "English")
trellis.par.set(name = "strip.background", value = list(col = "honeydew2"))
xyplot(alignedacc ~ treebank | metric, groups = model, 
       data = subset(x, metric %in% c("UPOS", "XPOS", "Feats", "Lemmas")),
       scales = list(x = list(rot = 45, alternating = FALSE), y = list(relation = "free")),
       auto.key = list(space = "right", lines = TRUE), type = "b", pch = 20,
       par.settings = simpleTheme(col=c("red", "blue")),
       ylab = "Word-aligned 'gold' accuracy", xlab = "Universal Dependencies Treebank v2.0",
       main = "spaCy/UDPipe accuracy comparison\nParts of Speech tagging, Morphological Features & Lemmatisation")

xyplot(alignedacc ~ treebank | metric, groups = model, 
       data = subset(x, metric %in% c("UAS", "LAS", "CLAS") & treebank != "English"),
       scales = list(x = list(rot = 45, alternating = FALSE)),
       auto.key = list(space = "right", lines = TRUE), type = "b",
       par.settings = simpleTheme(col=c("red", "blue")),
       ylab = "Word-aligned 'gold' accuracy", xlab = "Universal Dependencies Treebank v2.0",
       main = "spaCy/UDPipe accuracy comparison\nDependency Parsing")



trellis.par.set(name = "strip.background", value = list(col = "honeydew2"))
xyplot(f1 ~ treebank | metric, groups = model, 
       data = subset(x, metric %in% c("Tokens", "Words", "Sentences")),
       scales = list(x = list(rot = 45, alternating = FALSE), y = list(relation = "free")),
       auto.key = list(space = "right", lines = TRUE), type = "b", pch = 20,
       par.settings = simpleTheme(col=c("red", "blue")),
       ylab = "F1", xlab = "Universal Dependencies Treebank v2.0",
       main = "spaCy/UDPipe F1 comparison\nTokenisation")

xyplot(f1 ~ treebank | metric, groups = model, 
       data = subset(x, metric %in% c("UPOS", "XPOS", "Feats", "Lemmas")),
       scales = list(x = list(rot = 45, alternating = FALSE), y = list(relation = "free")),
       auto.key = list(space = "right", lines = TRUE), type = "b", pch = 20,
       par.settings = simpleTheme(col=c("red", "blue")),
       ylab = "F1", xlab = "Universal Dependencies Treebank v2.0",
       main = "spaCy/UDPipe F1 comparison\nParts of Speech tagging, Morphological Features & Lemmatisation")


xyplot(f1 ~ treebank | metric, groups = model, 
       data = subset(x, metric %in% c("UAS", "LAS", "CLAS") & treebank != "English"),
       scales = list(x = list(rot = 45, alternating = FALSE)),
       auto.key = list(space = "right", lines = TRUE), type = "b",
       par.settings = simpleTheme(col=c("red", "blue")),
       ylab = "F1", xlab = "Universal Dependencies Treebank v2.0",
       main = "spaCy/UDPipe F1 comparison\nDependency Parsing")