import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var multiplicationTable = 2
    @State private var numberOfQuestions = 5
    @State private var questions:[Question] = []
    @State private var randomImage: String = ""
    @State private var randomImageQuestion: String = ""
    @State private var imageScale: CGFloat = 1.0

    let animals = ["chicken", "frog", "bear", "cow", "buffalo"]


    var body: some View {
        NavigationView {

            VStack {
                Stepper("Choose Multiplication Table", value: $multiplicationTable, in: 1...12)
                    .fontWeight(.bold)
                    .onChange(of: multiplicationTable, initial: true, { oldValue, newValue in
                        generateQuestionsAndAnswers()
                        randomImage = animals.randomElement() ?? "chicken"
                    })

                HStack {
                    Text("Multiplication Table is \(multiplicationTable)")
                        .padding()
                        .font(.subheadline)
                    Image(randomImage)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .scaleEffect(imageScale)
                        .animation(.easeInOut(duration: 5), value: randomImage)


                }
                Spacer()
                Stepper("Choose number of questions", value: $numberOfQuestions, in: 5...20, step: 5)
                    .fontWeight(.bold)
                    .onChange(of:numberOfQuestions, initial: true, { oldValue, newValue in
                        generateQuestionsAndAnswers()
                        randomImageQuestion = animals.randomElement() ?? "chicken"
                    })

                HStack {
                    Text("Number of questions is \(numberOfQuestions)")
                        .padding()
                    Image(randomImageQuestion)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                Spacer()
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
            .padding(16)
            .navigationTitle("Multiplication Quiz")
            .background(.green).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        }

    }

    func generateQuestionsAndAnswers() {
        questions.removeAll()
        for _ in 1...numberOfQuestions {
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
