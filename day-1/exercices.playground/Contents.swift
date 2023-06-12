import UIKit

let hourForDay = 8.0
let dayForMonth = 22.0

// payment for day
func dailyRateFrom(hourlyRate: Double) -> Double {
    return hourlyRate * hourForDay
}
print(dailyRateFrom(hourlyRate: 60))


//payment for month with discount
func monthlyRateFrom(hourlyRate: Double, withDiscount: Double) -> Double {
    let month = dailyRateFrom(hourlyRate: hourlyRate) * dayForMonth
    let discount = month * (withDiscount / 100)
    let result = round(month - discount)
    return result
}
print(monthlyRateFrom(hourlyRate:77.0, withDiscount: 10.5))


// how many workdays given my budget
func workdaysIn(budget: Double, hourlyRate: Double, withDiscount: Double) -> Double {
    let priceMonth = monthlyRateFrom(hourlyRate: hourlyRate, withDiscount: withDiscount)
    let paymentForDay = priceMonth / dayForMonth
    let result = round(budget / paymentForDay)
    return result
}
print(workdaysIn(budget: 20000, hourlyRate: 80, withDiscount: 11.0))




// bonus

let paymentWithoutInterest = 60.0

// can buy with mt budget
func canIBuy(vehicle: String, price: Double, monthlyBudget: Double) -> String {
    if((price / paymentWithoutInterest) < monthlyBudget){
        return "you can buy"
    } else if ((price / paymentWithoutInterest) < monthlyBudget * 1.1){
        return "be careful"
    } else {
        return "dont buy!"
    }
}
print(canIBuy(vehicle: "1974 Ford Pinto", price: 516.32, monthlyBudget: 100.00))
print(canIBuy(vehicle: "2011 Bugatti Veyron", price: 2_250_880.00, monthlyBudget: 10000.00))
print(canIBuy(vehicle: "2020 Indian FTR 1200", price: 12_500, monthlyBudget: 200))


// num of drivers license
func licenseType(numberOfWeels: Int) -> String {
    switch numberOfWeels {
    case 2,3:
        return "You will need a motorcycle license for your vehicle"
    case 4,6:
        return "You will need an automobile license for your vehicle"
    case 18:
        return "You will need a commercial trucking license for your vehicle"
    default:
        return "We do not issue licenses for those types of vehicles"
    }
}
print(licenseType(numberOfWeels: 2))
print(licenseType(numberOfWeels: 6))
print(licenseType(numberOfWeels: 18))
print(licenseType(numberOfWeels: 0))


//how many us the taxPayment
func registrationFee(msrp: Int, yearsOld: Int) -> Double {
    if(yearsOld > 10){
        return 25.0
    } else {
        var currMsrp = Double(msrp)
        var currYears = Double(yearsOld)    
        
        let anha = (currMsrp * (currYears * 0.1))
        var currPrice = floor(((currMsrp - anha) / 100))
        return currPrice
    }
}
print(registrationFee(msrp: 2_250_800, yearsOld: 9))
print(registrationFee(msrp: 25_000, yearsOld: 3))
print(registrationFee(msrp: 34_000, yearsOld: 30))

