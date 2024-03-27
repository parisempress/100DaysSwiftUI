import SwiftUI

struct ContentView: View {
    @State private var input: Double = 100.0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    @State private var selectedUnits = 0

    @FocusState private var inputIsFocused: Bool

    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    let unitTypes = [ [UnitLength.feet, UnitLength.kilometers, UnitLength.meters, UnitLength.miles, UnitLength.yards],
                      [UnitMass.grams, UnitMass.ounces, UnitMass.kilograms],
                      [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]

    let units: [UnitLength] = [.feet, .kilometers, .meters, .miles, .yards]
    let formatter: MeasurementFormatter

    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outMeasurement = inputMeasurement.converted(to: outputUnit)
        return formatter.string(from: outMeasurement)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Amount to convert") {
                    TextField("Input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }

                Picker("Conversion", selection: $selectedUnits) {
                    ForEach(0..<conversions.count, id:\.self){
                        Text(conversions[$0])
                    }
                }
                Picker("Convert From", selection: $inputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }

                Picker("Convert To", selection: $outputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
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
            .onChange(of: selectedUnits) {
                let units = unitTypes[selectedUnits]
                inputUnit = units[0]
                outputUnit = units[1]
            }
        }
    }
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}


#Preview {
    ContentView()
}

