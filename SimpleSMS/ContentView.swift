//
//  ContentView.swift
//  SimpleSMS
//
//  Created by Amit Gupta on 9/22/22.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    let tSid="ACecb0fdd2d02aa3ffb6c622e928c0d660"
    let defaultMedia="https://c1.staticflickr.com/3/2899/14341091933_1e92e62d12_b.jpg"
    
    @State var destNumber="16502234153"
    @State var messageToSend="Hello from Automated SMS"
    @State var tToken=""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            /*
                Text("~~A strikethrough example~~")
                Text("`Monospaced works too`")
                Text("Visit Apple: [click here](https://apple.com)")
          */

            Text("SMS Sender")
                .font(.system(size: 40))
            Spacer()
            SecureField("Token",text:$tToken)
            NavigationView {
                TextEditor(text: $destNumber)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                                .navigationTitle("Sending to #")
            }
            .font(.system(size: 30))
            NavigationView {
                TextEditor(text: $messageToSend)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                                .navigationTitle("Message")
            }
            .font(.system(size: 30))

            Spacer()
            Button("Send SMS") {
                sendSMS(destNumber, messageToSend)
            }            .font(.system(size: 40))
                .padding()
                .background(Color.yellow)
                .clipShape(Capsule())
            Spacer()
            Button("Send MMS") {
                sendMMS(destNumber, messageToSend,defaultMedia)
            }            .font(.system(size: 40))
                .padding()
                .background(Color.yellow)
                .clipShape(Capsule())
        }
        .padding()
    }
    
    // https://c1.staticflickr.com/3/2899/14341091933_1e92e62d12_b.jpg
    
    func sendSMS(_ n:String, _ m:String) {
        print("Sending SMS message \(m) to \(n)")
 
          let url = "https://api.twilio.com/2010-04-01/Accounts/\(tSid)/Messages.json"
        
          let parameters = ["From": "+18565309861",
                            "To": n,
                            "Body": m]

          AF.request(url, method: .post, parameters: parameters)
            .authenticate(username: tSid, password: tToken)
            .responseString { response in
                debugPrint("Response: \(response)")
          }
    }
    
    func sendMMS(_ n:String, _ m:String, _ u:String) {
        print("Sending MMS message \(m) to \(n) with URL \(u)")
 
          let url = "https://api.twilio.com/2010-04-01/Accounts/\(tSid)/Messages.json"
        
          let parameters = ["From": "+18565309861",
                            "To": n,
                            "Body": m,
                            "MediaUrl": u]

          AF.request(url, method: .post, parameters: parameters)
            .authenticate(username: tSid, password: tToken)
            .responseString { response in
                debugPrint("Response: \(response)")
          }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
