//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Rochelle Simone Lawrence on 22.07.24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order

    @State private var confirmationMessage = ""
    @State private var errorMessage = ""
    @State private var showingConfirmation = false
    @State private var serverConnection = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string:  "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3)  { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("Ok") { }
        } message: {
            Text(errorMessage)
        }
        .alert("ConnectionIssues", isPresented: $serverConnection) {
            Button("Ok") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://regres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "Post"

        do {
            let(data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the the way"
            showingConfirmation = true
        } catch {
            errorMessage = "Sorry Check out failed. \n\nMessage: \(error.localizedDescription)"
            serverConnection = true
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
