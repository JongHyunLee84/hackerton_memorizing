//
//  StudyAgainView.swift
//  Memorizing
//
//  Created by 염성필 on 2023/01/06.
//

import SwiftUI

struct StudyAgainView: View {
    @EnvironmentObject var userStore : UserStore
    var myWordNote : WordNote
    @State var list : [Word] = []
    
    // 한 번도 안 하면 -1, 한 번씩 할 때마다 1씩 증가
    
    @State var progressStep: Int = 0
    
    var body: some View {
        VStack {
            
            VStack(spacing: 25) {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray4)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 140)
                    .overlay {
                        HStack {
                            Rectangle()
                                .cornerRadius(10, corners: [.topLeft,.bottomLeft])
                                .frame(width: 16)
                                .foregroundColor(myWordNote.noteColor)
                            
                            VStack(spacing: 5) {
                                HStack(alignment: .top) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(myWordNote.noteColor, lineWidth: 1)
                                        .frame(width: 50, height: 25)
                                        .overlay {
                                            Text(myWordNote.noteCategory)
                                                .font(.caption)
                                        }
                                    Spacer()
                                }
                                .padding(.horizontal, 15)
                                
                                HStack {
                                    Text(myWordNote.noteName)
                                        .foregroundColor(.black)
                                        .font(.headline)
                                    Spacer()
                                }
                                .padding(.horizontal, 15)
                                .padding(.bottom, 15)
                                
                                // MARK: 얼굴 진행도
                                FaceProgressView(myWordNote: myWordNote)
                            }
                            .padding(.trailing, 15)
                        }
                        
                    }
                    .overlay {
                        HStack {
                            Spacer()
                            
                            VStack {
                                // 학습시작
                                if myWordNote.repeatCount == 0 {
                                    NavigationLink {
                                        // 첫번째 단어 뷰
                                        FirstTryCardView(myWordNote: myWordNote, word: list)
                                    } label: {
                                        RoundedRectangle(cornerRadius: 3)
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(myWordNote.noteColor)
                                            .overlay {
                                                VStack {
                                                    Image(systemName: "play.circle")
                                                        .font(.headline)
                                                    Text("학습시작")
                                                        .font(.caption2)
                                                }
                                                .foregroundColor(.white)
                                            }
                                    }
                                } else if myWordNote.repeatCount == 1 {
                                    // 복습시작
                                    NavigationLink {
                                        OtherTryCardView(myWordNote: myWordNote, word: list)
                                    } label: {
                                        RoundedRectangle(cornerRadius: 3)
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(myWordNote.noteColor)
                                            .overlay {
                                                VStack(spacing: 6) {
                                                    Image(systemName: "play.circle")
                                                        .font(.title3)
                                                    Text("복습시작")
                                                        .font(.caption2)
                                                }
                                                .foregroundColor(.white)
                                            }
                                    }
                                } else if myWordNote.repeatCount == 2 {
                                    NavigationLink {
                                        OtherTryCardView(myWordNote: myWordNote, word: filterLevel(list: list))
                                    } label: {
                                        RoundedRectangle(cornerRadius: 3)
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(myWordNote.noteColor)
                                            .overlay {
                                                VStack(spacing: 6) {
                                                    Image(systemName: "play.circle")
                                                        .font(.title3)
                                                    Text("복습시작")
                                                        .font(.caption2)
                                                }
                                                .foregroundColor(.white)
                                            }
                                    }
                                } else if myWordNote.repeatCount == 3 {
                                    NavigationLink {
                                        // 첫번째 단어 뷰
                                        LastTryCardView(myWordNote: myWordNote, word: list)
                                    } label: {
                                        RoundedRectangle(cornerRadius: 3)
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(myWordNote.noteColor)
                                            .overlay {
                                                VStack {
                                                    Image(systemName: "play.circle")
                                                        .font(.headline)
                                                    Text("복습시작")
                                                        .font(.caption2)
                                                }
                                                .foregroundColor(.white)
                                            }
                                    }
                                } else {
                                    // 도장 이미지
                                    Image("goodicon")
                                        .resizable()
                                        .frame(width: 75, height: 75)
                                        .rotationEffect(.degrees(30))
                                        .padding(.bottom, 35)
                                        .padding(.leading, 55)
                                }
                                
                                Spacer()
                            }
                            .padding(.top, myWordNote.repeatCount == 4 ? 6 : 11)
                        }
                        .padding(.trailing, myWordNote.repeatCount == 4 ? 8 : 15 )
                        .bold()
                    }
                    .padding(.vertical, 5)
            }
            
        }
        .onAppear {
            if userStore.user != nil{
                userStore.fetchMyWords(wordNote: myWordNote) {
                    dump(userStore.myWords)
                    list = userStore.myWords
                    
                }
            }
        }
    }
    
    func filterLevel(list : [Word]) -> [Word] {
        var array : [Word] = []
        for word in list {
            if word.wordLevel != 2 {
                array.append(word)
            }
        }
        return array
    }
}
//
//struct StudyAgainView_Previews: PreviewProvider {
//    static var previews: some View {
//        StudyAgainView()
//    }
//}


