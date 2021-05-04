require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize (author, content)
    @content = content
    @author = author
  end

  def save
    CSV.open("./db/gossip.csv", "a") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []

    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    gossips = []
    CSV.read("./db/gossip.csv").each do |gossip|
      gossips << Gossip.new(gossip[0], gossip[1])
    end
    gossip = gossips[id]
    return gossip
  end

  def self.update(new_author, new_content, updated_id)
    CSV.open("./db/gossip_update.csv",'w+') do |csv_update|
      CSV.read("./db/gossip.csv").each_with_index do |gossip, index|
        if index == updated_id.to_i
          updated_gossip = Gossip.new(new_author, new_content)
          csv_update <<[updated_gossip.author, updated_gossip.content]
        else
          csv_update << gossip
        end
      end
    end
    CSV.open("./db/gossip.csv",'w') do |old_row|
      CSV.read("./db/gossip_update.csv").each do |new_row|
        old_row << new_row
      end
    end
  end

  # def self.update(new_author, new_content, id)
  #   table = CSV.table("./db/gossip.csv")
  # end
end