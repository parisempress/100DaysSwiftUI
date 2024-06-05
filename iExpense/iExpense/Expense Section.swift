import SwiftUI

struct Expense_Section: View {
    let title:String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    let localCurrency = Locale.current.currency?.identifier ?? "USD"


    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    Spacer()

                    Text(item.amount, format: .currency(code: localCurrency))
                        .foregroundColor(item.amount <= 10 ? .blue : item.amount <= 100 ? .green : .red)
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
}

#Preview {
    Expense_Section(title: "Personal", expenses: []) { _ in

    }
}
