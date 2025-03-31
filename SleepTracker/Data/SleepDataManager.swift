import Foundation
import SwiftUI

class SleepDataManager: ObservableObject {
    @Published var sessions: [SleepSession] = []
    @Published var currentSession: SleepSession?
    
    private let saveKey = "SleepSessions"
    
    init() {
        loadSessions()
    }
    
    func startSession() {
        currentSession = SleepSession()
        objectWillChange.send()
    }
    
    func endSession() {
        guard var session = currentSession else { return }
        session.endTime = Date()
        sessions.append(session)
        currentSession = nil
        saveSessions()
        objectWillChange.send()
    }
    
    private func loadSessions() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else { return }
        
        do {
            sessions = try JSONDecoder().decode([SleepSession].self, from: data)
        } catch {
            print("Error loading sleep sessions: \(error)")
        }
    }
    
    private func saveSessions() {
        do {
            let data = try JSONEncoder().encode(sessions)
            UserDefaults.standard.set(data, forKey: saveKey)
        } catch {
            print("Error saving sleep sessions: \(error)")
        }
    }
}