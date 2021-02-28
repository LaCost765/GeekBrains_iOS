import UIKit

// 1. Написать функцию, которая определяет, четное число или нет.
func isNumberEven(_ number: Int) -> Bool {
    return number % 2 == 0
}


// 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
func isNumberDividedBy3(_ number: Int) -> Bool {
    return number % 3 == 0
}


// 3. Создать возрастающий массив из 100 чисел.
var array: [Int] = Array(1...100)
print("Array from 100 numbers:\n\(array)\n")


// 4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
for element in array where isNumberEven(element) || !isNumberDividedBy3(element) {
    let index: Int = array.firstIndex(of: element)!
    array.remove(at: index)
}

print("Edited array:\n\(array)\n")


// 5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.
func addFibNumber(_ arr: inout [Int]) {
    let newNumber: Int = arr[arr.count - 1] + arr[arr.count - 2]
    arr.append(newNumber)
}

var arrFib: [Int] = [1, 1]
for _ in 1...50 {
    addFibNumber(&arrFib)
}

print("Fibonacci array:\n\(arrFib)\n")


// 6. * Заполнить массив из 100 элементов различными простыми числами.
func getPrimeNumbers(count: UInt) -> [UInt] {
    
    if count == 0 {
        return []
    }
    
    var result: [UInt] = [2]
    var temp: UInt = 3
    
    outer: while result.count < count {
        for divisor in result {
            if temp % divisor == 0 {
                temp += 1
                continue outer
            }
        }
        
        result.append(temp)
    }
    
    return result
}

print("100 prime numbers:\n\(getPrimeNumbers(count: 100))")

