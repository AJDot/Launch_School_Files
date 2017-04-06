def balancer(string)
  balance = 0
  string.chars.each do |char|
    balance += 1 if char == '('
    balance -= 1 if char == ')'
    break if balance < 0
  end
  p balance == 0
end

balancer("hi")
balancer("(hi")
balancer("(hi)")
balancer(")hi(")
