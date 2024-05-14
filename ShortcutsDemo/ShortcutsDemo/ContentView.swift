//
//  ContentView.swift
//  ShortcutsDemo
//
//  Created by Mirza Učanbarlić on 14. 5. 2024..
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        Form {
            Button {
                let url = URL(string: "shortcuts://open-shortcut?name=Shazam shortcut")!
                UIApplication.shared.open(url)
            } label: {
                Text("Open shortcut")
            }
            
            Button {
                let url = URL(string: "shortcuts://create-shortcut")!
                UIApplication.shared.open(url)
            } label: {
                Text("Create new shortcut")
            }
            
            Button {
                let url = URL(string: "shortcuts://")!
                UIApplication.shared.open(url)
            } label: {
                Text("Open shorcuts app")
            }
            
            Section("Running shortcuts") {
                Button {
                    let url = URL(string: "https://www.icloud.com/shortcuts/62802e396f014e96b4834bda7f666820")!
                    UIApplication.shared.open(url)
                } label: {
                    Text("Install Note With Input")
                }
                
                TextField("Shorcut Input", text: $text)
                
                Button {
                    let url = URL(string: "shortcuts://run-shortcut?name=Note With Input&input=text&text=\(text)")!
                    UIApplication.shared.open(url)
                } label: {
                    Text("Run shortcut (Note With Input)")
                }
                Button {
                    let url2 = URL(string: "shortcuts://run-shortcut?name=Note With Input&input=clipboard")!
                    UIApplication.shared.open(url2)
                } label: {
                    Text("Run shortcut (Note With Input) from clipboard")
                }
            }
            
            Section("Callback after running shortcuts") {
                Button {
                    let url = URL(string: "shortcuts://x-callback-url/run-shortcut?name=Note With Input&input=text&text=test&x-success=shortcutsdemo://")!
                    UIApplication.shared.open(url)
                } label: {
                    Text("Run shortcut (Note With Input) and go back to app")
                }
                Button {
                    let url = URL(string: "https://www.icloud.com/shortcuts/34b404316851486b81120d8adf073108")!
                    UIApplication.shared.open(url)
                } label: {
                    Text("Install Shortcut (Get My Shortcuts)")
                }
                Button {
                    let url = URL(string: "shortcuts://x-callback-url/run-shortcut?name=Get My Shortcuts&x-success=shortcutsdemo://")!
                    UIApplication.shared.open(url)
                } label: {
                    Text("Run shortcut (Get My Shortcuts) and print result in app")
                }
            }
            .onOpenURL(perform: { url in
                if url.scheme == "shortcutsdemo" {
                    guard let dirty = url.absoluteString.split(separator: "result=").last,
                          let clean = String(dirty).removingPercentEncoding
                    else {
                        return
                    }
                    let shortcuts = clean.split(separator: "\n").map { String($0) }
                    print(shortcuts)
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
