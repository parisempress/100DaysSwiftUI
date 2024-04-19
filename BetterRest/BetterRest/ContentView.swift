import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }

    var sleepResults: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep

            return "Your ideal bedtime is  " + sleepTime.formatted(date: .omitted, time:.shortened)
        } catch {
            return "There was an error"
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section() {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute).labelsHidden()
                } header: {
                    Text("When do you want to wake up")
                }

                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                Section("Daily coffee intake")  {
                    Picker("Cup(s)", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text(String($0))
                        }
                    }
                }
                Text(sleepResults)
                    .font(.title3)
                    .navigationTitle("BetterRest")

            }
        }
    }

}

#Preview {
    ContentView()
}
