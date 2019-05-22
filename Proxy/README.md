# Proxy

## Motto
Proxy to substytut (zamiennik) obiektu w celu **sterowania dostępem do niego**.

## Rodzaje proxy

* Proxy zdalne – reprezentant lokalny obiektu zdalnego
* Proxy wirtualne – tworzy kosztowny obiekt na żądanie.
Przykładowo `ActiveRecord::Associations::CollectionProxy`.
Generyczne podejście: https://www.greyblake.com/blog/2014-10-05-lazy-object-pattern-in-ruby/
* Proxy ochraniające – kontroluje dostęp do obiektu
* Proxy logujące – loguje dostęp do obiektu

## Proxy, a inne wzorce

* Struktura Proxy i Decoratora może wydawać się podobna. Różnice są następujące:
  * Każdy z Decoratorów może dodawać nowe, specyficzne dla siebie operacje/informacje. Proxy nigdy nie zmienia (nie rozszerza) interfejsu obiektu
  * Proxy z zasady nie jest przeznaczone do stosowania rekursywnego; Dekorator przeciwnie
* Proxy a adapter. Adapter zmienia interfejs podmiotu (subject), a proxy zawsze zachowuje ten sam.


# Przykład w ruby

## Subject

```ruby
class BankAccount
  def balance
    puts "check balance"
  end

  def deposit(amount)
    puts "deposit #{amount}"
  end

  def withdraw(amount)
    puts "withdraw #{amount}"
  end
end
```

## Remote proxy

```ruby
class RemoteBankAccountProxy
  def initialize
    @base_uri = "localhost:3000/bank_account"
  end

  def balance
    rest_service.get("/balance")
  end

  def deposit(amount)
    rest_service.post("/deposit", {amount: amount})
  end

  def withdraw(amount)
    rest_service.delete("/withdraw", {amount: amount})
  end

  private

  def rest_service
    @rest_client ||= RestClient.new(base_uri, :json)
  end

  attr_reader :rest_service
end
```

## Virtual proxy

```ruby
class VirtualBankAccountProxy

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  private

  def subject
    @subject ||= BankAccount.new
  end
end
```

## Protection proxy

```ruby
class ProtectionBankAccountProxy
  attr_reader :user_credentials

  def initialize(user_credentials)
    @subject = BankAccount.new
    @user_credentials = user_credentials
  end

 
  def balance
    check_permissions(:read)
    subject.balance
  end

  def deposit(amount)
    check_permissions(:write)
    subject.deposit(amount)
  end

  def withdraw(amount)
    check_permissions(:write)
    subject.withdraw(amount)
  end

  private

  def check_permissions(permission_type)
    unless CredentialValidator.validate(@user_credentials, permission_type)
      raise "Unauthorized #{permission_type} action from: #{@user_credentials}. Account action denied."
    end
  end
```
