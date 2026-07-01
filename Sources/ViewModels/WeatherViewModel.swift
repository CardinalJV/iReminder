//
//  WeatherViewModel.swift
//  iReminder
//

import CoreLocation
import SwiftUI
import WeatherKit

@Observable
final class WeatherViewModel: NSObject, CLLocationManagerDelegate {
  var symbolName = "cloud"
  var temperatureText = "--"
  
  @ObservationIgnored private let locationManager = CLLocationManager()
  @ObservationIgnored private let weatherService = WeatherService.shared
  
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
  }
  
  @ObservationIgnored private var isRunningInSimulator: Bool {
    ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
  }
  
  private func applyMockWeather() {
    symbolName = "sun.max"
    temperatureText = "24"
  }
  
  func requestWeather() {
    if isRunningInSimulator {
      applyMockWeather()
      return
    }
    
    print("Weather authorization status: \(locationManager.authorizationStatus.rawValue)")
    switch locationManager.authorizationStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      print("Requesting current location for weather")
      locationManager.requestLocation()
    case .notDetermined:
      print("Requesting location authorization for weather")
      locationManager.requestWhenInUseAuthorization()
    case .denied, .restricted:
      symbolName = "location.slash"
      temperatureText = "--°"
    @unknown default:
      symbolName = "location.slash"
    }
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    if isRunningInSimulator {
      applyMockWeather()
      return
    }
    
    switch manager.authorizationStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      print("Location authorized, requesting location for weather")
      manager.requestLocation()
    case .denied, .restricted:
      symbolName = "location.slash"
    case .notDetermined:
      break
    @unknown default:
      symbolName = "location.slash"
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if isRunningInSimulator {
      applyMockWeather()
      return
    }
    
    guard let location = locations.last else { return }
    
    Task {
      do {
        print("Fetching current weather for: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        let currentWeather = try await weatherService.weather(for: location, including: .current)
        let temperature = currentWeather.temperature.converted(to: .celsius).value.rounded()
        await MainActor.run {
          self.symbolName = currentWeather.symbolName
          self.temperatureText = "\(Int(temperature))°"
        }
      } catch {
        print("WeatherKit request failed: \(error)")
        await MainActor.run {
          self.symbolName = "cloud"
          self.temperatureText = "--°"
        }
      }
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
    if isRunningInSimulator {
      applyMockWeather()
      return
    }
    
    print("Location request failed: \(error)")
    symbolName = "cloud"
    temperatureText = "--°"
  }
}
