
import SwiftUI
import AVFoundation

struct Product: Identifiable {
    let id = UUID()
    var code: String
    var unitPrice: Double
    var quantity: Int

    var total: Double {
        unitPrice * Double(quantity)
    }
}

struct ContentView: View {
    @State private var productCode = ""
    @State private var unitPrice = ""
    @State private var quantity = ""
    @State private var products: [Product] = []

    var fullTotal: Double {
        products.reduce(0) { $0 + $1.total }
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add Product")) {

                        TextField("Product Code", text: $productCode)

                        TextField("Unit Price", text: $unitPrice)
                            .keyboardType(.decimalPad)

                        TextField("Quantity", text: $quantity)
                            .keyboardType(.numberPad)

                        Button("Add Product") {
                            let price = Double(unitPrice) ?? 0
                            let qty = Int(quantity) ?? 0

                            let newProduct = Product(
                                code: productCode,
                                unitPrice: price,
                                quantity: qty
                            )

                            products.append(newProduct)

                            productCode = ""
                            unitPrice = ""
                            quantity = ""
                        }
                    }

                    Section(header: Text("Products")) {
                        ForEach(products) { product in
                            VStack(alignment: .leading) {
                                Text("Code: \(product.code)")
                                Text("Unit Price: \(product.unitPrice)")
                                Text("Quantity: \(product.quantity)")
                                Text("Total: \(product.total)")
                            }
                        }
                    }

                    Section(header: Text("Full Total")) {
                        Text("Rs. \(fullTotal)")
                            .font(.title2)
                    }
                }
            }
            .navigationTitle("Simple Stock App")
        }
    }
}

@main
struct SimpleStockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
