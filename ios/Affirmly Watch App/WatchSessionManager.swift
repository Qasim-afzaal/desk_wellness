import Foundation
import WatchConnectivity

/// Receives affirmations from the Affirmly iPhone app via WatchConnectivity.
final class WatchSessionManager: NSObject, ObservableObject {
    static let shared = WatchSessionManager()

    @Published var affirmation: String = "I am enough."
    @Published var isReachable = false
    @Published var lastUpdated = Date()

    private let session = WCSession.default

    private override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }

    private func applyContext(_ context: [String: Any]) {
        if let text = context["affirmation"] as? String, !text.isEmpty {
            affirmation = text
            lastUpdated = Date()
        }
    }
}

extension WatchSessionManager: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.isReachable = session.isReachable
            self.applyContext(session.receivedApplicationContext)
        }
    }

    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async { self.isReachable = session.isReachable }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async { self.applyContext(message) }
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        DispatchQueue.main.async { self.applyContext(applicationContext) }
    }
}
