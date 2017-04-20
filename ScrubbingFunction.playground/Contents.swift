//: Playground - noun: a place where people can play

import UIKit
import Foundation

//set get these values and set them using the function parameters
let listOfDepartments = ["CSI", "DAN"]
let year = "17"
let semester = "SP"

//create url to grab courses from
let myURLString = "https://admin.washcoll.edu/schedules/"+year+semester+"schedules.html"
let myURL = NSURL(string: myURLString)

var myHTMLString = String()

//get html of specified page
do {
    myHTMLString = try String(contentsOfURL: myURL!)
    print("HTML : \(myHTMLString)")
    
} catch let error as NSError {
    print("Error: \(error)")
}

//split string and find table with specified departments
var splitStringArray = Array<String>();

var priorString = String()
priorString = myHTMLString.componentsSeparatedByString("pre").first!
var postString = myHTMLString.substringFromIndex()
    //fullName.characters.split{$0 == " "}.map(String.init)
