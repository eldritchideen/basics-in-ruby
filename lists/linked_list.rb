
module List
  
  class Node
    attr_accessor :data
    attr_accessor :next
    
    def initialize(data, next_node=nil)
      @data = data
      @next = next_node
    end
  end
  
  class LinkedList
    include Enumerable
    
    attr_accessor :head
    
    def each()
      item = @head
      while(item)
        yield item
        item = item.next
      end
    end
    
    def to_a
      return collect() { |node| node.data }
    end
    
    # Insert node at the head of the list.
    def insert(data)
      @head = Node.new(data, head)
    end
    
    # Insert node in order into the list. 
    def insert_sorted(data)
      if (!@head || data <= @head.data)
        return insert(data)
      end
      current = @head
      while (current.next && current.next.data < data)
        current = current.next
      end
      current.next = Node.new(data, current.next)
    end  
    
    # Find an element in the list
    def find_value(value)
      return find() do |item|
        item.data == value
      end
    end
    
    # Find a node in the list containing data of value, else nil.
    def find_node(value) 
      current = @head
      while (current) 
        return current if current.data == value
        current = current.next
      end
      nil
    end
    
    # Remove a node from the list
    def remove(target)
      return nil if target == nil || @head == nil
      @head = @head.next if @head == target
      prev_node = find() do |item|
        item.next == target
      end
      prev_node.next = prev_node.next.next if prev_node
    end
  end
end


  