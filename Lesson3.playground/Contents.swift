import UIKit

struct SportCar {
    public var brand: String
    public var model: String
    public var releaseDate: String
    public var trunkVolume: Int
    public var bodyVolume: Int
    public var isEngineRunning: Bool = false
    public var areWindowsOpened: Bool = false
    public var maxSpeed: Int
    public var torqueOutput: Int
    
    var filledTrunkVolume: Int = 0 {
        didSet {
            if filledTrunkVolume > trunkVolume {
                print("Trunk overloaded! Last load was dropped.")
                filledTrunkVolume = oldValue
            } else if filledTrunkVolume < 0 {
                print("There is not enough load to be dropped! Last load wasn't dropped.")
            } else {
                print("Current filled trunk volume - \(filledTrunkVolume), max - \(trunkVolume)")
            }
        }
    }
    
    var filledBodyVolume: Int = 0 {
        didSet {
            if filledBodyVolume > bodyVolume {
                print("Body overloaded! Last load was dropped.")
                filledBodyVolume = oldValue
            } else if filledBodyVolume < 0 {
                print("There is not enough load to be dropped! Last load wasn't dropped.")
            } else {
                print("Current filled body volume - \(filledBodyVolume), max - \(bodyVolume)")
            }
        }
    }
    
    mutating func makeAction(_ action: CarAction) {
        switch action {
        case .engineAction(let start):
            isEngineRunning = start
        case .loadCar(let trunk, let body):
            filledTrunkVolume += trunk
            filledBodyVolume += body
        case .unloadCar(let trunk, let body):
            filledTrunkVolume -= trunk
            filledBodyVolume -= body
        case .windowsAction(let open):
            areWindowsOpened = open
        }
    }
    
    func printCarInfo() {
        print("""
            ***********************************************
            Car:             \(brand) \(model)
            Release date:    \(releaseDate)
            Trunk volume:    \(trunkVolume) l.
            Body volume:     \(bodyVolume) l.
            Maximum speed:   \(maxSpeed) km/h
            Torque output:   \(torqueOutput) n/m
            Engine:          \(isEngineRunning ? "RUNNING" : "NOT RUNNING")
            Windows:         \(areWindowsOpened ? "OPENED" : "CLOSED")
            ***********************************************\n\n
            """)
    }
}


struct TrunkCar {
    var brand: String
    var model: String
    var releaseDate: String
    var trunkVolume: Int
    var bodyVolume: Int
    var isEngineRunning: Bool = false
    var areWindowsOpened: Bool = false
    var maxTonnage: Int
    
    var filledTrunkVolume: Int = 0 {
        didSet {
            if filledTrunkVolume > trunkVolume {
                print("Trunk overloaded! Last load was dropped.")
                filledTrunkVolume = oldValue
            } else if filledTrunkVolume < 0 {
                print("There is not enough load to be dropped! Last load wasn't dropped.")
            } else {
                print("Current filled trunk volume - \(filledTrunkVolume), max - \(trunkVolume)")
            }
        }
    }
    
    var filledBodyVolume: Int = 0 {
        didSet {
            if filledBodyVolume > bodyVolume {
                print("Body overloaded! Last load was dropped.")
                filledBodyVolume = oldValue
            } else if filledBodyVolume < 0 {
                print("There is not enough load to be dropped! Last load wasn't dropped.")
            } else {
                print("Current filled body volume - \(filledBodyVolume), max - \(bodyVolume)")
            }
        }
    }
    
    mutating func makeAction(_ action: CarAction) {
        switch action {
        case .engineAction(let start):
            isEngineRunning = start
        case .loadCar(let trunk, let body):
            filledTrunkVolume += trunk
            filledBodyVolume += body
        case .unloadCar(let trunk, let body):
            filledTrunkVolume -= trunk
            filledBodyVolume -= body
        case .windowsAction(let open):
            areWindowsOpened = open
        }
    }
    
    func printCarInfo() {
        print("""
            ***********************************************
            Car:             \(brand) \(model)
            Release date:    \(releaseDate)
            Trunk volume:    \(trunkVolume) l.
            Body volume:     \(bodyVolume) l.
            Maximum tonnage: \(maxTonnage) t.
            Engine:          \(isEngineRunning ? "RUNNING" : "NOT RUNNING")
            Windows:         \(areWindowsOpened ? "OPENED" : "CLOSED")
            ***********************************************\n\n
            """)
    }
}


enum CarAction {
    case engineAction(start: Bool)
    case windowsAction(open: Bool)
    case loadCar(trunk: Int, body: Int)
    case unloadCar(trunk: Int, body: Int)
}


var sportCar = SportCar(brand: "Porshe", model: "911", releaseDate: "October 23, 1984", trunkVolume: 350, bodyVolume: 1100, maxSpeed: 280, torqueOutput: 700)

var trunkCar = TrunkCar(brand: "Volvo", model: "X98C", releaseDate: "January 14, 2007", trunkVolume: 18000, bodyVolume: 1500, maxTonnage: 7)

sportCar.makeAction(.engineAction(start: true))
sportCar.makeAction(.loadCar(trunk: 150, body: 50))
sportCar.makeAction(.loadCar(trunk: 250, body: 50))
sportCar.printCarInfo()

trunkCar.makeAction(.windowsAction(open: true))
trunkCar.printCarInfo()


