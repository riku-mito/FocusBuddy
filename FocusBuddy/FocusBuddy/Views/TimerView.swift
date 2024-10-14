//
//  TimerView.swift
//  FocusBuddy
//
//  Created by Riku Mito on 2023/06/01.
//
//  ====== Credits: =====
//  Swift code referenced from "Build a SwiftUI Custom Countdown Timer app for iOS 15 (2022)" by @Indently https://www.youtube.com/watch?v=NAsQCNpodPI
//  =====================

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        NavigationView{
            VStack {
                Text("\(timerViewModel.time)")
                    .font(.system(size: 70, design: .rounded))
                    .padding()
                    .frame(width: width)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4))
                    .alert("Timer complete! ⏱", isPresented: $timerViewModel.showingAlert) {
                        Button("Continue", role: .cancel) {
                            
                        }
                    }
                Slider(value: $timerViewModel.minutes, in: 1...60, step: 1) // Starts from 1 minute and limits to an hour
                    .padding()
                    .frame(width: width)
                    .disabled(timerViewModel.isActive)
                    .animation(.easeInOut, value: timerViewModel.minutes)
                
                HStack(spacing: 50) {
                    Button("Start") {
                        timerViewModel.start(minutes: timerViewModel.minutes)
                    }
                    .disabled(timerViewModel.isActive)
                    
                    Button("Reset", action: timerViewModel.reset)
                        .tint(.red)
                }
                .frame(width: width)
            }
            .onReceive(timer) { _ in
                timerViewModel.updateCountdown()
            }
            .navigationBarTitle("Timer ⏱", displayMode: .inline)
            
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(TimerViewModel())
    }
}
