# In exercise 12, we manually set the contacts hash values one by one. Now,
# programmatically loop or iterate over the contacts hash from exercise 12,
# and populate the associated data from the contact_data array. Hint: you will
# probably need to iterate over ([:email, :address, :phone]), and some helpful
# methods might be the Array shift and first methods.

# Note that this exercise is only concerned with dealing with 1 entry in the
# contacts hash, like this:

# contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
# contacts = {"Joe Smith" => {}}
# As a bonus, see if you can figure out how to make it work with multiple
# entries in the contacts hash.

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

# ANSWER

fields = [:email, :address, :phone]
contacts.each do |k, v|
  # get the person's first name
  first_name = k.split(" ").first.downcase

  contact_data.each do |data|
    # if match is found, add info to hash and break loop (don't add info to more
    # than one profile)
    if !data.empty? && /#{first_name}/ =~ data[0].split("@").first.downcase
      fields.each { |field| v[field] = data.shift }
      break
    end
  end
end

puts contacts
