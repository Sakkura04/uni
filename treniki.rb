# frozen_string_literal: true

def only_digits?(str)
  /\A\d+\z/.match?(str)
end


def Luhn(card)
  card = card.gsub(' ', '')

  if only_digits?(card) and card.size > 1
    card = card.split('').map(&:to_i)
    puts "b #{card}"

    card2 = card.map.with_index do |element, index|
      multiplied = index.odd? ? element : element * 2
      multiplied > 9 ? multiplied - 9 : multiplied
    end

    puts "a #{card2}"
    puts card2.sum
    card2.sum % 10 == 0
  else
    puts 'wrong num, chel'
    false
  end

end
