//
//  CellView.swift
//  searchForBusinesses
//
//  Created by anupam mishra on 02/07/22.
//

import SwiftUI

struct CellView: View {
    
    @Binding var businessesModel: BusinessesModel
    
    var body: some View {
        HStack {
            ZStack {   //load avatar
                AsyncImage(url: URL(string: businessesModel.image_url ?? ""), scale: 1) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                } placeholder: { ProgressView().progressViewStyle(.circular) }
            }
            Spacer()
            Divider()
            VStack(alignment: .leading) {
                Text("Name: \(businessesModel.name)")
                    .font(.title2)
                    .bold()
                Text("Business link: \(businessesModel.url)")
                    .foregroundColor(.blue)
                    .underline()
                
            }
        }.padding()
            .frame(height: 80)
            .onTapGesture {
                //Open web page
                Utilities.openWebPage(from: businessesModel.url)
            }
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView(businessesModel: .constant(BusinessesModel(id: "",
                                                            alias: "",
                                                            name: "",
                                                            image_url: "",
                                                            url: "")))
    }
}
