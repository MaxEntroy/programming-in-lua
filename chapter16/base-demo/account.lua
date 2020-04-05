Account = {balance = 0}
function Account.withdraw(self, v)
  self.balance = self.balance - v
end

a1 = Account
Account = nil

a1.withdraw(a1, 100)
print(a1.balance)

a2 = {balance = 0, withdraw = a1.withdraw}
a2.withdraw(a2, 200)
print(a2.balance)
