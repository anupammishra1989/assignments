//
//  HomeView.swift
//  searchForBusinesses
//
//  Created by anupam mishra on 26/06/22.
//

import SwiftUI

struct HomeView: View {
    
    //To get current location
    @StateObject var locationManager = LocationManager()
    var latitude: String {
        return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
    }
    var longitude: String {
        return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
    }
    
    //API call
    @StateObject var api = YelpAPICall()
    
    //Constants
    let restaurants: String = "restaurants"
    let nearByRestaurants: String = "Near By Restaurants"
    let searchBy: String = "Search by"
    let viewAll: String = "View all"
    var index = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 20)
                VStack {
                    sectionView(text: searchBy)
                    HStack {
                        Spacer()
                        NavigationLink(destination: SearchView(businessName: .constant(BusinessType.food.rawValue))) {
                            cardView1(text: BusinessType.food.rawValue)
                        }
                        Spacer()
                        NavigationLink(destination: SearchView(businessName: .constant(BusinessType.restaurant.rawValue))) {
                            cardView1(text: BusinessType.restaurant.rawValue)
                        }
                        Spacer()
                    }.padding()
                }
                VStack {
                    sectionView(text: nearByRestaurants)
                    switch api.state {
                    case .idle: EmptyView()
                    case .loading: ProgressView()
                    case .loaded(let businessesResponse):
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach (businessesResponse.businesses.indices) { index in
                                    if businessesResponse.businesses.count > index && index < 2 {
                                        //Display restaurants
                                        let business = businessesResponse.businesses[index]
                                        cardView2(text: business.name,
                                                  imageUrl: business.image_url ?? "",
                                                  link: business.url)
                                    } else {
                                        //show view all button
                                        if index == 2 {
                                            NavigationLink(destination: SearchView(businessName: .constant(BusinessType.restaurant.rawValue))) {
                                                cardView1(text: viewAll)
                                            }
                                        }
                                    }
                                }
                            }.padding()
                        }
                    case .failed(let error):
                        if error is DecodingError {
                            Text("")
                        } else {
                            Text("")
                        }
                    }
                }.onAppear {
                    Task {
                        await api.fetchBusinesse(term: restaurants,
                                                 latitude: latitude,
                                                 longitude: longitude)
                    }
                }
                Spacer()
            }
        }
    }
    
    ///This is use for label card view
    func cardView1(text: String,
                   height: Double = 120.0,
                   width: Double = 120.0) -> some View {
        VStack {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: width,
                       height: height)
        }.background(.blue)
            .cornerRadius(10)
    }
    
    ///This is use for image and label card view
    func cardView2(text: String,
                   imageUrl: String,
                   link: String,
                   height: Double = 120.0,
                   width: Double = 120.0) -> some View {
        
        VStack {
            ZStack(alignment: .bottom) {   //load avatar
                AsyncImage(url: URL(string: imageUrl), scale: 1) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: height, height: width)
                } placeholder: { ProgressView().progressViewStyle(.circular) }
                VStack {
                    Text(text)
                        .foregroundColor(.white)
                }.background(.blue)
                    .cornerRadius(10)
            }.padding(.bottom, 5)
                .onTapGesture {
                    //Open web page
                    Utilities.openWebPage(from: link)
                }
        }.background(.blue)
            .cornerRadius(10)
    }
    
    ///This is use for section view
    func sectionView(text: String) -> some View {
        VStack(alignment: .leading)  {
            Divider()
            Text(text)
                .font(.headline)
                .padding(.leading, 16)
                .padding(.top, 10)
                .padding(.bottom, 10)
            Divider()
        }.background(Color(.systemGray6))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
