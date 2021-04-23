//
//  CartHandler.swift
//  CafeNIBM
//
//  Created by Imasha on 4/23/21.
//

import Foundation

class CartHandler {
    
    static var foodItems: [FoodItem] =  []
    
    static func getCartItems() -> [FoodItem] {
        return foodItems
    }
    
    static func clearCart() {
        self.foodItems.removeAll()
    }
}
