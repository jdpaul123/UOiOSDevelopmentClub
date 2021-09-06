//
//  Welcome.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/2/21.
//

import SwiftUI

struct Welcome: View {
    // Properties
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ScrollView {
            VStack {
                
                Text("The University of Oregon\niOS Development Club")
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.black)
                    )
                    .padding(.all, 15)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .foregroundColor(.green)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityIdentifier("Title")
                
                Text("Our mission is to build and maintain a supportive community for students interested in learning and expanding their knowledge through iOS development and other forms of Apple software development.")
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.black)
                    )
                    .padding([.leading, .trailing], 40)
                    .padding([.bottom], 15)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(.green)
                    .fixedSize(horizontal: false, vertical: true)
                    .accessibilityIdentifier("Mission Statement")
                
                HStack {
                    Button(action: {
                        openURL(URL(string: "https://appledevelopmentcl.wixsite.com/uoiosclub")!)
                    }, label: {
                        Text("Website")
                            .frame(width: 130, height: 75, alignment: .center)
                    })
                    .foregroundColor(.green)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                            //.stroke(Color.green, lineWidth: 2)
                    )
                    .padding(.trailing, 5)
                    .accessibilityIdentifier("Club Website")
                    .accessibilityLabel(Text("Club Website"))
                    
                    Button(action: {
                        openURL(URL(string: "https://discord.gg/dXF84P5FUr")!)
                    }, label: {
                        Text("Discord")
                            .frame(width: 130, height: 75, alignment: .center)

                    })
                    .foregroundColor(.green)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.black)
                        //.stroke(Color.green, lineWidth: 2)
                    )
                    .accessibilityIdentifier("Discord")
                    .accessibilityLabel(Text("Discord"))
                }
                
                HStack {
                    Button(action: {
                        openURL(URL(string: "https://uoregon.campuslabs.com/engage/organization/iosdevclub")!)
                    }, label: {
                        Text("Engage")
                            .frame(width: 130, height: 75, alignment: .center)

                    })
                    .foregroundColor(.green)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black)
                            //.stroke(Color.green, lineWidth: 2)
                    )
                    .padding(.trailing, 5)
                    .accessibilityIdentifier("Engage Website")
                    .accessibilityLabel(Text("Engage Website"))
                    
                    Button(action: {
                        openURL(URL(string: "https://www.instagram.com/iosdevclub/")!)
                    }, label: {
                        Text("Instagram")
                            .frame(width: 130, height: 75, alignment: .center)
                    })
                    .foregroundColor(.green)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.black)
                        //.stroke(Color.green, lineWidth: 2)
                    )
                    .accessibilityIdentifier("Instagram Page")
                    .accessibilityLabel(Text("Instagram Page"))
                }
                .padding([.top], 10)
                
            }
            
            Image("welcomeViewPicture")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .shadow(radius: 20)
                .padding()
                .accessibilityLabel(Text("Screenshot of Xcode Development of the code to build this views UI"))
            
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.green, .yellow]), startPoint: .top, endPoint: .trailing)
        )
        
    }
}



struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
