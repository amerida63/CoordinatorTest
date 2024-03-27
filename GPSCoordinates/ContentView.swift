//
//  ContentView.swift
//  GPSCoordinates
//
//  Created by Anthony merida on 27/3/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var latitude1 = ""
    @State private var longitude1 = ""
    @State private var latitude2 = ""
    @State private var longitude2 = ""
    @State private var distance = ""
    @State private var distanceCoseno = ""
    @State private var distanceHaversine = ""


    @State private var cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
           center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
           span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
       ))
    @State private var showingAlert = false


    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Location 1")
                    TextField("Latitude", text: $latitude1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)

                    TextField("Longitude", text: $longitude1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)

                VStack(alignment: .leading) {
                    Text("Location 2")
                    TextField("Latitude", text: $latitude2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                    TextField("Longitude", text: $longitude2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numbersAndPunctuation)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
            }


            Button("Calculate Distance") {
                calculateDistance()
            }
            .padding()

            if !distance.isEmpty {
                VStack {
                    HStack {
                        Text("Apple:")
                        Text(distance)
                            .padding()
                    }
                    HStack {
                        Text("Coseno:")
                        Text(distanceCoseno)
                            .padding()
                    }
                    HStack {
                        Text("Haversine:")
                        Text(distanceHaversine)
                            .padding()
                    }
                }
            }

            Map(position: $cameraPosition)
                .frame(height: 300)
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Error"),
                message: Text("Could not calculate distance. Please check coordinates."),
                dismissButton: .default(Text("OK")) {
                            showingAlert = false
                        })
               }
    }

    func calculateDistance() {

        guard
        let lat1 = CLLocationDegrees(latitude1),
        let lon1 = CLLocationDegrees(longitude1),
        let lat2 = CLLocationDegrees(latitude2),
        let lon2 = CLLocationDegrees(longitude2)
        else {
            showingAlert = true
            return
        }

        let calculator = CoordinateCalculator(
            lat1: lat1,
            lon1: lon1,
            lat2: lat2,
            lon2: lon2
        )

        distance = calculator.distanceApple()
        distanceCoseno = calculator.distanceUsingCoseno()
        distanceHaversine = calculator.distanceUsingHaversine()

        let center = CLLocationCoordinate2D(latitude: (lat1 + lat2) / 2,
                                            longitude: (lon1 + lon2) / 2)
        let span = MKCoordinateSpan(latitudeDelta: abs(lat1 - lat2) * 1.5,
                                    longitudeDelta: abs(lon1 - lon2) * 1.5)

        cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
            center: center,
            span: span
        ))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
