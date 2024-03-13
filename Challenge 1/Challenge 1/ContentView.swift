//
//  ContentView.swift
//  Challenge 1
//
//  Created by Rochelle Simone Lawrence on 11.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var input: Double = 100.0
    @State private var inputUnit: String = "Meters"
    @State private var outputUnit: String = "Kilometers"

    @FocusState private var inputIsFocused: Bool


    let units = ["Meters", "Kilometers", "Feet", "Yard", "Miles"]

    var result: String {
        let inputToMeterMultiplier: Double
        let meterToOutputMultiplier: Double

        switch inputUnit {
        case "Feet":
            inputToMeterMultiplier = 0.3048
        case "Kilometers":
            inputToMeterMultiplier = 1000
        case "Miles":
            inputToMeterMultiplier = 1609.34
        case "Yards":
            inputToMeterMultiplier = 0.9144
        default:
            inputToMeterMultiplier = 1.0
        }

        switch outputUnit {
        case "Feet":
            meterToOutputMultiplier = 3.28884
        case "Kilometers":
            meterToOutputMultiplier = 0.001
        case "Miles":
            meterToOutputMultiplier = 0.000621371
        case "Yards":
            meterToOutputMultiplier = 1.09361
        default:
            meterToOutputMultiplier = 1.0
        }

        let inputInMeters = input * inputToMeterMultiplier
        let output = inputInMeters * meterToOutputMultiplier

        let outputString = output.formatted()
        return "\(outputString) \(outputUnit.lowercased())"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Amount to convert") {
                    TextField("Input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }

                Picker("Convert From", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }

                Picker("Convert To", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text($0)
                    }
                }

                Section("Result") {
                    Text(result)
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }

    }
}

#Preview {
    ContentView()
}
