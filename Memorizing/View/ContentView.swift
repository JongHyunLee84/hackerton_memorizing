//
//  ContentView.swift
//  Memorizing
//
//  Created by 진준호 on 2023/01/05.
//

import SwiftUI

// MARK: Login 상태에 따라 LoginView 또는 TabView를 보여주는 View
struct ContentView: View {
    @EnvironmentObject var userStore: UserStore
    @StateObject var marketStore: MarketStore = MarketStore()
    @EnvironmentObject var notiManager: NotificationManager
    
    @State var email: String
    @State var password: String
    
    var body: some View {
        VStack{
            switch userStore.state {
            case .signedIn:
                MainView()
                    .environmentObject(marketStore)
                
            case .signedOut:
                LoginView()
                    .environmentObject(marketStore)
                
            case .firstIn:
                var _ = print("OnBoardingTabView: \(self.email) / \(self.password)")
                OnBoardingTabView(currentTab: self.email == "" && self.password == "" ? 0 : 3,
                                  email: $email,
                                  password: $password)
            case .check:
                FirstView()
            }
            
        }
        .task{
            // 알림 권한 여부 확인
            try? await notiManager.requestAuthorization()
            
            self.email = UserDefaults.standard.string(forKey: UserDefaults.Keys.email.rawValue) ?? ""
            self.password = UserDefaults.standard.string(forKey: UserDefaults.Keys.password.rawValue) ?? ""
            print("task: \(self.email) / \(self.password)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(email: "", password: "")
    }
}
