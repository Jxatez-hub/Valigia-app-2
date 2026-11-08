import SwiftUI

final class PackingStore: ObservableObject {
    @Published var customItems: [Item] = []
    @Published var states: [String: ItemState] = [:]

    private let key = "valigia.save.v1"

    private struct Saved: Codable {
        var custom: [Item]
        var states: [String: ItemState]
    }

    init() { load() }

    var categories: [String] { Catalog.categories }

    var totalCount: Int { Catalog.items.count + customItems.count }
    var selectedCount: Int { states.values.filter { $0.selected }.count }

    func items(in category: String) -> [Item] {
        (Catalog.items + customItems).filter { $0.category == category }
    }

    func isCustom(_ item: Item) -> Bool {
        customItems.contains { $0.id == item.id }
    }

    func isSelected(_ item: Item) -> Bool {
        states[item.id]?.selected ?? false
    }

    func quantity(_ item: Item) -> Int {
        states[item.id]?.quantity ?? item.defaultQuantity
    }

    func toggle(_ item: Item) {
        var s = states[item.id] ?? ItemState(selected: false, quantity: item.defaultQuantity)
        s.selected.toggle()
        states[item.id] = s
        save()
    }

    func setQuantity(_ item: Item, _ value: Int) {
        var s = states[item.id] ?? ItemState(selected: false, quantity: item.defaultQuantity)
        s.quantity = min(max(value, 1), 99)
        states[item.id] = s
        save()
    }

    func add(_ item: Item) {
        customItems.append(item)
        save()
    }

    func remove(_ item: Item) {
        customItems.removeAll { $0.id == item.id }
        states[item.id] = nil
        save()
    }

    func clearSelection() {
        states = states.mapValues { old in
            var s = old
            s.selected = false
            return s
        }
        save()
    }

    private func save() {
        let data = Saved(custom: customItems, states: states)
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let saved = try? JSONDecoder().decode(Saved.self, from: data) else { return }
        customItems = saved.custom
        states = saved.states
    }
}
