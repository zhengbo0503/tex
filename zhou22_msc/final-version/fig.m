words = fileread('final-thesis.tex');
words = string(words);
words = splitlines(words);
words(strlength(words)<5) = [];
words = categorical(words);
figure
wordcloud(words)