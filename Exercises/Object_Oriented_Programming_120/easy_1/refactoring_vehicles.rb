class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car
  def wheels
    4
  end
end

class Motorcycle
  def wheels
    2
  end
end

class Truck
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

# Further Exploration
# Wheels does not belong in vehicles unless you expect all types of vehicles to have wheels. However, if boats, planes, etc are going to be included under vehicles, then no.
# If it should be centralized somewhere, it should be in WheeledVehicle < Vehicle. Then all vehicles with wheels could be a subless of it.
