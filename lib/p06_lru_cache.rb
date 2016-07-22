require 'byebug'
require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])
    else
      eject! if count == @max
      link_value = @prc.call(key)
      @store.insert(key, link_value)
      @map.set(@store.last.key, @store.last)
    end

    link_value
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @store.insert(key)
  end

  def update_link!(link)
    link_to_move = @store.remove(link.key)
    @store.insert(link_to_move.key, link_to_move.val)
  end

  def eject!
    removed_link = @store.remove(@store.first.key)
    @map.delete(removed_link.key)
  end
end
