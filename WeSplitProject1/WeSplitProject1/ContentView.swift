import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    let localCurrency = Locale.current.currency?.identifier ?? "USD"

    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }

    var totalPerPerson: Double {
        totalAmount/Double(numberOfPeople + 2)
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: localCurrency ))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                }

                Section {
                    Text(totalPerPerson, format: .currency(code: localCurrency))
                } header: {
                    Text("Amount per person")
                }

                Section("Total amount for check") {
                    Text(totalAmount, format: .currency(code: localCurrency))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
