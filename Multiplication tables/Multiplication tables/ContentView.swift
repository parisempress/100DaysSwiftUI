import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var questions: [String] = []
    @State private var answers: [Int] = []

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

                NavigationLink(destination: QuizView(questions: questions, answers: answers)) {
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
        questions = (1...numberOfQuestions).map { "What is \(multiplicationTable) x \($0)?" }
        answers = (1...numberOfQuestions).map { multiplicationTable * $0 }
    }
}

struct QuizView: View {
    var questions: [String]
    var answers: [Int]
    @State private var userAnswers: [String] = []
    @State private var score = 0
    @State private var showScore = false

    var body: some View {
        VStack {
            List {
                ForEach(0..<questions.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text(questions[index])
                        TextField("Your answer", text: Binding(
                            get: {
                                if userAnswers.indices.contains(index) {
                                    return userAnswers[index]
                                } else {
                                    return ""
                                }
                            },
                            set: { newValue in
                                if userAnswers.indices.contains(index) {
                                    userAnswers[index] = newValue
                                } else {
                                    userAnswers.append(newValue)
                                }
                            }
                        ))
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom)
                    }
                }
            }

            Button(action: checkAnswers) {
                Text("Check Answers")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if showScore {
                Text("Score: \(score) / \(questions.count)")
                    .font(.title)
                    .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Quiz")
    }

    func checkAnswers() {
        score = 0
        for i in 0..<answers.count {
            if i < userAnswers.count, let userAnswer = Int(userAnswers[i]), userAnswer == answers[i] {
                score += 1
            }
        }
        showScore = true
    }
}

#Preview {
    ContentView()
}
