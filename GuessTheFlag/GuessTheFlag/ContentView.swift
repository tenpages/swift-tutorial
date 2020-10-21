//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Shuo Liu on 10/21/20.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreTotal = 0
    @State private var questionTotal = 0
    @State private var resetScoreFlag = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .white, radius: 2)
                    }
                }
                HStack {
                    Text("Correct choices: ")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text("\(scoreTotal) out of \(questionTotal)")
                        .font(.largeTitle)
                }.foregroundColor(.white)
                Spacer()
                Button(action: {
                    resetScoreFlag = true
                    resetScoreBoard()
                }) {
                    Text("Reset score history")
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(scoreTotal)/\(questionTotal)"), dismissButton: .default(Text("Continue")) {
                    askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreTotal += 1
        } else {
            scoreTitle = "Wrong! This is the flag of "+countries[number]
        }
        
        questionTotal += 1
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetScoreBoard() {
        scoreTotal = 0
        questionTotal = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
