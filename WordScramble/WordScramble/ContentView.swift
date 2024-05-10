import SwiftUI


struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""


    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var showingScore = false
    @State private var score = 0

    var body: some View {
        NavigationStack {
            List {
                Section {

                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)

                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }

                }
            }
            .safeAreaInset(edge: .bottom) {
                Text("Score: \(score)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .font(.title)
            }

            .navigationTitle(rootWord)
            .onSubmit (addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("New Game",action: startGame)
            }

        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 3 else {
wordError(title: "Word too short", message: "Words must be at least four letters long.")
 return
}

        guard answer != rootWord else {
wordError(title: "Nice try...", message: "You can't use your starting word")
 return }

        guard isOriginal(word: answer) else {
            wordError(title: "word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You cant  just make them up")
            return
        }
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
       score += answer.count
       newWord = ""

    }

    func startGame() {
        usedWords.removeAll()
        newWord = ""
        score  = 0
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load")
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord  = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    func isReal(word:String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
