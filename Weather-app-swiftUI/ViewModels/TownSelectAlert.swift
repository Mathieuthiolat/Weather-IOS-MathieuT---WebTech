//
//  TownSelectAlert.swift
//  Weather-app-swiftUI
//
//  Created by ThiolatMathieu on 10/03/2021.
//

import SwiftUI

struct TownSelectAlert: View {
    @Binding var show: Bool
    @Binding var townSearch: String
    var onDone: (String) -> Void = { _ in }
    
    
    var weatherView = ContentView()
    
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity( show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
                // Window
                VStack( alignment: .center, spacing: 0) {
                    Text( "Choisir une nouvelle Ville")
                        .frame( maxWidth: .infinity)
                        .frame( height: 45, alignment: .center )
                        .font( Font.system( size: 25, weight: .semibold ))
                        .foregroundColor( Color.black)
                    
                    TextField( "Ville", text: $townSearch )
                        .multilineTextAlignment( .center )
                        .font( Font.system(size: 16, weight: .semibold ))
                        .padding( EdgeInsets(top: 20, leading: 25, bottom: 20, trailing: 25 ))
                        .foregroundColor( Color.black )
                    
                    HStack(spacing:10) {
                        
                        Button("Annuler",action: {
                            withAnimation(.linear(duration: 0.3)) {
                                show = false
                            }
                        })
                        .foregroundColor(Color.red)
                        .font(Font.system(size: 20, weight: .semibold))
                        Spacer()
                        Button {
                            onDone(self.townSearch)
                            show = false
                        } label: {
                            Text("Valider")
                        }
                        
                    }
                }
                .padding(50)
                .frame( maxWidth: 350, alignment: .center )
                .cornerRadius( 15)
                .border( Color.gray, width: 2	)
                .background( Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) )
            }
        }
    }
}
