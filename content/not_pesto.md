title: Not Pesto
===

grandma made pesto with cashews and romaine instead of pine nuts and basil. Every ingredient was substituted for something else.
Made me wonder what we should call it. Perhaps 'pesto' with every other letter substituted out for something else.
total search space = 25**5 = 9765625 possible letter combinations
number of matching words = <pre>
# total number of 5-letter combinations, excluding 'pesto'
echo $((21 ** 5)) # 4084101

# total number of 5-letter combinations, excluding one letter at each position
echo $((25 ** 5)) # 9765625

# count all defined words
cat /usr/share/dict/words | wc -l # 235886

# number of words that don't share any letters with 'pesto'
cat /usr/share/dict/words | sed -n '/^[^pesto]*$/p' | wc -l # 11039

# count 5-letter words
cat /usr/share/dict/words | sed -n '/^.\{5\}$/p' | wc -l # 10230

# number of 5-letter words that don't share any letters with 'pesto'
cat /usr/share/dict/words | sed -n '/^[^pesto]\{5\}$/p' | wc -l # 1946

# count 5-letter words that don't share a letter (in the same position) with 'pesto'
cat /usr/share/dict/words | sed -n '/^[^p][^e][^s][^t][^o]$/p' | wc -l # 7531

so 26.4% of 5 letter words share at least one letter in the same position with 'pesto'
