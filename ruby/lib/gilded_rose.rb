class GildedRose

  def process_end_of_day(items)
    items.each { |item| process_item_end_of_day item }
  end

  def process_raw_milk(item)
    if item.quality == 0
      item.days_remaining = item.days_remaining - 1
      return
    end

    if item.days_remaining <= 0
      item.quality = item.quality - 4
    else
      item.quality = item.quality - 2
    end

    item.days_remaining = item.days_remaining - 1
  end

  def process_concert_tickets(item)
    max_quality = 50
    if item.quality == max_quality
      item.days_remaining = item.days_remaining - 1
      return
    end

    if item.days_remaining <= 0
      item.quality = 0
    elsif item.days_remaining <= 5 && item.quality.between?(48,50)
     item.quality = item.quality + 2
    elsif item.days_remaining <= 5 && !item.quality.between?(48,50)
     item.quality = item.quality + 3
    elsif item.days_remaining <= 10 && !item.quality.between?(48,50)
     item.quality = item.quality + 2
    else
        item.quality = item.quality + 1
    end

    item.days_remaining = item.days_remaining - 1
  end

  def process_hammer(item)
   item 
  end

  def process_aged_cheddar(item)
    max_quality = 50

    item.days_remaining = item.days_remaining - 1

    if item.quality == max_quality
      return
    else
      if item.days_remaining <= 0
        if item.quality.between?(48,50)
          item.quality = item.quality + 1
        else
          item.quality = item.quality + 2
        end
      else
        item.quality = item.quality + 1
      end
    end
  end

  def process_normal_item(item)
    item.days_remaining = item.days_remaining - 1

    if item.days_remaining > 0
      item.quality = item.quality - 1
    else
      item.quality = item.quality - 2
    end

    if item.quality < 0
      item.quality = 0
    end
  end

  def process_item_end_of_day(item)
    special_cases = ['Aged Cheddar', 'Concert Tickets', 'Hammer', 'Raw Milk']

    if !special_cases.include?(item.name)
      process_normal_item(item)
    end

    if item.name == 'Aged Cheddar'
      process_aged_cheddar(item)
    end

    if item.name == 'Hammer'
      process_hammer(item)
    end

    if item.name == 'Concert Tickets'
      process_concert_tickets(item)
    end

    if item.name == 'Raw Milk'
      process_raw_milk(item)
    end
  end
end
