def calculatePoints(combinations)
  points = 0
  score = Hash.new(0)
  combinations.each do |combo|
    points += pointsForFlush(combo)
    score[points] = combo
    points = 0
  end 
  puts score.to_s
end 

def pointsForFlush(combo)
  points = 0
  suits = Hash.new(0)
  combo.each do |card|
    suits[card[-1]] += 1
  end 
    if suits.keys.length == 1
      points = 4
    end 
    return points 
end 


cards = ['7C', '5C', '5H', '10C', '1C','10D']
combinations = cards.permutation(4).to_a
calculatePoints(combinations)