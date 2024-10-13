//
//  StockViewModel.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import Foundation
import Combine

// MARK: - StockViewModel

class StockViewModel: ObservableObject {
    // Published properties to update the UI
    @Published var stock: Stock?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // Set to hold Combine subscriptions
    private var cancellables: Set<AnyCancellable> = []
    
    // Securely manage your API key
    private let apiKey: String = "cs62hvpr01qv8tfqeg40cs62hvpr01qv8tfqeg4g" // Replace with your actual Finnhub API key
    // Consider moving this to a secure location (e.g., environment variables, Keychain)
    
    /// Fetches stock data for the given symbol using Finnhub API.
    /// - Parameter symbol: The stock symbol to fetch data for.
    func fetchStock(symbol: String) {
        // Trim whitespace and validate the symbol
        let trimmedSymbol = symbol.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedSymbol.isEmpty else {
            DispatchQueue.main.async {
                self.errorMessage = "Please enter a stock symbol."
            }
            return
        }
        
        // Construct the URL with proper encoding
        guard let url = URL(string: "https://finnhub.io/api/v1/quote?symbol=\(trimmedSymbol)&token=\(apiKey)") else {
            DispatchQueue.main.async {
                self.errorMessage = "Invalid URL."
            }
            return
        }
        
        // Reset UI states before fetching
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
            self.stock = nil
        }
        
        // Use Combine's dataTaskPublisher for the network call
        URLSession.shared.dataTaskPublisher(for: url)
            // Ensure the response is valid
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                // Check for successful status codes
                guard 200..<300 ~= httpResponse.statusCode else {
                    // Handle specific status codes if necessary
                    switch httpResponse.statusCode {
                    case 400:
                        throw URLError(.badURL)
                    case 401:
                        throw URLError(.userAuthenticationRequired)
                    case 403:
                        throw URLError(.userAuthenticationRequired)
                    case 404:
                        throw URLError(.fileDoesNotExist)
                    default:
                        throw URLError(.unknown)
                    }
                }
                return result.data
            }
            // Decode the JSON into FinnhubResponse
            .decode(type: FinnhubResponse.self, decoder: JSONDecoder())
            // Receive on the main thread to update UI
            .receive(on: DispatchQueue.main)
            // Handle the results
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Provide more descriptive error messages
                    if let urlError = error as? URLError {
                        switch urlError.code {
                        case .badURL:
                            self.errorMessage = "The stock symbol entered is invalid."
                        case .userAuthenticationRequired:
                            self.errorMessage = "Authentication failed. Please check your API key."
                        case .fileDoesNotExist:
                            self.errorMessage = "Stock not found. Please check the symbol and try again."
                        default:
                            self.errorMessage = "Network error: \(urlError.localizedDescription)"
                        }
                    } else if let decodingError = error as? DecodingError {
                        self.errorMessage = "Data decoding error: \(decodingError.localizedDescription)"
                    } else {
                        self.errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
                    }
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                // Check if the response contains valid data
                if response.c == 0 && response.h == 0 && response.l == 0 && response.o == 0 && response.pc == 0 {
                    self.errorMessage = "Stock not found. Please check the symbol and try again."
                } else {
                    self.stock = Stock(
                        symbol: trimmedSymbol.uppercased(),
                        currentPrice: response.c,
                        high: response.h,
                        low: response.l,
                        open: response.o,
                        previousClose: response.pc,
                        timestamp: response.t
                    )
                }
            }
            // Store the subscription to manage its lifecycle
            .store(in: &cancellables)
    }
}


