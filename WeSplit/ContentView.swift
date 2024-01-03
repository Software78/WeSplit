//
//  ContentView.swift
//  WeSplit
//
//  Created by Adedola Owen Abaru on 03/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    
                }
                Section{
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?"){
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0..<101, id: \.self) {
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.navigationLink)
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
