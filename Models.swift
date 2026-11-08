import Foundation

struct Item: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var emoji: String
    var category: String
    var hasQuantity: Bool = false
    var defaultQuantity: Int = 1
}

struct ItemState: Codable, Hashable {
    var selected: Bool = false
    var quantity: Int = 1
}

enum Catalog {
    static let categories = [
        "Abbigliamento",
        "Elettronica",
        "Igiene e salute",
        "Documenti",
        "Altro"
    ]

    static let items: [Item] = [
        // Abbigliamento
        Item(id: "magliette", name: "Magliette", emoji: "👕", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 3),
        Item(id: "pantaloni", name: "Pantaloni", emoji: "👖", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 2),
        Item(id: "pantaloncini", name: "Pantaloncini", emoji: "🩳", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 2),
        Item(id: "intimo", name: "Intimo", emoji: "🩲", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 3),
        Item(id: "calzini", name: "Calzini", emoji: "🧦", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 3),
        Item(id: "felpa", name: "Felpa / Giacca", emoji: "🧥", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 1),
        Item(id: "vestiti", name: "Vestiti", emoji: "👗", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 1),
        Item(id: "pigiama", name: "Pigiama", emoji: "🛌", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 1),
        Item(id: "costume", name: "Costume", emoji: "🩱", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 1),
        Item(id: "scarpe", name: "Scarpe", emoji: "👟", category: "Abbigliamento", hasQuantity: true, defaultQuantity: 1),
        Item(id: "ciabatte", name: "Ciabatte", emoji: "🩴", category: "Abbigliamento"),
        Item(id: "cappello", name: "Cappello", emoji: "🧢", category: "Abbigliamento"),

        // Elettronica
        Item(id: "caricatore", name: "Caricatore", emoji: "🔌", category: "Elettronica"),
        Item(id: "cavi", name: "Cavi", emoji: "🪢", category: "Elettronica", hasQuantity: true, defaultQuantity: 2),
        Item(id: "powerbank", name: "Powerbank", emoji: "🔋", category: "Elettronica"),
        Item(id: "telefono", name: "Telefono", emoji: "📱", category: "Elettronica"),
        Item(id: "laptop", name: "Computer", emoji: "💻", category: "Elettronica"),
        Item(id: "cuffie", name: "Cuffie", emoji: "🎧", category: "Elettronica"),
        Item(id: "smartwatch", name: "Smartwatch", emoji: "⌚", category: "Elettronica"),
        Item(id: "fotocamera", name: "Fotocamera", emoji: "📷", category: "Elettronica"),
        Item(id: "adattatore", name: "Adattatore", emoji: "🌍", category: "Elettronica"),

        // Igiene e salute
        Item(id: "medicine", name: "Medicine", emoji: "💊", category: "Igiene e salute"),
        Item(id: "cerotti", name: "Cerotti", emoji: "🩹", category: "Igiene e salute"),
        Item(id: "spazzolino", name: "Spazzolino", emoji: "🪥", category: "Igiene e salute"),
        Item(id: "shampoo", name: "Shampoo", emoji: "🧴", category: "Igiene e salute"),
        Item(id: "sapone", name: "Sapone", emoji: "🧼", category: "Igiene e salute"),
        Item(id: "rasoio", name: "Rasoio", emoji: "🪒", category: "Igiene e salute"),
        Item(id: "crema-solare", name: "Crema solare", emoji: "☀️", category: "Igiene e salute"),

        // Documenti
        Item(id: "passaporto", name: "Passaporto", emoji: "🛂", category: "Documenti"),
        Item(id: "identita", name: "Carta d'identità", emoji: "🆔", category: "Documenti"),
        Item(id: "biglietti", name: "Biglietti", emoji: "🎫", category: "Documenti"),
        Item(id: "portafoglio", name: "Portafoglio", emoji: "💳", category: "Documenti"),
        Item(id: "contanti", name: "Contanti", emoji: "💶", category: "Documenti"),
        Item(id: "chiavi", name: "Chiavi di casa", emoji: "🔑", category: "Documenti"),

        // Altro
        Item(id: "zaino", name: "Zaino", emoji: "🎒", category: "Altro"),
        Item(id: "occhiali", name: "Occhiali da sole", emoji: "🕶️", category: "Altro"),
        Item(id: "ombrello", name: "Ombrello", emoji: "☂️", category: "Altro"),
        Item(id: "libro", name: "Libro", emoji: "📚", category: "Altro"),
        Item(id: "borraccia", name: "Borraccia", emoji: "🥤", category: "Altro"),
        Item(id: "snack", name: "Snack", emoji: "🍫", category: "Altro"),
        Item(id: "lucchetto", name: "Lucchetto", emoji: "🔒", category: "Altro")
    ]
}
