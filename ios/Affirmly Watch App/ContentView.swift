import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var session: WatchSessionManager

    private var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: Date())
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 8) {
                Text(timeString)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.45))

                Spacer(minLength: 4)

                Text(session.affirmation)
                    .font(.system(.title3, design: .serif))
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .minimumScaleFactor(0.7)
                    .lineLimit(6)

                Spacer(minLength: 4)

                HStack(spacing: 6) {
                    Circle()
                        .fill(session.isReachable ? Color.green : Color.orange)
                        .frame(width: 6, height: 6)
                    Text(session.isReachable ? "Synced" : "Open iPhone app")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WatchSessionManager.shared)
}
