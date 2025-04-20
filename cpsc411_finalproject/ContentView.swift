//
//  ContentView.swift
//  cpsc411_finalproject
//
//  Created by csuftitan on 4/17/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(sampleArtworks) { art in
                            NavigationLink(destination: ArtDetailView(art: art, cartManager: cartManager)) {
                                VStack {
                                    Image(art.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(5)
                                        .frame(height: 120)
                                    Text(art.title)
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                        .padding(.top, 4)
                                }
                                .padding()
                            }
                        }
                    }
                }
                .navigationTitle("Free Art Gallery")
                .toolbarBackground(Color(.white), for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    NavigationLink(destination: CartView(cartManager: cartManager)) {
                        HStack {
                            Image(systemName: "cart")
                            Text("\(cartManager.cartItems.count)")
                                .font(.caption)
                        }
                    }
                }
            }
        }
    }
}

struct ArtDetailView: View {
    let art: Art
    @ObservedObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Image(art.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .padding()

            Text(art.title)
                .font(.title)
                .bold()

            Button(action: {
                cartManager.addToCart(art)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add to Cart")
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationTitle("Artwork")
        .toolbarBackground(Color(.white), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct CartView: View {
    @ObservedObject var cartManager: CartManager

    var body: some View {
        VStack {
            if cartManager.cartItems.isEmpty {
                Text("Your cart is empty.")
                    .font(.headline)
                    .padding()
            } else {
                List {
                    ForEach(cartManager.cartItems) { art in
                        HStack {
                            Image(art.imageName)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(8)

                            VStack(alignment: .leading) {
                                Text(art.title)
                                Button("Remove") {
                                    cartManager.removeFromCart(art)
                                }
                                .foregroundColor(.red)
                                .font(.caption)
                            }
                        }
                    }
                }

                Button(action: {
                    // Simulate download
                    for art in cartManager.cartItems {
                        print("Downloading \(art.title) from \(art.downloadURL)")
                    }
                    cartManager.clearCart()
                }) {
                    Text("Download All (\(cartManager.cartItems.count))")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding()
                }
            }
        }
        .navigationTitle("Your Cart")
        .toolbarBackground(Color(.white), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
    ContentView()
}
