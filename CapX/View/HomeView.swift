//
//  HomeView.swift
//  CapX
//
//  Created by Praval Gautam on 14/10/24.
//

import SwiftUI

struct HomeView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var isSearchBarVisible = false
    @State private var searchText: String = ""
    @StateObject private var viewModel = StockViewModel()
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        LoadingView(isShowing: $viewModel.isLoading) {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    headerSection
                    searchBarSection
                    balanceSection
                    depositWithdrawButtons
                    portfolioSection
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            alertMessageView
        }
        .onReceive(viewModel.$errorMessage) { errorMessage in
            if let message = errorMessage {
                alertMessage = message
                showingAlert = true
                viewModel.isLoading = false
            }
        }
        .onReceive(viewModel.$stock) { stock in
            if stock != nil {
                withAnimation {
                    isSearchBarVisible = false
                }
            }
        }
    }
    
    // Header Section
    private var headerSection: some View {
        HStack {
            if !isSearchBarVisible {
                Button(action: {}) {
                    HStack {
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        Text("CapxLive")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
            }
            Spacer()
            searchButton
            NotificationIconView()
        }
        .padding(.horizontal)
    }
    
    // Search Button
    private var searchButton: some View {
        Button(action: {
            withAnimation {
                isSearchBarVisible.toggle()
            }
        }) {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
                .padding(.trailing, 8)
        }
    }
    
    // Search Bar Section
    private var searchBarSection: some View {
        Group {
            if isSearchBarVisible {
                SearchBar(searchText: $searchText, isVisible: $isSearchBarVisible) {
                    viewModel.fetchStock(symbol: searchText.uppercased())
                }
                .padding(.leading, 20)
            }
        }
    }
    
    // Balance Section
    private var balanceSection: some View {
        VStack(spacing: 5) {
            Text("$3,386.00") // Replace with dynamic data if available
                .foregroundColor(.white)
                .font(.system(size: 40, weight: .semibold))
            HStack(spacing: 5) {
                Image(systemName: "arrowtriangle.up.circle.fill")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.green)
                Text("$3,386.00") // Replace with dynamic data if available
                    .foregroundColor(.green)
                    .font(.system(size: 18, weight: .semibold))
                Text("Today")
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 3)
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.gray))
            }
        }
        .padding()
    }
    
    // Deposit and Withdraw Buttons
    private var depositWithdrawButtons: some View {
        HStack(spacing: 0) {
            HomeButton(title: "Deposit", action: {
                print("Deposit")
            }, backgroundColor: .blue, image: "plus.app.fill")
            
            HomeButton(title: "Withdraw", action: {
                print("Withdraw")
            }, backgroundColor: .gray, image: "arrow.up.square.fill")
        }
        .frame(width: UIScreen.main.bounds.width - 32)
        .padding()
    }
    
    // Portfolio Section
    private var portfolioSection: some View {
        ZStack {
            RoundedTopRectangle()
                .fill(Color.white)
                .edgesIgnoringSafeArea(.bottom)
            VStack {
                portfolioHeader
                portfolioScrollView
            }
        }
    }
    
    // Portfolio Header
    private var portfolioHeader: some View {
        HStack {
            Text("Portfolio")
                .font(.system(size: 25, weight: .semibold))
                .foregroundColor(.black)
            Spacer()
            Button(action: {
                print("View all")
            }) {
                Text("View all")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
    
    // Portfolio Scroll View
    private var portfolioScrollView: some View {
        ScrollView(.vertical) {
            if let stock = viewModel.stock {
                SearchedCard(
                    backgroundColor: LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.green.opacity(0.3)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    companyName: stock.symbol,
                    price: String(format: "$%.2f", stock.currentPrice),
                    changePercentage: String(format: "%.2f%%", ((stock.currentPrice - stock.previousClose) / stock.previousClose) * 100)
                )
                .padding(.top, 10)
            }

            // Display the grid of cards if not loading and no error
            if !viewModel.isLoading && viewModel.errorMessage == nil {
                LazyVGrid(columns: columns, spacing: 10) {
                    createGridCard(companyName: "Tata", price: "$3,386.00", changeAmount: "+$36.00", gradientColor: Color.green)
                    createGridCard(companyName: "Swiggy", price: "$2,456.00", changeAmount: "-$12.00", gradientColor: Color.blue)
                    createGridCard(companyName: "Zomato", price: "$1,234.00", changeAmount: "+$15.00", gradientColor: Color.gray)
                    createGridCard(companyName: "Nvidia", price: "$4,567.00", changeAmount: "-$45.00", gradientColor: Color.orange)
                }
                .padding()
            }
        }
    }
    
    private func createGridCard(companyName: String, price: String, changeAmount: String, gradientColor: Color) -> some View {
        GridCard(
            backgroundColor: LinearGradient(
                gradient: Gradient(colors: [Color.white, gradientColor.opacity(0.3)]),
                startPoint: .leading,
                endPoint: .trailing
            ),
            profileImageName: "profile",
            companyName: companyName,
            price: price,
            changeAmount: changeAmount
        )
    }
    
    private var alertMessageView: Alert {
        if !networkMonitor.isConnected {
            return Alert(
                title: Text("No Internet Connection"),
                message: Text("Please check your connection and try again."),
                dismissButton: .default(Text("OK")) {
                    viewModel.isLoading = false
                }
            )
        } else {
            return Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    viewModel.isLoading = false
                    viewModel.errorMessage = nil
                }
            )
        }
    }
}

#Preview {
    HomeView()
}















