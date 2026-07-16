import SwiftUI
import WidgetKit

private let appGroupId = "group.com.intellig.deskwellness.affirmly"
private let widgetKind = "AffirmlyWidget"

struct AffirfestingEntry: TimelineEntry {
    let date: Date
    let affirmation: String
    let backgroundHex: String
    let textHex: String
    let accentHex: String
    let showBrand: Bool
}

struct AffirfestingProvider: TimelineProvider {
    func placeholder(in context: Context) -> AffirfestingEntry {
        AffirfestingEntry(
            date: Date(),
            affirmation: "I am becoming more confident every day.",
            backgroundHex: "#D4E2D0",
            textHex: "#17372A",
            accentHex: "#2F7D64",
            showBrand: true
        )
    }

    func getSnapshot(
        in context: Context,
        completion: @escaping (AffirfestingEntry) -> Void
    ) {
        completion(loadEntry())
    }

    func getTimeline(
        in context: Context,
        completion: @escaping (Timeline<AffirfestingEntry>) -> Void
    ) {
        completion(Timeline(entries: [loadEntry()], policy: .never))
    }

    private func loadEntry() -> AffirfestingEntry {
        let data = UserDefaults(suiteName: appGroupId)
        return AffirfestingEntry(
            date: Date(),
            affirmation: data?.string(forKey: "affirmation_text") ?? "I am enough.",
            backgroundHex: data?.string(forKey: "background_hex") ?? "#17372A",
            textHex: data?.string(forKey: "text_color_hex") ?? "#F7F3E8",
            accentHex: data?.string(forKey: "accent_hex") ?? "#F2C96D",
            showBrand: data?.object(forKey: "show_brand") as? Bool ?? true
        )
    }
}

struct AffirfestingWidgetView: View {
    @Environment(\.widgetFamily) private var family
    let entry: AffirfestingEntry

    @ViewBuilder
    var body: some View {
        if #available(iOSApplicationExtension 17.0, *) {
            content
                .containerBackground(Color(hex: entry.backgroundHex), for: .widget)
        } else {
            content
                .background(Color(hex: entry.backgroundHex))
        }
    }

    private var content: some View {
        VStack(spacing: family == .systemSmall ? 10 : 14) {
            if entry.showBrand {
                HStack(spacing: 6) {
                    Text("✦")
                        .foregroundStyle(Color(hex: entry.accentHex))
                    Text("AFFIRFESTING")
                        .font(.system(size: 10, weight: .bold, design: .rounded))
                        .tracking(1.2)
                        .foregroundStyle(Color(hex: entry.textHex).opacity(0.72))
                }
            }

            Text(entry.affirmation)
                .font(.system(
                    size: family == .systemSmall ? 17 : 21,
                    weight: .semibold,
                    design: .serif
                ))
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.7)
                .foregroundStyle(Color(hex: entry.textHex))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(family == .systemSmall ? 14 : 20)
    }
}

@main
struct AffirfestingWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: widgetKind, provider: AffirfestingProvider()) { entry in
            AffirfestingWidgetView(entry: entry)
        }
        .configurationDisplayName("Affirfesting")
        .description("Keep your chosen affirmation on your Home Screen.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

private extension Color {
    init(hex: String) {
        let cleaned = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&value)

        let red: UInt64
        let green: UInt64
        let blue: UInt64
        switch cleaned.count {
        case 3:
            red = (value >> 8) * 17
            green = ((value >> 4) & 0xF) * 17
            blue = (value & 0xF) * 17
        default:
            red = value >> 16
            green = (value >> 8) & 0xFF
            blue = value & 0xFF
        }

        self.init(
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255
        )
    }
}
