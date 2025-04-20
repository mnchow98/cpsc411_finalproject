//
//  Product_Model.swift
//  cpsc411_finalproject
//
//  Created by csuftitan on 4/17/25.
//

import Foundation

struct Art: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let downloadURL: String
}

import Foundation

let sampleArtworks: [Art] = [
    Art(title: "Mower Lease Ah", imageName: "Mower_Lease_Ah", downloadURL: "Mower_Lease_Ah.png"),
    Art(title: "The Yell", imageName: "The_Yell", downloadURL: "The_Yell.png"),
    Art(title: "Big Water", imageName: "Big_Water", downloadURL: "Big_Water.png")
]

class CartManager: ObservableObject {
    @Published var cartItems: [Art] = []

    func addToCart(_ art: Art) {
        if !cartItems.contains(where: { $0.id == art.id }) {
            cartItems.append(art)
        }
    }

    func removeFromCart(_ art: Art) {
        cartItems.removeAll { $0.id == art.id }
    }

    func clearCart() {
        cartItems.removeAll()
    }
}


