import UIKit

// JSON Data model
struct WeatherResponseModel: Decodable {
    var weather: [Weather]
    var main: MainInfo
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    
    func printWeather(representation form: RepresentationForm) {
        switch form {
        case .short:
            print("""
                     Temprature:  \(main.temp)°
                     Wind speed:  \(wind.speed) m/s
                     Description: \(weather[0].description)
                     """)
        case .normal:
            print("""
                     Temprature:        \(main.temp)°
                     Max temprature:    \(main.temp_max)°
                     Min temprature:    \(main.temp_min)°
                     Wind speed:        \(wind.speed) m/s
                     Clouds:            \(clouds.all) %
                     Description:       \(weather[0].description)
                     """)
        case .full:
            print("""
                     Temprature:        \(main.temp)°
                     Feels like:        \(main.feels_like)°
                     Max temprature:    \(main.temp_max)°
                     Min temprature:    \(main.temp_min)°
                     Wind speed:        \(wind.speed) m/s
                     Clouds:            \(clouds.all) %
                     Pressure:          \(main.pressure)
                     Humidity:          \(main.humidity)
                     Description:       \(weather[0].description)
                     """)
        }
        
    }
    
    struct Weather: Decodable {
        var id: Int
        var main: String
        var description: String
        var icon: String
    }
    
    struct Wind: Decodable {
        var speed: Double
        var deg: Int
    }
    
    struct MainInfo: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Int
        var humidity: Int
    }
    
    struct Clouds: Decodable {
        var all: Int
    }
    
    enum RepresentationForm {
        case short
        case normal
        case full
    }
}


protocol HttpClient {
    associatedtype ResponseModel
    func httpGet(url: URL, responseHandler: @escaping ((data: Data?, response: URLResponse?, error: Error?)) throws -> ResponseModel) throws -> ResponseModel
    func httpPost()
}


extension WeatherClient.WeatherClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Url is incorrect", comment: "")
        case .noDataAvailable:
            return NSLocalizedString("No data returned from server", comment: "")
        case .httpError(let code):
            return NSLocalizedString("HTTP Error, status code: \(code)", comment: "")
        }
    }
}

// Main class to get weather
class WeatherClient: HttpClient {
    
    // Nested types
    typealias ResponseModel = WeatherResponseModel
    
    enum WeatherClientError: Error {
        case invalidUrl
        case noDataAvailable
        case httpError(code: Int)
    }
    
    // Properties
    private var apiKey: String
    
    // Initializers
    init(key: String) {
        apiKey = key
    }
    
    // Methods
    
    func changeApiKey(key value: String) {
        apiKey = value
    }
    
    func httpPost() {
        
    }
    
    func httpGet(url: URL, responseHandler: @escaping ((data: Data?, response: URLResponse?, error: Error?)) throws -> ResponseModel) throws -> ResponseModel {
        
        // create session
        let session = URLSession.shared
        let semaphore = DispatchSemaphore(value: 0)
        
        // get response
        var responseTuple: (data: Data?, response: URLResponse?, error: Error?)
        
        session.dataTask(with: url) { (data, response, error) in
            responseTuple = (data, response, error)
            semaphore.signal()
        }.resume()
        
        semaphore.wait()
        
        // handle response
        do {
            return try responseHandler(responseTuple)
        } catch {
            throw error
        }
    }
    
    func getWeatherInCity(in city: String) -> (weather: WeatherResponseModel?, error: Error?) {
        
        // create url
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric") else {
            return (nil, WeatherClientError.invalidUrl)
        }
        
        do {
            // make GET request
            let semaphore = DispatchSemaphore(value: 0)
            let data = try httpGet(url: url) { responseTuple -> WeatherClient.ResponseModel in
                
                // print response and throw error if status code != 2**
                if let response = responseTuple.response as? HTTPURLResponse {
                    print("Response: \(response.statusCode)")
                    if (response.statusCode / 100) != 2 {
                        throw WeatherClientError.httpError(code: response.statusCode )
                    }
                }

                // try to get data
                guard let data = responseTuple.data else {
                    throw WeatherClientError.noDataAvailable
                }

                // decode data from server response
                let responseData = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
                semaphore.signal()
                
                return responseData
            }
            
            semaphore.wait()
            return (data, nil)
        } catch {
            return (nil, error)
        }
    }
}



var client = WeatherClient(key: "712ffc45bd6019afc4eb24023ed5779a")

// Valid case
var weather = client.getWeatherInCity(in: "Moscow")
if let data = weather.weather {
    data.printWeather(representation: .normal)
} else {
    print(weather.error?.localizedDescription ?? "Some error")
}
print("\n")

// Case with incorrect city
weather = client.getWeatherInCity(in: "InvalidCity")
if let data = weather.weather {
    data.printWeather(representation: .normal)
} else {
    print(weather.error?.localizedDescription ?? "Some error")
}
print("\n")

// Case with incorrect api key
client.changeApiKey(key: "123123")
weather = client.getWeatherInCity(in: "Murmansk")
if let data = weather.weather {
    data.printWeather(representation: .normal)
} else {
    print(weather.error?.localizedDescription ?? "Some error")
}
print("\n")

