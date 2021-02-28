import UIKit

// Решите квадратное уравнение
let a: Double? = 2
let b: Double? = 4
let c: Double? = 2

if let a = a, let b = b, let c = c {
    let d: Double = b * b - 4 * a * c
    
    if d < 0 {
        print("No roots")
    }
    else if d == 0 {
        print("x = \(-b / (2 * a))")
    }
    else {
        let d_sqrt = Double(d).squareRoot()
        print("x1 = \((-b + d_sqrt) / (2 * a))")
        print("x2 = \((-b - d_sqrt) / (2 * a))")
    }
}
else {
    print("Incorrect data")
}


// Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
let k1: Double? = 3
let k2: Double? = 4

if let k1 = k1, let k2 = k2 {
    let h = (k1 * k1 + k2 * k2).squareRoot()
    let s = 0.5 * k1 * k2
    let p = k1 + k2 + h
    
    print("Hypotenuse = \(h)")
    print("S = \(s)")
    print("P = \(p)")
}
else {
    print("Incorrect data")
}


// Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
let deposit: Double = 150_000
let percent: Double = 15

let result = deposit * pow((1 + 0.01 * percent), 5)
