def calculatePoints(combinations)
  points = 0
  score = Hash.new(0)
  combinations.each do |combo|
    points += pointsForFlush(combo)
    points += pointsForPairs(combo)
    points += pointsForRuns(combo)
    score[points] = combo
    points = 0
  end 
  puts "The best hand is #{score[score.keys.max]} and is worth #{score.keys.max} points"
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

def pointsForRuns(combo)
  points = 0   
  comboNumbers = combo.map do |card|
    current = card.chop.to_i
  end.sort

  runList = []
  comboNumbers.map do |num|
    current = num
    if runList.length == 0
      runList.push([current])
    else 
      last = runList.last.last
      if current - last < 2
        runList.last.push(current)
      else 
        runList.push([current])
      end 
    end 
  end 

  filtered = runList.filter { |run| run.length > 2}.flatten
  filteredUnique = filtered.uniq.length  

  if filtered.uniq.length >= 3 
    if filtered.length == 4
      if filtered.uniq.length == 4
        points = 4
      elsif filtered.uniq.length == 3 
        points = 6
      end 
    else 
      points = 3
    end 
  end 
 
  return points 
end 

cards = ['7C', '8H', '8C', '9C', '1C','10D']
combinations = cards.permutation(4).to_a
calculatePoints(combinations)