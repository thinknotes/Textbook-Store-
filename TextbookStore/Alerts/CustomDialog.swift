//
//  CustomDialog.swift
//  TextbookStore
//
//  Created by Avi Bansal on 6/8/24.
//

import SwiftUI

struct CustomDialog: View {
    
    @Binding var isActive: Bool
    
    let title: String
    let message: String
    let buttonTitle1: String
    let buttonTitle2: String
    let action: () -> ()
    let action1: () -> ()
    
    @State private var offset: CGFloat = 500
    
    
    var body: some View {
        VStack {
            
            
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.yellow)
            
            
            
            Text("\(title)")
                .font(.title2)
                .bold()
                .padding()
                .foregroundColor(.primary)
            
            Text("\(message)")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .frame(height: 100)
            
            Divider()
                .foregroundColor(.gray)
                .padding()
            
            HStack {
                Button(action: {
                    close()
                }, label: {
                    Text("\(buttonTitle2)")
                        .bold()
                        .foregroundColor(.primary)
                })
                .padding()
                
                
                Button(action: {
                  action()
                }, label: {
                    Text("\(buttonTitle1)")
                        .bold()
                        .foregroundColor(.primary)
                })
            }
        }
        .padding()
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 20)
        .padding()
//        .offset(x: 0, y: offset)
//        .onAppear {
//            withAnimation(.spring()) {
//                offset  = 0
//            }
//        }
     
       
    }
    
    func close() {
        withAnimation(.spring()) {
//            offset  = 500
            isActive = false
        }
    }
}

#Preview {
    CustomDialog(isActive: .constant(true), title: "Are you sure?", message: "By agreeing to download, you risk breaking rules set by your college and the manfacture of the book.", buttonTitle1: "Contuine", buttonTitle2: "Go Back To Safety", action: {}, action1: {})
}
