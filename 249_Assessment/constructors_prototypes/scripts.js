function log(text, code) {
  console.log(text, " => ", code);
}

function makeAccount() {
  return new Account();
}

var Account = function() {
  var balance = 0;
  this.getBalance = function() {
    return balance;
  }
  this.deposit = function(amount) {
    balance += amount;
    console.log("Deposit: $" + amount);
    return amount
  }
};

var checking = new Account()
console.log(checking.balance);
console.log(checking.getBalance());
checking.deposit(100);
console.log(checking.getBalance());

var Account2 = function() {
  this.balance = 0;
}

Account2.prototype.getBalance = function() {
  return this.balance;
}

var savings = new Account2();
