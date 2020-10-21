//
//  ContentView.swift
//  WeSplit
//
//  Created by tenpages on 10/20/20.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    //@State private var numberOfPeopleStr = ""
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    /*
    var numberOfPeople: Int {
        return Int(numberOfPeopleStr) ?? 1
    }
    */
    var grandTotal: Double {
        let tipSelection = Double(self.tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount * tipSelection / 100
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(DefaultPickerStyle())
                    /*
                    TextField("Number of people", text: $numberOfPeopleStr)
                        .keyboardType(.numberPad)
                    */
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach (0..<self.tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Grand total")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
