import SwiftUI

struct SleepLogView: View {
    @EnvironmentObject var sleepDataManager: SleepDataManager
    
    var body: some View {
        ZStack {
            // Background
            Color.black.opacity(0.9)
                .ignoresSafeArea()
            
            VStack {
                if sleepDataManager.sessions.isEmpty {
                    // Empty State
                    VStack(spacing: 20) {
                        Image(systemName: "moon.zzz.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No sleep sessions recorded yet")
                            .font(.title3)
                            .foregroundColor(.gray)
                    }
                } else {
                    // Sleep Sessions List
                    List {
                        ForEach(sleepDataManager.sessions.sorted(by: { $0.startTime > $1.startTime })) { session in
                            SleepSessionRow(session: session)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
        }
        .navigationBarTitle("Sleep Log", displayMode: .inline)
    }
}

struct SleepSessionRow: View {
    let session: SleepSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "moon.stars.fill")
                    .foregroundColor(.blue)
                Text(formatDate(session.startTime))
                    .font(.headline)
                Spacer()
            }
            
            HStack {
                Image(systemName: "clock.fill")
                    .foregroundColor(.purple)
                Text(session.durationFormatted)
                    .font(.subheadline)
                Spacer()
            }
        }
        .padding(.vertical, 8)
        .listRowBackground(Color.black.opacity(0.8))
        .foregroundColor(.white)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationView {
        SleepLogView()
            .environmentObject(SleepDataManager())
    }
}