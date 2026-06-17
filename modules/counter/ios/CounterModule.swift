import ExpoModulesCore
import WidgetKit

public class CounterModule: Module {
  private let appGroup = "group.com.rashidafzaal1718.widgetapp.counter"

  public func definition() -> ModuleDefinition {
    Name("Counter")

    Events("onCountChange")

    Function("getCount") {
      return self.readCount()
    }

    Function("setCount") { (value: Int) in
      self.writeCount(value)
      self.sendEvent("onCountChange", ["count": value])
      if #available(iOS 14.0, *) {
        WidgetCenter.shared.reloadAllTimelines()
      }
    }
  }

  private func fileURL() -> URL? {
    FileManager.default
      .containerURL(forSecurityApplicationGroupIdentifier: appGroup)?
      .appendingPathComponent("count.txt")
  }

  private func readCount() -> Int {
    guard let url = fileURL(),
          let text = try? String(contentsOf: url, encoding: .utf8) else {
      return 0
    }
    return Int(text.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
  }

  private func writeCount(_ value: Int) {
    guard let url = fileURL() else { return }
    try? "\(value)".write(to: url, atomically: true, encoding: .utf8)
  }
}