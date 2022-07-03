//
//  SearchView.swift
//  searchForBusinesses
//
//  Created by anupam mishra on 26/06/22.
//

import SwiftUI

struct SearchView: View {
    //To get current location
    @StateObject var locationManager = LocationManager()
    var latitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    var longitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    //Search query
    @Binding var businessName: String
    @State  var searchQuery: String = ""
    @StateObject var api = YelpAPICall()
    
    var body: some View {
            VStack {
                Spacer().frame(height: 20)
                //Search box
                Text("Searching for businesses: \(searchQuery)")
                    .searchable(text: $searchQuery)
                    .onChange(of: searchQuery) { value in
                        Task {
                            await api.fetchBusinesse(term: searchQuery,
                                                     latitude: latitude,
                                                     longitude: longitude)
                        }
                    }
                    .navigationTitle("Businesses search")
                Spacer().frame(height: 10)
                ScrollView {
                    switch api.state {
                    case .idle: EmptyView()
                    case .loading: ProgressView()
                    case .loaded(let businessesResponse):
                        VStack {
                            ForEach (businessesResponse.businesses, id: \.id) {businesse in
                                VStack {
                                    CellView(businessesModel: .constant(businesse))
                                }.padding(.top, 10)
                                    .padding(.bottom, 10)
                                Divider()
                            }
                        }
                    case .failed(let error):
                        if error is DecodingError {
                            Text("")
                        } else {
                            Text("")
                        }
                    }
                }
            }.padding()
                .onAppear(perform: {
                    searchQuery = businessName
                })
                .task {
                    await api.fetchBusinesse(term: searchQuery,
                                             latitude: latitude,
                                             longitude: longitude)
                }
        }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(businessName: .constant("food"))
    }
}
