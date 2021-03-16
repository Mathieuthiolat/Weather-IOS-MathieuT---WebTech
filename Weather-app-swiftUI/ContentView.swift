//
//  ContentView.swift
//  Weather-app-swiftUI
//
//  Created by Lilian on 08/03/2021.
//

import SwiftUI

struct ContentView: View {
    var weatherViewModel = WeatherViewModel()
    @State var townName: String?
    @State private var townSearch: String = ""
    @State private var weather: WeatherModel?
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient (
                gradient: Gradient(colors: colors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).edgesIgnoringSafeArea(.all)
            VStack {
                Text( weather?.city.fullName ?? "Ville" )
                    .font(.system(size: 50, weight:.medium, design:.default))
                    .foregroundColor(Color.white)
                    .padding()
                Image(systemName: weather?.firstHour?.imageName ?? "cloud.sun.rain.fill")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                Text(weather?.firstHour?.temperature.formatedCelsius ?? "00°C")
                    .font(.system(size: 50, weight:.medium, design:.default))
                    .foregroundColor(Color.white)
                    .padding(Edge.Set.bottom, 40)
                HStack(spacing: 10)  {
                    HourlyWeather( weatherContent: weather?.firstHour)
                    HourlyWeather( weatherContent: weather?.secondHour)
                    HourlyWeather( weatherContent: weather?.thirdHour)
                    HourlyWeather( weatherContent: weather?.fourthHour)
                    HourlyWeather( weatherContent: weather?.fifthHour)
                }
                Spacer()
                Button("Choisir sa Ville",action:openAlert)
                    .padding(10)
                    .background(Color.white)
                    .font(.system(size: 25, weight:.medium, design:.default))
                    .foregroundColor(Color.black)
                    .cornerRadius(15)
                
            }
            TownSelectAlert(show: $showPopUp, townSearch: self.$townSearch, onDone: {townSearch in loadData(townOnLoad: townSearch)})
        }
        .onAppear(perform: {loadData(townOnLoad: townName ?? "Paris")})
    }
    
    var colors: [Color] {
        if weather?.firstHour?.temperature.isHot ?? false {
            return [Color.red , Color("lightRed")]
        } else {
            return [Color.blue , Color("lightBlue")]
        }
    }
    
    func loadData(townOnLoad: String) {
        weatherViewModel.showHandler = { weather in
            DispatchQueue.main.async {
                self.weather = weather
            }
        }
        weatherViewModel.getWeather(ownTown:townOnLoad)
    }
    
    private func openAlert() {
        //weatherViewModel.getWeather(ownTown: "Lyon")
        withAnimation(.linear(duration: 0.3)) {
            showPopUp.toggle()
        }	
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct HourlyWeather: View {
    var weatherContent: Weather?
    var body: some View {
        VStack(spacing: 10) {
            Text(weatherContent?.formattedDate ?? "00h")
                .font(.system(size: 20, weight:.medium, design:.default))
                .foregroundColor(Color.white)
            Image(systemName: weatherContent?.imageName ?? "cloud.sun.rain.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text( weatherContent?.temperature.formatedCelsius ?? "0°C" )
                .font(.system(size: 20, weight:.medium, design:.default))
                .foregroundColor(Color.white)
        }
    }
}
