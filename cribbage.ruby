def calculatePoints(combinations)
  points = 0
  score = Hash.new(0)
  combinations.each do |combo|
    points += pointsForFlush(combo)
    points += pointsForPairs(combo)
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

def pointsForPairs(combo)
  points = 0 
  pairs = Hash.new(0)
  combo.each do |card|
    pairs[card.chop] += 1
  end 
  
  case pairs.length
  when 3
    points = 2    
  when 2
    points = 6
  when 1
    points = 12
  else 
    points = 0
  end 

  return points 
end 

cards = ['7C', '5C', '10C', '10C', '10C','10D']
combinations = cards.permutation(4).to_a
calculatePoints(combinations)