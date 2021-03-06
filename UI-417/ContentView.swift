//
//  ContentView.swift
//  UI-417
//
//  Created by nyannyan0328 on 2022/01/11.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    
    func lLeading()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .leading)
    }
    
    
    func lTreading()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .trailing)
    }
    
    
    func lCenter()->some View{
        
        self
            .frame(maxWidth:.infinity,alignment: .center)
    }
    
    func getSafeArea()->UIEdgeInsets{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            
            return .zero
            
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            
            return .zero
        }
        
        return safeArea
    }
    
    
    
}
