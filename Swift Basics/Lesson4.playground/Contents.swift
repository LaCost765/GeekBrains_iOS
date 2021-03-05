

class Car {
    // Enums
    enum CarAction {
        case drive(distanceInKm: Double)
        case refuel(value: Double)
    }
    
    enum TransmissionType {
        case automatic, manual
    }
    
    enum DriveType: String {
        case FWD = "Front-wheel drive"
        case RWD = "Rear-wheel drive"
        case AWD = "All-wheel drive"
    }
    
    // Properties
    private var brand: String
    private var model: String
    private var bodyType: String
    private var transmissionType: TransmissionType
    private var driveType: DriveType
    private var tankCapacity: Double
    private var fuelLevel: Double {
        didSet {
            if fuelLevel > tankCapacity {
                fuelLevel = tankCapacity
            }
        }
    }
    // Liters on 100 km
    private var fuelConsumption: Double
    
    // Initializers
    init(brand: String, model: String, bodyType: String, transmissionType: TransmissionType, driveType: DriveType, tankCapacity: Double, fuelLevel: Double, fuelConsumption: Double) {
        self.brand = brand
        self.model = model
        self.bodyType = bodyType
        self.transmissionType = transmissionType
        self.driveType = driveType
        self.tankCapacity = tankCapacity
        self.fuelLevel = fuelLevel
        self.fuelConsumption = fuelConsumption
    }
    
    // Private methods
    private func drive(distanceInKm: Double) {
        let reqLiters = (fuelConsumption / 100) * distanceInKm
        
        if reqLiters > fuelLevel {
            let distance = (fuelLevel * 100) / fuelConsumption
            fuelLevel = 0
            
            print("Not enough fuel to drive \(distanceInKm) km!")
            print("You only drove \(distance) km, your tank is empty!")
        } else {
            fuelLevel -= reqLiters
            
            print("You have arrived at your destination!")
            print("Fuel level = \(fuelLevel) liters.")
        }
    }
    
    private func refuel(value: Double) {
        print("Fuel level: \(fuelLevel)")
        fuelLevel += value
        print("Fuel level after refuel: \(fuelLevel)")
    }
    
    // Internal methods
    func makeAction(action: CarAction) {
        switch action {
        case let .drive(distanceInKm):
            drive(distanceInKm: distanceInKm)
        case let .refuel(value):
            refuel(value: value)
        }
    }
    
    func printCarInfo() {
            print("""
                Car:                 \(brand) \(model)
                Body type:           \(bodyType)
                Transmission type:   \(transmissionType)
                Drive type:          \(driveType)
                Tank capacity:       \(tankCapacity) liters
                Fuel level:          \(fuelLevel) liters
                Fuel consumption:    \(fuelConsumption) liters on 100 km
                """)
    }
}


class SportCar: Car {
    // Enums
    enum SportCarAction {
        case carAction(action: CarAction)
        case switchDriveMode(mode: DriveMode)
        case raiseSpoiler(raise: Bool)
    }
    
    enum DriveMode {
        case sport, comfort, race
    }
    
    // Properties
    private var maxSpeed: Double
    private var driveMode: DriveMode = .comfort {
        didSet {
            switch driveMode {
            case .comfort:
                isSpoilerUsed = false
            default:
                isSpoilerUsed = true
            }
        }
    }
    private var isSpoilerUsed: Bool = false
    
    
    // Initializers
    init(brand: String, model: String, bodyType: String, transmissionType: TransmissionType, driveType: DriveType, tankCapacity: Double, fuelLevel: Double, fuelConsumption: Double, maxSpeed: Double) {
        
        self.maxSpeed = maxSpeed
        super.init(brand: brand, model: model, bodyType: bodyType, transmissionType: transmissionType, driveType: driveType, tankCapacity: tankCapacity, fuelLevel: fuelLevel, fuelConsumption: fuelConsumption)
    }
    
    // Private methods
    private func switchDriveMode(mode: DriveMode) {
        driveMode = mode
    }
    
    // Internal methods
    func makeAction(action: SportCarAction) {
        switch action {
        case let .switchDriveMode(mode):
            switchDriveMode(mode: mode)
        case let .raiseSpoiler(raise):
            isSpoilerUsed = raise
        case let .carAction(action):
            super.makeAction(action: action)
        }
    }
    
    override func printCarInfo() {
        print("\n\n******************************")
        super.printCarInfo()
        print("Maximum speed:       \(maxSpeed) km/h")
        print("Drive mode:          \(driveMode)")
        print("Spoiler:             \(isSpoilerUsed ? "ON" : "OFF")")
        print("******************************\n\n")
    }
}


class TrunkCar: Car {
    // Enums
    enum TrunkCarAction {
        case carAction(action: CarAction)
        case loadTrunk(value: UInt)
        case unloadTrunk(value: UInt)
    }
    
    // Properties
    private var trunkVolume: UInt
    private var filledTrunkVolume: UInt = 0 {
        didSet {
            if filledTrunkVolume > trunkVolume {
                filledTrunkVolume = trunkVolume
            }
        }
    }
    
    // Initializers
    init(brand: String, model: String, bodyType: String, transmissionType: TransmissionType, driveType: DriveType, tankCapacity: Double, fuelLevel: Double, fuelConsumption: Double, trunkVolume: UInt) {
        
        self.trunkVolume = trunkVolume
        super.init(brand: brand, model: model, bodyType: bodyType, transmissionType: transmissionType, driveType: driveType, tankCapacity: tankCapacity, fuelLevel: fuelLevel, fuelConsumption: fuelConsumption)
    }
    
    // Private methods
    private func loadTrunk(value: UInt) {
        filledTrunkVolume += value
    }
    
    private func unloadTrunk(value: UInt) {
        filledTrunkVolume -= value
    }
    
    // Internal methods
    func makeAction(action: TrunkCarAction) {
        switch action {
        case let .loadTrunk(value):
            loadTrunk(value: value)
        case let .unloadTrunk(value):
            unloadTrunk(value: value)
        case let .carAction(action):
            super.makeAction(action: action)
        }
    }
    
    override func printCarInfo() {
        print("\n\n******************************")
        super.printCarInfo()
        print("Trunk volume:        \(trunkVolume) tons")
        print("Filled trunk volume: \(filledTrunkVolume) tons")
        print("******************************\n\n")
    }
}


var sportCar = SportCar(brand: "Porshe", model: "911", bodyType: "Coupe", transmissionType: .automatic, driveType: .AWD, tankCapacity: 50, fuelLevel: 30, fuelConsumption: 8, maxSpeed: 340)

var trunkCar = TrunkCar(brand: "MAN", model: "Grunwald", bodyType: "Dump truck", transmissionType: .manual, driveType: .RWD, tankCapacity: 120, fuelLevel: 70, fuelConsumption: 15, trunkVolume: 15)

sportCar.printCarInfo()
sportCar.makeAction(action: .switchDriveMode(mode: .sport))
sportCar.makeAction(action: .refuel(value: 20))
sportCar.makeAction(action: .drive(distanceInKm: 130))
sportCar.printCarInfo()


trunkCar.makeAction(action: .loadTrunk(value: 5))
trunkCar.makeAction(action: .refuel(value: 30))
trunkCar.printCarInfo()
trunkCar.makeAction(action: .drive(distanceInKm: 50))
trunkCar.makeAction(action: .unloadTrunk(value: 5))
trunkCar.printCarInfo()
