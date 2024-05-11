//
//  ContentView.swift
//  Alphabets
//
//  Created by Shahid Ghafoor on 11/05/2024.
//


import SwiftUI

struct ContentView: View {
    
    let alphabets = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ") // Alphabets array
    
    let SECONDS_TO_CHANGE_ALPHABET = 1.00  // 10 Seconds
    let ALPHABET_TEXT_SIZE = 100.00  //
    let BUTTON_SIZE = 40.00
    
    @State private var selectedAlphabetIndex = 0
    @State private var showRandomAlphabet = false
    
    var body: some View {
        ZStack {
            // Transparent overlay covering the whole screen
            Color.clear
                .contentShape(Rectangle())
                .gesture(
                    DragGesture()
                        .onEnded({ value in
                            if !showRandomAlphabet {
                                if value.translation.width < 0 {
                                    // Swiped left
                                    if selectedAlphabetIndex < alphabets.count - 1 {
                                        selectedAlphabetIndex += 1
                                    }
                                    print("Swipe Left and current alphabet is \(alphabets[selectedAlphabetIndex])")
                                    
                                } else {
                                    // Swiped right
                                    if selectedAlphabetIndex > 0 {
                                        selectedAlphabetIndex -= 1
                                    }
                                    
                                    print("Swipe Right and current alphabet is \(alphabets[selectedAlphabetIndex])")
                                }
                            }
                        })
                )
            
            VStack {
                Toggle("Show Random Alphabet", isOn: $showRandomAlphabet)
                    .padding()
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack {
                        HStack {
                            if !showRandomAlphabet {
                                Button(action: {
                                    // Previous button action
                                    if selectedAlphabetIndex > 0 {
                                        selectedAlphabetIndex -= 1
                                    }
                                    print("Left Button Pressed and current alphabet is \(alphabets[selectedAlphabetIndex])")
                                }) {
                                    Image(systemName: "arrow.left.circle")
                                        .font(.system(size: BUTTON_SIZE))
                                }
                                .padding()
                                .simultaneousGesture(
                                    TapGesture()
                                )
                            }
                            
                            Spacer()
                            
                            Text(showRandomAlphabet ? String(alphabets.randomElement()!) : String(alphabets[selectedAlphabetIndex]))
                                .font(.system(size: ALPHABET_TEXT_SIZE))
                                .padding()
                            
                            Spacer()
                            
                            if !showRandomAlphabet {
                                Button(action: {
                                    // Next button action
                                    if selectedAlphabetIndex < alphabets.count - 1 {
                                        selectedAlphabetIndex += 1
                                    }
                                    print("Right Button Pressed and current alphabet is \(alphabets[selectedAlphabetIndex])")
                                    
                                }) {
                                    Image(systemName: "arrow.right.circle")
                                        .font(.system(size: BUTTON_SIZE))
                                }
                                .padding()
                                .simultaneousGesture(
                                    TapGesture()
                                )
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onReceive(Timer.publish(every: SECONDS_TO_CHANGE_ALPHABET, on: .main, in: .common).autoconnect()) { _ in
            if showRandomAlphabet {
                let currentAlphabet = Int.random(in: 0..<alphabets.count)
                selectedAlphabetIndex = currentAlphabet
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class CustomTimer {
    var timer: Timer?
    var interval: Double
    var handler: () -> Void

    init(interval: Double, handler: @escaping () -> Void) {
        self.interval = interval
        self.handler = handler
        start()
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            self.handler()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }
}
