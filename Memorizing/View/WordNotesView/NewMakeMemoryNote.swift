//
//  NewMakeMemoryNote.swift
//  Memorizing
//
//  Created by 염성필 on 2023/01/05.
//

import SwiftUI

var mainCategoryMemory: [String] = ["영어", "한국사", "IT", "경제", "시사", "기타"]

var mainCategoryColor: [Color] = [Color("EnglishColor"), Color("HistoryColor"), Color("ITColor"),  Color("EconomyColor"), Color("KnowledgeColor"), Color("EtcColor")]

struct NewMakeMemoryNote: View {

    //MARK: - 재혁 추가 (취소, 등록 시 창을 나가는 dismiss())
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var userStore : UserStore

    @Binding var isShowingNewMemorySheet: Bool
    @State private var title: String = ""
    // 카테고리를 눌렀을때 담기는 변수
    @State private var categoryTitle: String = ""
    @State private var categoryColorIndex: Int = 0
    
    // 버튼 눌렀을 때, ㅅ
    var body: some View {
        VStack(spacing: 50) {
            // 새로운 암기장 만들기
            makeNewNote
            // 암기장 이름
            noteTitle
            // 카테고리
            category
            Spacer()
                .frame(height: 100)
            // 버튼
            makeNoteButton
            Spacer()
        }
        .padding()
    }
    
    // 최상단 (새로운 암기장 만들기 ~ X 표시)
    var makeNewNote: some View {
        HStack(spacing: 30) {
            VStack {
                // 아무 버튼도 아님
                Button {
                    //
                } label: {
                    Text("")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(.mainBlack)
                }
            }
            .frame(width: 50)
            
            VStack {
                Text("새로운 암기장 만들기")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .frame(width: 200)
            
            VStack {
                Button {
                    print("취소버튼이 눌렸습니다.")
                    isShowingNewMemorySheet.toggle()
                    dismiss()
                } label: {
                    Text("취소")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(.mainBlack)
                }
            }
            .frame(width: 50)
        }
    }
    
    // 중간 (암기장 이름 및 텍스트 필드)
    var noteTitle: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("암기장 이름")
                .font(.title3)
                .fontWeight(.bold)
            TextField("암기장 제목을 입력해주세요", text: $title)
                .padding(10)
                .accentColor(.mainBlue)
                .lineLimit(3...5)
                .background(Color.gray6)
                .cornerRadius(20, corners: .allCorners)
                .fontWeight(.semibold)
                .font(.subheadline)
        }
    }
    
    // 중 하단 ( 카테고리 )
    var category: some View {
        
        
        VStack(alignment: .leading, spacing: 20) {
            Text("카테고리")
                .font(.title3)
                .fontWeight(.bold)
                .offset(x : -10)
                HStack {
                    
                    ForEach(Array(zip(mainCategoryMemory.indices, mainCategoryMemory)), id: \.0) { (index, category) in
                        Button(action: {
                            categoryTitle = category
//                            print("카테고리 버튼이 눌렸습니다. : \(mainCategoryMemory[category])")
//                            categoryColorIndex = category
                        }) {
                            
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(categoryTitle == category ? mainCategoryColor[index] : Color.gray4)
                                .frame(width: 50, height: 30)
                                .overlay {
                                    Text("\(category)")
                                        .font(.footnote)
                                        .foregroundColor(categoryTitle == category ? mainCategoryColor[index] : Color.gray4)
                                }
                        }
                    }
                }
        }
    }
    
    // 하단 ( 버튼 )
    var makeNoteButton: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(title.count > 0 && categoryTitle.count > 0 ? .blue : .gray)
            .frame(width: 350, height: 40)
            .overlay {
                Button {
                    userStore.addMyWordNotes(wordNote: WordNote(id: UUID().uuidString, noteName: title, noteCategory: categoryTitle, enrollmentUser: userStore.user?.id ?? "", repeatCount: 0, notePrice: 0))
                    isShowingNewMemorySheet = false
                    print("새로운 암기장 만들기")
                } label: {
                    Text("새로운 암기장 만들기")
                        .foregroundColor(.white)
                }
            }
            .disabled(title.count > 0 && categoryTitle.count > 0 ? false : true)
    }
}

struct NewMakeMemoryNote_Previews: PreviewProvider {
    static var previews: some View {
        NewMakeMemoryNote(isShowingNewMemorySheet: .constant(true))
    }
}
