class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# ANSWER
# Remove attr_accessor :database_handle
