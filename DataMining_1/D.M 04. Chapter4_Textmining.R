install.packages(c("tm","stringi","proxy","curl"))
install.packages(c("ggplot2","wordcloud"))
install.packages("labeling")
install.packages("SnowballC")
library(tm)
library(stringi)
library(proxy)
library(curl)
library(ggplot2)
library(wordcloud)
library(labeling)
library(SnowballC)



wiki <- "http://en.wikipedia.org/wiki/"
# 
titles <- c("Francis_Galton", "Karl_Pearson", "Ronald_Fisher")
articles <- character(length(titles))
for (i in 1:length(titles)) {
  articles[i] <- stri_flatten(readLines(curl(stri_paste(wiki, titles[i]))), col = " ")
}

articles[1]
?tm_map

docs <- Corpus(VectorSource(articles)) # 에러 나와도 상관없음?
docs[[1]] ; docs[[2]] ; docs[[3]]
docs <- tm_map(docs, function(x) stri_replace_all_regex(x, "<.+?>", " "))
docs <- tm_map(docs, function(x) stri_replace_all_fixed(x, "\t", " "))
docs <- tm_map(docs, PlainTextDocument)
docs <- tm_map(docs, removePunctuation) # , ; 같은 친구들없어주기
docs <- tm_map(docs, removeNumbers)     # 숫자 제외하고 영단어만 키워드로
docs <- tm_map(docs, tolower)           # 소문자로 반환
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("francis", "galton","karl","pearson","ronald","fisher"))  # 주제이름 키워드 제거하기 
#library(SnowballC)
#docs <- tm_map(docs, stemDocument)      # -s , -ing 같은 steming document 없애주기
docs <- tm_map(docs, stripWhitespace)
docs<-Corpus(VectorSource(docs))
#docs <- tm_map(docs, PlainTextDocument)
tdm <- TermDocumentMatrix(docs, control=list(wordLengths=c(2,10)))
findFreqTerms(tdm, lowfreq=10)
termFrequency <- rowSums(as.matrix(tdm))
termFrequency <- subset(termFrequency, termFrequency>=50)
library(ggplot2)
df <- data.frame(term=names(termFrequency), freq=termFrequency)
ggplot(df, aes(x=term, y=freq)) + geom_bar(stat="identity") +
  xlab("Terms") + ylab("Count") + coord_flip()
barplot(termFrequency, las=2)
library(wordcloud)
m <- as.matrix(tdm)
## calculate the frequency of words and sort it descendingly by frequency
wordFreq <- sort(rowSums(m), decreasing=TRUE)
## colors
pal <- brewer.pal(9, "BuGn");pal <- pal[-(1:4)]
set.seed(375) # to make it reproducible
grayLevels <- gray( (wordFreq+10) / (max(wordFreq)+10) )
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=10, random.order=F, colors=pal)
