class PointHelper
  
  def self.calculate_points(combinations) 
    points = 0
    score = Hash.new(0)
    combinations.each do |combo|
       points += points_for_flush(combo)
      points += points_for_pairs(combo)
      points += points_for_runs(combo)
      points += points_for_combo15(combo)
      score[points] = combo
      points = 0
    end 
    score[score.keys.max].sort_by! do |card|
      card.chop.to_i
    end
  
    return {hand: score[score.keys.max], points: score.keys.max}
  
  end 
  
  def self.points_for_flush(combo)
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
  
  def self.points_for_pairs(combo)
    points = 0 
    pairs = Hash.new(0)
    combo.each do |card|
      pairs[card.chop] += 1
    end 
    
    case pairs.length
    when 3
      points = 2    
    when 2
     triple = pairs.values.any?{|value| value == 3}
     points = triple ? 6 : 4
    when 1
      points = 12
    else 
      points = 0
    end 
    return points 
  end 
  
  def self.points_for_runs(combo)
    points = 0   
    combo_numbers = combo.map do |card|
      current = card.chop.to_i
    end.sort
  
    run_list = []
    combo_numbers.map do |num|
      current = num
      if run_list.length == 0
        run_list.push([current])
      else 
        last = run_list.last.last
        if current - last < 2
          run_list.last.push(current)
        else 
          run_list.push([current])
        end 
      end 
    end 
  
    filtered = run_list.filter { |run| run.length > 2}.flatten
    filtered_unique = filtered.uniq.length  
  
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
  
  def self.points_for_combo15(combo)
    combo.sort_by!{ |card| card.chop.to_i}
    points = 0
    above8 = combo.all? {|card| card.chop.to_i >= 8}
  
    if !above8
      possible_sums = Hash.new(0)
      combo.each do |card|
        possible_sums[card.chop] += 1
      end 
  
      
      possible_sums.keys.each do |key|
        total = key.to_i 
        diff = 15 - total
  
        if possible_sums[diff.to_s] == 2 && possible_sums[key] == 2
          return points + 4
        end 
        
        while diff > 0 
          if diff.to_s != key  && possible_sums[diff.to_s] > 0 && possible_sums[key] > 0
            possible_sums[diff.to_s] -= 1
            total = total + diff
            
            diff = 15 - total  
            if total == 15
              if possible_sums[key] == 2 || possible_sums[diff.to_s] == 2
                points += 4
              else
                points += 2
              end
            end            
            
          else 
            diff -= 1
          end 
        end  
      end 
    end
    return points
  end 

end 



# cards1 = (['7S', '5C', '5H', '10S', '1C','10D']) # good 
# cards2 = (['7C', '8H', '8C', '9D', '1C','10D']) #good 
# cards3 = (['7C', '8H', '8C', '9C', '1C','10C']) #good 
# cards4 = (['1C', '4H', '12C', '13C', '11D','8C']) #good
# cards5 = (['1C', '4C', '12C', '13C', '11D','8C']) #good
# cards6 = (['4H', '4C', '4D', '4S', '11D','8C']) #good 
# cards7 = (['7H', '8C', '8D', '9S', '8H','9H']) #good
# cards8 = (['1S', '13S', '12D', '9S', '5H','9H']) #good 
# cards9 = (['1S', '13S', '12D', '9S', '5H','2H']) #good

# calculate_points(cards1.permutation(4).to_a)
# calculate_points(cards2.permutation(4).to_a)
# calculate_points(cards3.permutation(4).to_a)
# calculate_points(cards4.permutation(4).to_a)
# calculate_points(cards5.permutation(4).to_a)
# calculate_points(cards6.permutation(4).to_a)
# calculate_points(cards7.permutation(4).to_a)
# calculate_points(cards8.permutation(4).to_a)
# calculate_points(cards9.permutation(4).to_a)
