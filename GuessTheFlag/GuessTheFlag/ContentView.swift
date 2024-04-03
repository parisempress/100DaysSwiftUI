import SwiftUI

struct ContentView: View {
    static let allCountries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var countries = allCountries.shuffled()
    @State private   var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var usersScore = 0
    @State private var finalScore = false
    @State private var counter = 1

    var body: some View {
        ZStack {
            RadialGradient(stops:[.init(color: Color(red:0.1, green: 0.2, blue:0.45), location:0.3),
                                  .init(color: Color(red:0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)

                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()

                Text("Score: \(usersScore)")
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(usersScore)")
        }
        .alert("Final Score", isPresented: $finalScore){
            Button("Restart Game", action: restartGame)
        } message: {
            Text("Your final score was \(usersScore)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            usersScore += 1
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong!Thats the flag of \(countries[number]) "
            if usersScore > 0 {
                usersScore -= 1
            }
        }
        if counter == 8 {
            finalScore = true
        } else {
            showingScore = true
        }
    }

    func restartGame() {
        counter = 0
        usersScore = 0
        countries = Self.allCountries
        askQuestion()

    }

    func askQuestion() {
        countries.remove(at: correctAnswer)
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        counter += 1
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func title() -> some View {
        modifier(TitleModifier())
    }
}

#Preview {
    ContentView()
}
