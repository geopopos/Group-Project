//: Playground - noun: a place where people can play

import UIKit
import Foundation

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
}


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
    myHTMLString = try String(contentsOf: myURL! as URL)
    print("HTML : \(myHTMLString)")
    
} catch let error as NSError {
    print("Error: \(error)")
}

var string = "hello Swift"

if myHTMLString.range(of:"CSI") != nil{
    print("exists")
}

myHTMLString.index(of: "pre")

//let text = "abc"
//let index2 = text.index(text.startIndex, offsetBy: 2) //will call succ 2 times
//let lastChar: Character = text[index2] //now we can index!
//
//let characterIndex2 = text.characters.index(text.characters.startIndex, offsetBy: 2)
//let lastChar2 = text.characters[characterIndex2] //will do the same as above
//
//let range: Range<String.Index> = text.range(of: "b")!
//let index: Int = text.distance(from: text.startIndex, to: range.lowerBound)

// alternative: not case sensitive
//if string.lowercased().range(of:"swift") != nil {
//    print("exists")
//}

//split string and find table with specified departments
//var splitStringArray = Array<String>();


//let superIndex = myHTMLString.index(myHTMLString.startIndex, offsetBy: myHTMLString.characters.count - 1) //will call succ 2 times
//var priorString = String()
//let superLastChar: Character = myHTMLString[superIndex]
//print(superLastChar)
//
//priorString = myHTMLString.components(separatedBy: "pre").first!
//let SuperLastChar: Character = priorString[priorString.startIndex]
//print(priorString.endIndex)
//

//var postString = myHTMLString.substringFromIndex()
//    //fullName.characters.split{$0 == " "}.map(String.init)
