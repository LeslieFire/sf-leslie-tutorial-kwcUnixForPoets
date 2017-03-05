#!/usr/bin

# count exercise
tr 'a-z' 'A-Z' < data/words.txt | tr -sc 'A-Z' '\012' | sort | uniq -c | sed 5q

# numeric order
tr -sc 'A-Za-z' '\012' < data/words.txt | sort | uniq -c | sort -nr > data/genesis.hist

# dictionary order
tr -sc 'A-Za-z' '\012' < data/words.txt | sort | uniq -c | sort -d -k2

# rhyming order
tr -sc 'A-Za-z' '\012' < data/words.txt | sort | uniq -c | rev | sort -d | rev

# count trigrams
tr -sc 'A-Za-z' '\012' < data/words.txt > data/genesis.words
tail -n +2 data/genesis.words > data/genesis.nextwords
tail -n +3 data/genesis.words > data/genesis.nextnextwords
paste data/genesis.words data/genesis.nextwords data/genesis.nextnextwords | sort | uniq -c | sort -nr > data/genesis.trigrams


# count uppercase words
egrep -c '^[A-Z]+$' data/genesis.words
# count lowercase words
egrep '^[a-z]+$' data/genesis.words | wc -l
# count 4-letter words
egrep -c '^[A-Za-z]{4}$' data/genesis.words
# count words with no vowels
grep -v '[AEIOUaeiou]' data/genesis.words
# 1-syllable words
grep  '^[^aeiou]*[aeiou][^aeiou]*$' data/genesis.words
# 2-syllable words
grep  '^[^aeiou]*[aeiou][^aeiou]*[aeiou][^aeiou]*$' data/genesis.words
grep -Ei "^[^aeiouy]*[aeiouy][^aeiouy]*[aeiouy][^aeiouy]*$" data/genesis.words | sort -f | uniq -i > data/genesis.2syllables

# delete word ending with silent "2" or containing dipthongs
grep -Eiv "(ow|ou|ie|oi|oo|ea|ee|ai|[aeiou]y).*|[aeiouy][^aeiouy]e$" data/genesis.2syllables

# find verses with word "light"
grep -Ei  '^(.*vi.*)$' data/genesis.words
# 2 or more instances of "light"
grep -Ei  '^(.*vi.*){2,}$' data/genesis.words | wc -l
# 3 or more instances of "light"
grep -Ei  '^(.*vi.*){3,}$' data/genesis.words | wc -l


# count word initial consonant sequences
sed -r 's/^([^aeiou]*)[aeiouy].*$/\1/i' data/genesis.words | sort -f | uniq -c

# count word final consonant sequences
sed -r 's/^.*[aeiouy]([^aeiouy]+)$|^.*[aeiouy]($)/\1/i' data/genesis.words | sort -f | uniq -c

#  sort the words in Genesis by the number of syllables (sequences of vowels)
sed 's/[^aeiouAEIOU]/ /g' < data/genesis.words | awk '{print NF}' > data/genesis.count
paste data/genesis.count data/genesis.words | sort -nr |uniq | awk '{print $2}'> sort-by-syllables.genesis

