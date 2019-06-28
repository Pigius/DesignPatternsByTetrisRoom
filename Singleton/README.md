# Singleton

Software design pattern that restricts class instantiation to single object.

# How to
- make the constructor private
- create static method returning the instance - getInstance()

# What we need to remember

Implementation must ensure global access to the singleton and that one and only one instance of a given class exists.

# Use cases
- facade
- settings
- abstract factory, builder, and prototype

# How to in code

```ruby
require 'singleton'

class Example
  include Singleton
end

Example.instance
```

```javascript
let instance = null

class Settings {
  constructor () {
    if (!instance) {
      instance = new Settings()
    }

    return instance
  }
}
```

```ruby
require 'singleton'

class BookFacade
  include Singleton
  attr_accessor :book

  def rate
    GetBookAverageRate.call(@book)
  end

  def related_books
    @book.related_books.order('created_at DESC')
  end

  def new_rate
    @book.rates.new
  end
end

class BooksController < ApplicationController
  before_action :set_book

  def show
  end

  private

  def set_book
    @book = Book.find(params[:id])
    @book_facade = BookFacade.instance
    @book_facade.book = @book
  end
end
```



# Advantages
- only one instance
- doesn't waste memory

# Disadvantages
- coupling
- hard times during testing

# Sources
- https://www.tutorialspoint.com/design_pattern/singleton_pattern.htm
- https://www.rubyguides.com/2018/05/singleton-pattern-in-ruby/
- https://en.wikipedia.org/wiki/Singleton_pattern
- https://codeahoy.com/2016/05/27/avoid-singletons-to-write-testable-code/
- https://ludzkastrona.it/kursy/wzorce-projektowe-ruby-on-rails/8-wzorzec-facade?fbclid=IwAR1WuFU3cAlL_tjrnfgaPsPTSvFkF4K0896I7-wc0vdDMpNIZrmXjWzGpXo