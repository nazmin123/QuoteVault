import SwiftUI
import Foundation

struct HomeView: View {

    @StateObject private var viewModel = HomeViewModel()
    @StateObject private var favouritesVM = FavoritesViewModel()

    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                
                    QuoteOfDayCard(
                        quote: viewModel.quoteOfTheDay
                    )

                ForEach(viewModel.quotes) { quote in
                    QuoteCardView(
                        quote: quote,
                        isFavourite: favouritesVM.isFavorite(quote),
                        onFavorite: {
                            Task {
                                await favouritesVM.toggleFavorite(quote)
                            }
                        },
                        onShare: {
                        }
                    )
                    .onAppear {
                                          Task {
                                              await viewModel.loadMoreIfNeeded(currentQuote: quote)
                                          }
                                      }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }

                if !viewModel.isLoading && viewModel.quotes.isEmpty {
                    EmptyStateView(
                        title: "No Quotes",
                        message: "Please try again later."
                    )
                }
            }
            .padding(.vertical)
        }
        .task {
           // await viewModel.loadQuoteOfTheDay()
            await viewModel.loadInitialQuotes()
            await favouritesVM.loadFavorites()
        }
        .refreshable {
            await viewModel.refresh()
            await favouritesVM.loadFavorites()
        }
    }
}


