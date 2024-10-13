//
//  Stock.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import Foundation

// MARK: - FinnhubResponse

struct FinnhubResponse: Decodable {
    let c: Double  // Current price
    let h: Double  // High price of the day
    let l: Double  // Low price of the day
    let o: Double  // Open price of the day
    let pc: Double // Previous close price
    let t: Int     // Timestamp
}
import Foundation

// MARK: - Stock

struct Stock: Identifiable {
    var id: String { symbol }
    
    let symbol: String
    let currentPrice: Double
    let high: Double
    let low: Double
    let open: Double
    let previousClose: Double
    let timestamp: Int
}
