def RSP(you, oppnt)
  rules = { "paper" => "rock", "scissors" => "paper", "rock" => "scissors" }
  if rules[you] == oppnt
    puts("\nHey, dude(player1), you're win")
  elsif you == oppnt
    puts("\nNo one lose:)")
  else
    puts("\nCheer up, loser(player1)")
  end
end


def check(arg, num)
  s = "???\nIsn't it clear? Re-read the instructions"
  until ["rock", "scissors", "paper"].include?(arg)
    puts(s + "\nenter player #{num}")
    arg = gets().chop.downcase
  end
  arg
end



while true
  puts("\nEnter rock, scissors, or paper\nTo exit - print 1")
  turns = gets().downcase.split(" ")
  if turns[0] == "1"
    puts("Byeeee")
    break
  end

  you = turns[0]
  oppnt = turns[1]

  you = check(you, "1")
  oppnt = check(oppnt, "2")

  RSP(you, oppnt)
  puts()
end

