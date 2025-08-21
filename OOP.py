# Create a class called account that has the following 
# Attributes - account_number and balance
# Methods: debit, credit, balance.
# Show the balance after each debit and credit operation.

# Create class
class account:
  def __init__(self, account_number, balance=0):
    self.balance = balance
    self.account_number= account_number

  def debit(self, amount):
    if amount <= self.balance:
      self.balance = self.balance-amount
      print(f"KES {amount} debited, your new balance is {self.balance}")
    else:
        print("insufficient balance")
  def credit(self, amount):
    if amount > 0:
      self.balance = self.balance+amount
      print(f"KES {amount} credited, your new balance is {self.balance}")
    else:
        print("invalid amount")

  def balance(self):
     print(f"your balance is {self.balance}")

# create object
Account1 = account('01000400500', 5000)
# Show the balance after each debit and credit operationa 
Account1.balance
print(Account1.debit(1000)),
print(Account1.credit(500)),
print(f"Your account balance is KES {Account1.balance}")


