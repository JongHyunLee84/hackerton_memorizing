//
//  MarketViewCategoryButton.swift
//  Memorizing
//
//  Created by 윤현기 on 2023/01/05.
//

import SwiftUI

struct MarketViewCategoryButton: View {
    
    @Binding var selectedCategory: String
    let categoryArray: [String]
    
    var body: some View {
        HStack {
            ForEach(Array(zip(categoryArray.indices, categoryArray)), id: \.0) { (index, category) in
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(selectedCategory == category ? MarketView.colorArray[index] : Color.gray4)
                    // FIXME: 왜 타입추론 에러가...?
//                    .backgroundStyle(selectedCategory == category ? MarketView.colorArray[index] : Color.white)
                    .frame(width: 44, height: 25)
                    .overlay {
                        Button(action: {
                            selectedCategory = category
                            
                        }) {
                            Text("\(category)")
                                .font(.caption2)
                                .foregroundColor(selectedCategory == category ? MarketView.colorArray[index] : .gray2)
                        }
                    }
            }
        }
        .padding(.bottom, 10)
    }
}


