require 'byebug'

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    first == @tail
  end

  def get(key)
    search_link = @head
    until search_link == @tail
      return search_link.val if search_link.key == key
      search_link = search_link.next
    end

    nil
  end

  def include?(key)
    return true if get(key)
    false
  end

  def insert(key, val)
    insert_this = Link.new(key, val)
    insert_this.next = @tail
    insert_this.prev = @tail.prev
    @tail.prev.next = insert_this
    @tail.prev = insert_this
    insert_this
  end

  def remove(key)
    search_link = @head
    until search_link == @tail
      if search_link.key == key
        search_link.prev.next = search_link.next
        search_link.next.prev = search_link.prev
        return search_link
      end

      search_link = search_link.next
    end

    raise "Item not found"
  end

  def each(&prc)
    iterator = @head.next
    return nil if iterator == @tail
    until iterator == @tail
      prc.call(iterator)
      iterator = iterator.next
    end

    nil
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
