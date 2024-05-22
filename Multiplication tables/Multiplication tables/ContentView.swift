import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var questions:[Question] = []

    var body: some View {
        NavigationView {
            VStack {
                Stepper("Choose Multiplication Table", value: $multiplicationTable, in: 1...12)
                    .onChange(of: multiplicationTable, initial: true, { oldValue, newValue in
                        generateQuestionsAndAnswers()
                    })


                Text("Multiplication Table is \(multiplicationTable)")
                    .padding()

                Stepper("Choose number of questions", value: $numberOfQuestions, in: 5...20, step: 5)
                    .onChange(of:numberOfQuestions, initial: true, { oldValue, newValue in
                        generateQuestionsAndAnswers()
                    })


                Text("Number of questions is \(numberOfQuestions)")
                    .padding()

                NavigationLink(destination:
                QuizView(questions: questions)) {
                    Text("Submit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .onAppear(perform: generateQuestionsAndAnswers)

                Spacer()
            }
            .padding()
            .navigationTitle("Multiplication Quiz")
        }
    }

    func generateQuestionsAndAnswers() {
        questions.removeAll()
        for i in 1...numberOfQuestions {
            let first = multiplicationTable
            let second = Int.random(in: 1...multiplicationTable)
            let question = Question(text:"Multiply \(first) x \(second)", answer: first * second)
            questions.append(question)
        }
    }
}


#Preview {
    ContentView()
}
