import SwiftUI

struct ContentView: View {
    @State private var data = Activities()
    @State private var showingNewActivity = false
    @State private var count = 0
    
    var body: some View {
        NavigationStack {
            List(data.activities) { activity in
                NavigationLink {
                    ActivityView(data: data, activity: activity)
                } label: {
                    HStack {
                        Text(activity.title)
                        
                        Spacer()
                        
                        Text(String(activity.completionCount))
                            .font(.caption.weight(.black))
                            .padding(5)
                            .frame(minWidth: 50)
                            .background(color(for: activity))
                            .foregroundColor(.white)
                            .clipShape(.capsule)
                    }
                }
            }
            .navigationTitle("Habit Tracking")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Add new activity", systemImage: "plus") {
                    showingNewActivity.toggle()
                }
            }
            .sheet(isPresented: $showingNewActivity) {
                AddNewActivity(data: data)
            }
        }
        
    }
    
    func color(for activity: Activity) -> Color {
        if activity.completionCount < 3 {
            .red
        } else if activity.completionCount < 10 {
            .orange
        } else if activity.completionCount < 20 {
            .blue
        } else {
            .indigo
        }
    }
    
}

#Preview {
    ContentView()
}

