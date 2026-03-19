//
//  CufiApp.swift
//  Cufi
//
//  Created by Jonathan Lim on 3/17/26.
//

import SwiftUI
import LocalConsole
import Alamofire

let lc = LocalConsole.LCManager.shared

@main
struct CufiApp: App {
    @State private var initialLoading: Bool = true
    @State private var showServerConf: Bool = false
    @AppStorage("server") var server: String = ""
    @AppStorage("cufiVersion") var version: String = ""
    init() {
        UserDefaults.standard.register(defaults: ["UseFloatingTabBar": false])
//        eLC()
        print("Cufi: A Coffee App")
    }
    var body: some Scene {
        WindowGroup {
            if initialLoading {
                LoadingView()
                    .onAppear {
//                        server = ""
                        if type(of: getUserDefaults("cufiList")) == String.self {
                            print("a")
                            saveRecipes([])
                        }
                        initCufi()
                    }
                    .sheet(isPresented: $showServerConf) {
                        VStack(alignment: .leading) {
                            Text("Please configure Cufi Server")
                                .font(.title.bold())
                            HStack {
                                TextField("Enter the URL here", text: $server)
                                    .textInputAutocapitalization(.never)
                                    .disableAutocorrection(true)
                                    .keyboardType(.URL)
                                    .padding()
                                    .glassEffect(.clear.interactive())
                                Button(action: {
                                    AF.request(server)
                                        .response { r in
                                            if let data = r.data, let res = String(data: data, encoding: .utf8) {
                                                print(res)
                                                if res == "Cufi?" {
                                                    showServerConf = false
                                                    initCufi()
                                                }
                                            }
                                        }
                                }, label: {
                                    Image(systemName: "checkmark")
                                        .tint(.prim)
                                        .padding()
                                })
                                .glassEffect(.clear.interactive())
                                .disabled(server.isEmpty)
                            }
                            Text("What is Cufi Server: I have no idea.")
                                .font(.caption2.bold())
                                .foregroundStyle(.secondary)
                            HStack {
                                Spacer()
                                if !(readRecipes().isEmpty) {
                                    Button("Continue without server", action: {
                                        initialLoading = false
                                    })
                                }
                                Spacer()
                            }
                        }
                        .padding()
                    }
            } else {
                ContentView()
            }
        }
    }
    func initCufi() {
        cufiVersion() { r in
            if r.isEmpty {
                showServerConf = true
            } else {
                if version != r {
                    print("Cufi list is outdated")
                    cufiList() { c in
                        saveRecipes(c)
                        version = r
                        initialLoading = false
                    }
                } else {
                    print("Cufi list is up to date")
                    initialLoading = false
                }
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text("Cufi")
                        .font(.largeTitle.bold())
                    Image("coffee")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.prim)
                }
                Text("A Coffee App")
                    .font(.title2.bold())
                    .foregroundStyle(.secondary)
                    .padding(.top, -25)
                Spacer()
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(100)
    }
}

func eLC() {
    lc.isVisible = true
}
func dLC() {
    lc.isVisible = false
}
func print(_ what: Any) {
    lc.print(what)
    Swift.print(what)
}
