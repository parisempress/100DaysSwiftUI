import  SwiftUI

struct QuizView: View {
    var questions: [Question]

    @State private var userAnswers: [String] = []
    @State private var score = 0
    @State private var showScore = false

    var body: some View {
        VStack {
            List {
                ForEach(0..<questions.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text(questions[index].text)
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
                VStack {
                    let scorePercentage = (score/questions.count) * 100
                    scorePercentage >= 80 ? Text("Keep up the good work😊!") :
                    Text("Continue to Practice😞")
                    Text("Score: \(score) / \(questions.count)")
                        .font(.title)
                        .padding()
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Quiz")
    }

    func checkAnswers() {
        score = 0
        for i in 0..<questions.count {
            if i < userAnswers.count, let userAnswer = Int(userAnswers[i]), userAnswer == questions[i].answer
            {
                score += 1
            }
        }
        showScore = true
    }
}
