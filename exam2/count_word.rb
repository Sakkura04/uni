def word_count(sentence)
  words = sentence.downcase.split(/\W+/)
  word_count_hash = Hash.new(0)

  words.each do |word|
    word_count_hash[word] += 1
  end

  word_count_hash
end

# Приклад використання:
sentence = "Hi Ken! Hi Barbie! Hi Barbie!"
result = word_count(sentence)
puts result
