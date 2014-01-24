require 'rubygems' 
require 'bundler/setup'

require 'simplecov'
SimpleCov.start

require_relative 'list'
require 'test/unit'

class TestList < Test::Unit::TestCase
  
  def setup
    @sorted_list = List::LinkedList.new
    @sorted_list.insert_sorted(3)
    @sorted_list.insert_sorted(1)
    @sorted_list.insert_sorted(2)
    
    @list = List::LinkedList.new
    @list.insert(1)
    @list.insert(34)
    @list.insert(3)    
    @list.insert(5)
    
    @clist = List::CircularList.new
    @clist.insert(1)
    @clist.insert(34)
    @clist.insert(3)    
    @clist.insert(5)
    
  end
  #TODO: Refactor duplicated code from tests!
  def test_new_list
    ll = List::LinkedList.new
    assert_equal(nil, ll.head, "Head should be nil for a new list")
  end
  
  def test_to_a
    assert_equal([5,3,34,1], @list.to_a)
  end
  
  def test_insert
    ll = List::LinkedList.new
    ll.insert('foo')
    assert_equal(ll.head.data, 'foo')
    ll.insert('bar')
    assert_equal(ll.head.data, 'bar')
    assert_equal(2, ll.count)
    assert_equal(['bar', 'foo'], ll.to_a)
  end
  
  def test_sorted_insert
    assert_equal([1,2,3], @sorted_list.to_a)
  end  
  
  def test_find_value
    assert(!@list.find_value(4))
    assert(@list.find_value(34))

    list = @sorted_list.dup
    node = list.insert_sorted(6)
    assert_equal(node, list.find_value(6))
    assert_equal(nil, list.find_value(1000))
  end
  
  def test_remove_node
    list = @sorted_list.dup
    list.insert_sorted(6)
    node = list.find_value(6)
    assert(node)
    list.remove(node)
    assert(!list.find_value(6))
    assert_equal(@sorted_list.to_a, list.to_a)
  end
  
  def test_remove_empty
    list = List::LinkedList.new
    assert_equal(nil, list.remove(nil))
    assert_equal(nil, list.remove(List::Node.new(5)))
  end
  
  def test_circular_list_insert
    list = List::CircularList.new
    list.insert(3)
    list.insert(1)
    assert_equal(2, list.count)
    assert_equal([1,3], list.to_a)
  end
  
  def test_clist_remove_node
    list = @clist.dup
    list.insert(6)
    node = list.find_value(6)
    assert(node)
    list.remove(node)
    assert(!list.find_value(6))
    assert_equal(@clist.to_a, list.to_a)
  end
  
  def test_remove_empty
    list = List::CircularList.new
    assert_equal(nil, list.remove(nil))
    assert_equal(nil, list.remove(List::Node.new(5)))
    node = list.insert(44)
    list.remove(node)
  end
  
end
