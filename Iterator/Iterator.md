# Iterator Design Pattern

## Motto

"Sleep is but a vessel in which our dreams traverse the heavens." ― Anthony T. Hincks

## Description

The iterator pattern is used to traverse a container and access the container's elements without exposing its representation. The pattern itself decouples algorithms from containers, although in some cases algorithms are container specific ergo they cannot be decoupled.

![Iterator diagram](https://javapapers.com/wp-content/uploads/2013/06/Iterator-Design-Pattern.jpg)

## What problems it solves?

* container's representation shouldn't be exposed while its elements are accessed and traversed
* traversal operations should be defined without changing container's interface

## What solution it gives?

* separate iterator object that encapsulates accessing and traversing the container
* clients use iterator to access and traverse container without knowing its representation
* iterator can be used to traverse the container in different ways

## Examples

### Ruby

```ruby
class MyAwesomeIterator
  def initialize(collection)
    @collection = collection
    @current_index = 0
  end

  def next?
    @current_index < @collection.size
  end

  def next
    @current_index += 1
    @collection[@current_index]
  end
end

class Array
  def my_awesome_iterator
    MyAwesomeIterator.new(self)
  end
end

```

```ruby
e = [1, 2, 3].each
# => #<Enumerator: [1, 2, 3]:each>

e.next
# => 1

e.peek
# => 2

e.next
# => 3

e.rewind
# => #<Enumerator: [1, 2, 3]:each>

[4, 5, 6, 7].select.with_index { |number, index| index.odd? }

"Design Patters are awesome".each_char.reduce(&:prepend)
# => "emosewa era srettaP ngiseD"

# Enumerator.new
fib = Enumerator.new do |y|
  a = b = 1
  loop do
    y << a
    a, b = b, a + b
  end
end

fib.take(10)
# => [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

fib.lazy.select(&:even?).first(10)
#=> [2, 8, 34, 144, 610, 2584, 10946, 46368, 196418, 832040]

# Make your custom collection iterable
class MyAwesomeCollection
  include Enumerable

  def each
    # your implementation
  end
end

```

### JavaScript

```javascript

function makeRangeIterator (start = 0, end = Infinity, step = 1) {
  let nextIndex = start
  let iterationCount = 0

  const rangeIterator = {
    next: function () {
      let result
      if (nextIndex < end) {
        result = { value: nextIndex, done: false }
        nextIndex += step
        iterationCount++
        return result
      }
      return { value: iterationCount, done: true }
    }
  }
  return rangeIterator
}

const it = makeRangeIterator(1, 10, 2)

let result = it.next()

while (!result.done) {
  console.log(result.value) // 1 3 5 7 9
  result = it.next()
}


```

# Sources

* [LINK 1](https://en.wikipedia.org/wiki/Iterator_pattern)
* [LINK 2](https://rossta.net/blog/what-is-enumerator.html)
* [LINK 3](https://blog.arkency.com/2014/01/ruby-to-enum-for-enumerator/)
* [LINK 4](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Iterators_and_Generators)
