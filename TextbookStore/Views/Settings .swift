//
//  Settings .swift
//  TextbookStore
//
//  Created by Avi Bansal on 7/2/24.
//

import SwiftUI
import Setting

struct settings: View {
    
    @State private var search: String = ""
    
    @State private var isStudyMode: Bool = false
    
    var isSub: Bool = false
    
    var name: String = ""
    
    @AppStorage("languageIndex") var languageIndex = 0
    
    @StateObject var model = settingModel()
    
    @EnvironmentObject private var tracker: ScreenTimeTracker

    
    var body: some View {
        
        
        SettingStack {
            SettingPage(title: "Settings") {
                SettingCustomView {
                    Color.blue
                        .opacity(0.1)
                        .cornerRadius(12)
                        .overlay {
                            if model.isSub == false {
                                VStack {
                                    HStack {
                                        Text("Subscrible")
                                            .bold()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding()
                                        
                                        
                                        Spacer()
                                        
                                        Text("T+")
                                            .padding()
                                            .bold()
                                            .font(.title2)
                                        
                                    }
                                    
                                    Text("Unlock full access and more with Textbook Plus")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                    
                                    Button("Learn More") {
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal)
                                }
                            } else {
                                EmptyView()
                            }
                                
                        }
                        .frame(height: 150)
                        .padding(.horizontal, 16)
                }
                
                
                SettingToggle(title: "Study Mode", isOn: $isStudyMode)
                
                SettingGroup {
                    SettingPage(title: "Notifications") {}
                        .previewIcon("bell.badge.fill", color: .pink)
                    
                    
                    SettingPage(title: "Sound & Haptics") {}
                        .previewIcon("speaker.wave.3.fill", color: .pink)
                    
                    SettingPage(title: "Focus") {}
                        .previewIcon("moon.fill", color: .indigo)
                    
                    SettingPage(title: "App Usage") {
                        SettingCustomView {
                            Text(tracker.formattedTime())
                                          .font(.system(size: 60, design: .monospaced))
                                          .padding()
                        }
                        
                    }
                        .previewIcon("hourglass", color: .indigo)
                }
                
                SettingGroup {
                    SettingPage(title: "General") {
                        SettingGroup(header: "Language") {
                            SettingPicker(
                                title: "Language",
                                choices: [
                                    "English",
                                    "English UK",
                                    "English AU",
                                    "Spanish",
                                    "French",
                                    "Italian",
                                    "German",
                            ],
                                selectedIndex: $languageIndex
                                
                                
                            )
                            
                            
                            
                        }
                        
                        SettingGroup(header: "Privacy") {
                            SettingPage(title:  "privacy") {
                                SettingGroup(header: "You can't turn these off. HEHEHAHA!") {
                                  SettingToggle(title: "Track Data", isOn: .constant(true))
                                  
                                
                               
                                  SettingToggle(title: "Download Ads", isOn: .constant(true))
                                  SettingToggle(title: "Show Ads", isOn: .constant(true))
                                                                                    }

                                  SettingGroup {
                                        SettingPage(title: "Advanced") {
                                        SettingGroup(footer: "Tap to sell all your data to Google.") {
                                        SettingButton(title: "Sell Data to Google") {
                                            print("Data Sold!")
                                            }
                                                                                            }
                                                                                        }
                                                                                    }
                            }
                            .previewIcon("hand.raised.fill")
                                                  
                        }
                    }
                    .previewIcon("gear", color: .gray)
                    
                    SettingPage(title: "Wallet") {}
                        .previewIcon("creditcard.fill", color: .black)
                    
                    SettingPage(title: "Calendar") {
                        SettingPage(title: "Date Format") {
                            SettingGroup(header: "US Date"){
                                SettingCustomView {
                                    VStack {
                                        Text(model.isUSFormat ?
                                                       model.selectedDate.formatted(.dateTime.month().day().year()) :
                                                       model.selectedDate.formatted(.dateTime.day().month().year()))
                                            .font(.title)
                                            .padding()
                                        
                                        Button(action: {
                                            model.toggleFormat()
                                        }) {
                                            Text(model.isUSFormat ? "Switch to EU Format" : "Switch to US Format")
                                                .padding()
                                                .foregroundColor(.white)
                                                .background(Color.blue)
                                                .cornerRadius(8)
                                        }
                                        .padding()
                                        
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
//                            SettingGroup(header: "EU Date") {
//                                SettingCustomView {
//                                    Text("\(model.EUDate)")
//                                        .padding()
//                                }
//                            }
                        }
                        
                    }
                        .previewIcon("calendar", color: .red)
                }
                
                SettingGroup {
                    SettingText(id: "Announcement 1", title: "Version: 1.0")
                    SettingText(id: "Announcement 2", title: "Desgined and built in San Fransisco, California")
                }
            }
        }
//
    }
}

#Preview {
    settings(name: "Kyle")
        .environmentObject(settingModel())
        .environmentObject(ScreenTimeTracker())
       
        
}


struct ScreenRings: View {
    
    var icon: String
    var BG: String
    var WHeight: CGFloat
    var completionRate: Double
    var ringThickness: CGFloat
    var colorGradient: Gradient
    
    
    private var rotationDegree: Angle {
        .degrees(-90)
    }
    
    private var endAngle: Angle {
        .degrees(completionRate * 360 - 90)
    }
    
    private var strokeStyle: StrokeStyle {
        StrokeStyle(lineWidth: ringThickness, lineCap: .round)
    }
    
    private var gradientEffect: AngularGradient {
        AngularGradient(gradient: colorGradient, center: .center, startAngle: rotationDegree, endAngle: endAngle)
    }
    
    private var gradientEndColor: Color {
        colorGradient.stops.indices.contains(1) ? colorGradient.stops[1].color : Color.clear
    }
    
    private var circleShadow: Color {
        .black.opacity(0.4)
    }
    
    private var overlayPositon: (_ width: CGFloat, _ height: CGFloat) -> CGPoint {
        return { width, height in
            CGPoint(x: width / 2, y: height / 2)
        }
    }
    
    private var overlayOffset: (_ width: CGFloat, _ height: CGFloat) -> CGFloat {
        return { width, height in
            min(width, height) / 2
        }
    }
    
    private var overlayRoation: Angle {
        .degrees(completionRate * 360 - 90)
    }
    
    private var clippedCircleRoation: Angle {
        .degrees(-90 + completionRate * 360)
    }
    
    var body: some View {
        ZStack {
            Circle().stroke(lineWidth: 30).foregroundColor(.teal).opacity(0.2)
            Circle().rotation(rotationDegree)
                .trim(from: 0, to: CGFloat(completionRate))
                .stroke(gradientEffect, style: strokeStyle)
                .overlay(overlayCircle)
        }
        .frame(width: WHeight, height: WHeight)
        .overlay(alignment: .top) {
            Image(systemName: icon).bold().offset(y: -11).font(.title2)
                .foregroundColor(.black)
               
        }
    }

    var overlayCircle: some View {
        GeometryReader { geo in
            Circle().fill(gradientEndColor)
                .frame(width: ringThickness, height: ringThickness)
                .position(overlayPositon(geo.size.width, geo.size.height))
                .offset(x: overlayOffset(geo.size.width, geo.size.height))
                .rotationEffect(overlayRoation)
                .shadow(color: circleShadow, radius: ringThickness / 5)
        }
        .clipShape(
            Circle().rotation(clippedCircleRoation).trim(from: 0, to: 0.1)
                .stroke(style: strokeStyle)
        )
    }
}

#Preview {
    ScreenRings(icon: "arrow.up", BG: "\(Color.teal)", WHeight: 300, completionRate: 1.2, ringThickness: 30, colorGradient: Gradient(colors: [Color.red, .pink]))
}
