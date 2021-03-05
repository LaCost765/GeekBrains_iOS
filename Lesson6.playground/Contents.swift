import UIKit

class Queue<T: Equatable>
{
    // Nested classes
    // Represents node of queue
    private class Node<T> {
        
        // Point to previous node in queue
        private var prevNode: Node<T>?
        private var value: T
        
        init(value: T) {
            self.value = value
        }
        
        func setPreviousNode(prev node: Node<T>) {
            prevNode = node
        }
        
        func getPreviousNode() -> Node<T>? {
            return prevNode
        }
        
        func getValue() -> T {
            return value
        }
        
        deinit {
            print("Deinit node with value \(value)")
        }
    }
    
    // Properties
    private var firstNode: Node<T>?
    weak private var lastNode: Node<T>?
    private(set) var count: Int = 0
    
    // Initializers
    init() { }
    
    init(root value: T) {
        self.Enqueue(value: value)
    }
    
    // Methods
    func Enqueue(value: T) {
        
        let node = Node<T>(value: value)
        
        if firstNode == nil {
            firstNode = node
            lastNode = node
        } else {
            lastNode?.setPreviousNode(prev: node)
            lastNode = node
        }
        
        self.count += 1
    }
    
    func Dequeue() -> T? {
        guard let node = firstNode else {
            print("Queue is empty!")
            return nil
        }
        
        let value = node.getValue()
        firstNode = node.getPreviousNode()
        self.count -= 1
        return value
    }
    
    func Dequeue(procedure: (T?) -> Void) {
        let value = self.Dequeue()
        procedure(value)
    }
    
    func Clear() {
        firstNode = nil
        //while let _ = self.Dequeue() { }
        self.count = 0
    }
    
    func Contains(value: T) -> Bool {
        var node = firstNode
        
        while node != nil {
            if node?.getValue() == value {
                return true
            }
            node = node?.getPreviousNode()
        }
        
        return false
    }
    
    func ToArray() -> [T] {
        var resultArray = Array<T>()
        
        var node = firstNode
        while node != nil {
            resultArray.append((node?.getValue())!)
            node = node?.getPreviousNode()
        }
        
        return resultArray
    }
}



var queue = Queue<Int>()
queue.Enqueue(value: 1)
queue.Enqueue(value: 2)
queue.Enqueue(value: 3)
queue.Enqueue(value: 4)

queue.Contains(value: 1)
queue.Contains(value: 3)
queue.Contains(value: 4)
queue.Contains(value: 5)

queue.Dequeue()
queue.Dequeue() { value in
    if let value = value {
        print("\(value)^2 = \(value * value)")
    }
}
print()
queue.Clear()

