//
//  ContentView.swift
//  Challenge 1
//
//  Created by Rochelle Simone Lawrence on 11.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 0.0
    @State private var outputValue: Double = 0.0
    @State private var unit: String = "meters"

    let lengthOutputUnits = ["meters", "kilometers", "feet", "yard"]
    let lengthInputUnits = ["meters", "kilometers", "feet", "yard"]

    var convertToMeters: Double {
        return inputValue * 100
    }
    var convertToKilometer: Double {
        return inputValue * 1000
    }
    var convertToFeet: Double {
        return inputValue
    }
    var convertToYard: Double {
        return inputValue
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Input", value: $inputValue, format: .number)
                Section("Length Conversion") {
                    Picker("Conversion", selection: $unit) {
                        ForEach(lengthOutputUnits, id: \.self) { unit in
                               Text(unit)
                           }
                    }
                    .pickerStyle(.segmented)
                }

                Text("Output is \(convertToKilometer)")
                Section("Length Conversion") {
                    Picker("Conversion", selection: $unit) {
                        ForEach(lengthInputUnits, id: \.self) { unit in
                               Text(unit)
                           }
                    }
                    .pickerStyle(.segmented)
                }

            }
            .navigationTitle("Unit Converter")
        }

    }
}

#Preview {
    ContentView()
}
