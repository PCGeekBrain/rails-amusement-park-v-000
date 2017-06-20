class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :user
  belongs_to :attraction

  def take_ride
    missing_tickets = self.user.tickets < self.attraction.tickets
    too_short = self.user.height < self.attraction.min_height
    if missing_tickets && too_short
      return "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    elsif missing_tickets
      return "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    elsif too_short
      return "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    else
      self.user.tickets -= self.attraction.tickets
      self.user.nausea += self.attraction.nausea_rating
      self.user.happiness += self.attraction.happiness_rating
      self.user.save
      return "Thanks for riding the #{self.attraction.name}!"
    end
  end
end
