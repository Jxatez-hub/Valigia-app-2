import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: PackingStore
    @State private var showAdd = false
    @State private var confirmReset = false

    private let columns = [GridItem(.adaptive(minimum: 104), spacing: 12)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ProgressHeader(selected: store.selectedCount, total: store.totalCount)

                    ForEach(store.categories, id: \.self) { category in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(category)
                                .font(.title3.weight(.semibold))
                                .padding(.horizontal, 4)
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(store.items(in: category)) { item in
                                    ItemCard(item: item)
                                }
                            }
                        }
                    }
                }
                .padding(16)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Valigia")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        showAdd = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    Menu {
                        Button(role: .destructive) {
                            confirmReset = true
                        } label: {
                            Label("Deseleziona tutto", systemImage: "arrow.counterclockwise")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddItemView()
            }
            .confirmationDialog("Deselezionare tutti gli oggetti?", isPresented: $confirmReset, titleVisibility: .visible) {
                Button("Deseleziona tutto", role: .destructive) {
                    withAnimation { store.clearSelection() }
                }
                Button("Annulla", role: .cancel) {}
            }
        }
    }
}

struct ProgressHeader: View {
    let selected: Int
    let total: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(selected) di \(total) pronti")
                .font(.headline)
            ProgressView(value: Double(selected), total: Double(max(total, 1)))
                .tint(.accentColor)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        )
    }
}

struct ItemCard: View {
    @EnvironmentObject var store: PackingStore
    let item: Item

    var body: some View {
        let selected = store.isSelected(item)

        VStack(spacing: 8) {
            VStack(spacing: 8) {
                Text(item.emoji)
                    .font(.system(size: 46))
                    .grayscale(selected ? 0 : 1)
                    .opacity(selected ? 1 : 0.35)
                    .shadow(color: .black.opacity(selected ? 0.25 : 0), radius: 6, x: 0, y: 5)
                    .scaleEffect(selected ? 1.08 : 1)

                Text(item.name)
                    .font(.footnote.weight(.medium))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundStyle(selected ? Color.primary : Color.secondary)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    store.toggle(item)
                }
            }

            if item.hasQuantity {
                QuantityControl(item: item)
                    .opacity(selected ? 1 : 0)
                    .allowsHitTesting(selected)
            } else {
                Color.clear.frame(height: 28)
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(.secondarySystemGroupedBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.accentColor.opacity(selected ? 0.6 : 0), lineWidth: 2)
        )
        .contextMenu {
            if store.isCustom(item) {
                Button(role: .destructive) {
                    store.remove(item)
                } label: {
                    Label("Elimina", systemImage: "trash")
                }
            }
        }
    }
}

struct QuantityControl: View {
    @EnvironmentObject var store: PackingStore
    let item: Item

    var body: some View {
        HStack(spacing: 10) {
            Button {
                store.setQuantity(item, store.quantity(item) - 1)
            } label: {
                Image(systemName: "minus.circle.fill")
            }
            .buttonStyle(.plain)

            Text("\(store.quantity(item))")
                .font(.subheadline.weight(.semibold))
                .monospacedDigit()
                .frame(minWidth: 22)

            Button {
                store.setQuantity(item, store.quantity(item) + 1)
            } label: {
                Image(systemName: "plus.circle.fill")
            }
            .buttonStyle(.plain)
        }
        .font(.title3)
        .foregroundStyle(Color.accentColor)
        .frame(height: 28)
    }
}

struct AddItemView: View {
    @EnvironmentObject var store: PackingStore
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var emoji = "📦"
    @State private var category = "Altro"
    @State private var hasQuantity = false

    private var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Nome", text: $name)
                TextField("Emoji", text: $emoji)
                Picker("Categoria", selection: $category) {
                    ForEach(Catalog.categories, id: \.self) { Text($0).tag($0) }
                }
                Toggle("Mostra quantità", isOn: $hasQuantity)
            }
            .navigationTitle("Nuovo oggetto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annulla") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Aggiungi") { save() }
                        .disabled(trimmedName.isEmpty)
                }
            }
        }
    }

    private func save() {
        let e = emoji.trimmingCharacters(in: .whitespaces)
        let item = Item(
            id: UUID().uuidString,
            name: trimmedName,
            emoji: e.isEmpty ? "📦" : String(e.prefix(1)),
            category: category,
            hasQuantity: hasQuantity,
            defaultQuantity: 1
        )
        store.add(item)
        dismiss()
    }
}
