#!/usr/bin

# count exercise
tr 'a-z' 'A-Z' < data/words.txt | tr -sc 'A-Z' '\012' | sort | uniq -c | sed 5q

# numeric order
tr -sc 'A-Za-z' '\012' < data/words.txt | sort | uniq -c | sort -nr > data/genesis.hist

# dictionary order
tr -sc 'A-Za-z' '\012' < data/words.txt | sort | uniq -c | sort -d -k2

# rhyming order
tr -sc 'A-Za-z' '\012' < data/words.txt | sort | uniq -c | rev | sort -d | rev
