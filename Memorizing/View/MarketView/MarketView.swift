//
//  MarketView.swift
//  Memorizing
//
//  Created by 진준호 on 2023/01/05.
//

import SwiftUI

// MARK: - 마켓 탭에서 가장 메인으로 보여주는 View
struct MarketView: View {
    @EnvironmentObject var marketStore: MarketStore
    
    /// 검색창 입력 텍스트
    @State private var searchText: String = ""
    @State private var isSheetOpen: Bool = false
    
    /// 카테고리 목록
    static let categoryArray: [String] = ["전체", "영어", "한국사", "IT", "경제", "시사", "기타"]
    static let colorArray: [Color] = [.mainDarkBlue, .mainBlue, .HistoryColor, .ITColor, .EconomyColor, .KnowledgeColor, .EtcColor]
    
    @State private var selectedCategory: String  = "전체"
    
    var body: some View {
        
        // MARK: -  검색창
        MarketViewSearchBar(searchText: $searchText)
            .padding(.top,15)
        
        // MARK: -  검색창 하단 구분선
        Divider()
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
        
        // MARK: - 카테고리 버튼들
        MarketViewCategoryButton(selectedCategory: $selectedCategory, categoryArray: MarketView.categoryArray)
        
        ZStack {
            ScrollView {
                // MARK: - Grid View
                
                let columns = [
                    GridItem(.flexible(), spacing: 0, alignment: nil),
                    GridItem(.flexible(), spacing: 0, alignment: nil)
                ]
                
                LazyVGrid(
                    columns: columns,
                    spacing: 18,
                    content:  {
                        ForEach(marketStore.marketWordNotes) { wordNote in
                            if searchText == "" || wordNote.noteName.contains(searchText) {
                                MarketViewNoteButton(isSheetOpen: $isSheetOpen, selectedCategory: $selectedCategory, selectedWordNote: wordNote)
                            }
                        }
                    })
                .padding(.horizontal)
                // MARK: -
                
            }   // ScrollView end
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("Logo")
                        .resizable()
                        .frame(width: 35, height: 22)
                        .padding(.leading,10)
                }
                ToolbarItem(placement: .principal) {
                    Text("암기장 마켓")
                        .font(.title3.bold())
                        .accessibilityAddTraits(.isHeader)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                   
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.mainBlue)
                        .frame(width: 60, height: 30)
                        .overlay {
                            Text("200P")
                                .foregroundColor(.mainBlue)
                                .font(.subheadline)
                        }
                }
            }
            .sheet(isPresented: $isSheetOpen) {
                // TODO: 단어장 클릭시 단어 목록 리스트 보여주기
                MarketViewSheet(wordNote: marketStore.sendWordNote)
            }
            
            NavigationLink(destination: MarketViewAddButton()) {
                Circle()
                    .foregroundColor(.mainBlue)
                    .frame(width: 65, height: 65)
                    .overlay {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title3)
                            .bold()
                    }
                    .shadow(radius: 1, x: 1, y: 1)
            }
            .offset(x: 140, y: 184)
        }
//        .onAppear {
//            marketStore.fetchMarketWordNotes()
//        }
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MarketView()
                .environmentObject(MarketStore())
        }
    }
}
