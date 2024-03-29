//
//  OtherTryCardView.swift
//  Memorizing
//
//  Created by 전근섭 on 2023/01/06.
//

import SwiftUI

// MARK: 두번째, 세번째 복습하기 뷰
struct OtherTryCardView: View {
    
    //    // FIXME: 단어장 이름 firebase에서 가져오기...?
    //    @State private var wordListName: String = "혜지의 감자 목록 100가지 단어장"
    //    // FIXME: 단어장 단어 총 수
    //    @State private var listLength: Int = 100
    //    // FIXME: 단어장 현재 단어 x번째
    //    @State private var currentListLength: Int = 30
    //    // FIXME: 현재 단어
    //    @State private var currentWord: String = "정우성"
    //    // FIXME: 현재 단어 뜻
    //    @State private var currentWordDef: String = "현기"
    
    @Environment(\.dismiss) private var dismiss
    var myWordNote : WordNote
    var word : [Word]
    @State var isDismiss : Bool = false
    @State var num = 0
    var wordCount : Int {
        word.count - 1
    }
    // MARK: 카드 뒤집는데 쓰일 것들
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.3
    
    var body: some View {
        VStack {
            ZStack {
                // 진행바
                rectangleProgressView
                    .overlay {
                        overlayView.mask(rectangleProgressView)
                    }
            }
            .padding(.bottom, 30)
            
            // MARK: 카드뷰
            ZStack {
                wordCardFrontView2(listLength: wordCount, currentListLength: $num, currentWord: word[num].wordString, degree: $frontDegree)
                wordCardBackView2(listLength: wordCount, currentListLength: $num, currentWordDef: word[num].wordMeaning, degree: $backDegree)
            }
            .onTapGesture {
                flipCard()
            }
            
            NextPreviousButton(isFlipped: $isFlipped, isDismiss: $isDismiss, num: $num, wordNote: myWordNote, lastWordIndex: wordCount)
                .padding(.top)
            
            Spacer()
            
        }
        .navigationTitle(myWordNote.noteName)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: isDismiss, perform: { _ in
            dismiss()
        })
        .onChange(of: isFlipped, perform: { _ in
            flipCard()
        })
    }
    
    // MARK: 파란 진행바 뷰
    var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color("MainBlue"))
                    .frame(width: CGFloat(num) / CGFloat(wordCount) * geometry.size.width)
                    .animation(.easeInOut, value: num)
            }
            
        }
        .allowsHitTesting(false)
        
    }
    
    // MARK: 회색 전체 진행 바
    var rectangleProgressView: some View {
        HStack(spacing: 0) {
            Rectangle()
                .frame(width: 393, height: 3)
                .foregroundColor(Color("Gray4"))
            
        }
    }
    
    // MARK: 카드 뒤집기 함수
    func flipCard () {
        print("flipcard 실행")
        print(isFlipped)
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
}

// MARK: 카드 뒷 뷰
struct wordCardBackView2: View {
    
    // MARK: 단어장 단어 총 수
    var listLength: Int
    // MARK: 단어장 현재 단어 x번째
    @Binding var currentListLength: Int
    // MARK: 현재 단어 뜻
    var currentWordDef: String
    // MARK: 카드 뒤집기 각도
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            Color.white
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("Gray4"), lineWidth: 1)
                .foregroundColor(.white)
            
            
            VStack {
                HStack {
                    // MARK: 현재 단어 순서 / 총 단어 수
                    Text("\(currentListLength + 1) / \(listLength + 1)")
                    
                    Spacer()
                    
                    // 소리 버튼
                    Button {
                        
                    } label: {
                        Image(systemName: "speaker.wave.2")
                            .foregroundColor(Color("MainBlack"))
                    }
                }
                .padding()
                
                Spacer()
                
                // MARK: 현재 단어
                Text("\(currentWordDef)")
                    .padding(.bottom, 70)
                    .font(.largeTitle).bold()
                
                Spacer()
                
            }
        }
        .frame(width: 330, height: 330)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

// MARK: 카드 앞 뷰
struct wordCardFrontView2: View {
    
    // MARK: 단어장 단어 총 수
    var listLength: Int
    // MARK: 단어장 현재 단어 x번째
    @Binding var currentListLength: Int
    // MARK: 현재 단어
    var currentWord: String
    // MARK: 카드 뒤집기 각도
    @Binding var degree: Double
    
    var body: some View {
        ZStack {
            Color.white
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("Gray4"), lineWidth: 1)
                .foregroundColor(.white)
            
            
            VStack {
                HStack {
                    // MARK: 현재 단어 순서 / 총 단어 수
                    Text("\(currentListLength + 1) / \(listLength + 1)")
                    
                    Spacer()
                    
                    // 소리 버튼
                    Button {
                        
                    } label: {
                        Image(systemName: "speaker.wave.2")
                            .foregroundColor(Color("MainBlack"))
                    }
                }
                .padding()
                
                Spacer()
                
                // MARK: 현재 단어 뜻
                Text("\(currentWord)")
                    .foregroundColor(Color("MainBlue"))
                    .padding(.bottom, 70)
                    .font(.largeTitle).bold()
                
                Spacer()
                
            }
        }
        .frame(width: 330, height: 330)
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

// MARK: 이전 다음 버튼
struct NextPreviousButton: View {
    @Binding var isFlipped : Bool
    @EnvironmentObject var userStore : UserStore
    @Binding var isDismiss : Bool
    @Binding var num : Int
    @State var isShowingAlert : Bool = false
    var wordNote : WordNote
    var lastWordIndex : Int
    @EnvironmentObject var notiManager: NotificationManager

    var body: some View {
        HStack {
            // TODO: 이전 버튼
            Button {
                if 0 != num {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                        num -= 1
                    }
                    isFlipped = false
                }
            } label: {
                HStack {
                    Image(systemName: "arrowtriangle.left.fill")
                    Text("이전")
                }
                .foregroundColor(.white)
                .frame(width: 160, height: 50)
                .background(Color("MainDarkBlue"))
                .cornerRadius(15)
            }
            
            Spacer()
            
            // TODO: 다음 버튼
            Button {
                if lastWordIndex != num {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                        num += 1
                    }
                    isFlipped = false
                
                } else {
                    isShowingAlert = true
                }
            } label: {
                HStack {
                    Text("다음")
                    Image(systemName: "arrowtriangle.right.fill")
                }
                .foregroundColor(.white)
                .frame(width: 160, height: 50)
                .background(Color("MainBlue"))
                .cornerRadius(15)
            }
            
        }
        .frame(width: 330)
        .alert("Alert Title", isPresented: $isShowingAlert) {
            Button("Ok") {
                Task{
                    await userStore.plusRepeatCount(wordNote: wordNote)
                    
                    // 알림 설정 권한 확인
                    if !notiManager.isGranted{
                        notiManager.openSetting()  // 알림 설정 창
                    }else if notiManager.isGranted && (wordNote.repeatCount + 1) < 4{ // 알림 추가
                        print("set localNotification")
                    var localNotification = LocalNotification(identifier: UUID().uuidString, title: "MEMOrizing 암기 시간", body: "\(wordNote.repeatCount + 1)번째 복습할 시간이에요~!", timeInterval: Double(wordNote.repeatCount * 1), repeats: false)
                    localNotification.subtitle = "\(wordNote.noteName)"
                        print("localNotification: ", localNotification)

                    await notiManager.schedule(localNotification: localNotification)
                        await notiManager.getPendingRequests()
                    }
                    isDismiss.toggle()
                }
            }
        } message: {
            Text("모든 단어를 공부했습니다 :)")
        }
    }
        
}


//struct OtherTryCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            OtherTryCardView()
//        }
//    }
//}
