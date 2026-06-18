import WidgetKit
import SwiftUI

struct CounterEntry: TimelineEntry {
    let date: Date
    let count: Int
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CounterEntry {
        CounterEntry(date: Date(), count: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (CounterEntry) -> Void) {
        completion(CounterEntry(date: Date(), count: readCount()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CounterEntry>) -> Void) {
        let entry = CounterEntry(date: Date(), count: readCount())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }

    private func readCount() -> Int {
        let appGroup = "group.com.rashidafzaal1718.widgetapp.counter"
        guard let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroup
        ) else { return 0 }

        let fileURL = containerURL.appendingPathComponent("count.txt")
        guard let text = try? String(contentsOf: fileURL, encoding: .utf8) else { return 0 }
        return Int(text.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
    }
}

struct widgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Counter")
                .font(.caption)
                .foregroundColor(.gray)
            Text("\(entry.count)")
                .font(.system(size: 40, weight: .bold))
        }
    }
}

struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Counter")
        .description("Shows the current counter value.")
        .supportedFamilies([.systemSmall, .systemMedium, .accessoryCircular, .accessoryRectangular])
    }
}

#Preview(as: .systemSmall) {
    widget()
} timeline: {
    CounterEntry(date: .now, count: 0)
    CounterEntry(date: .now, count: 5)
}