import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sleepDataManager: SleepDataManager
    
    var body: some View {
        ZStack {
            // Background Image
            AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1508182315878-4e74257d26a3")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.black
            }
            .ignoresSafeArea()
            
            // Gradient Overlay
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.6), .black.opacity(0.3)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            // Content
            VStack(spacing: 30) {
                Text("Sleep Tracker")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Spacer()
                
                VStack(spacing: 20) {
                    NavigationLink(destination: SleepTrackingView()) {
                        HStack {
                            Image(systemName: "moon.stars.fill")
                            Text("Start Sleep Tracking")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.6))
                        .cornerRadius(15)
                    }
                    
                    NavigationLink(destination: SleepLogView()) {
                        HStack {
                            Image(systemName: "list.bullet.clipboard.fill")
                            Text("View Sleep Log")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple.opacity(0.6))
                        .cornerRadius(15)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HomeView()
        .environmentObject(SleepDataManager())
}