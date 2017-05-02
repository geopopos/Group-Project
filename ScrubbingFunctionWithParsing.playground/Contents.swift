// ScrubbingFunctionWithParsing.playground
import UIKit
import Foundation

extension String { // Extends String with a useful function
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
}

let year = "17" // Choose year and semester
let semester = "SP"
//"AMS ANT ART BIO BLS BUS CHE CHN CSI DAN ECN EDU ELL ENG ENV FRS GEN GRS GRW HIS HMN HPS ILC INM MAT MUS PED PHL PHY POL PSY SOC THE"
let deptString = "PSY" // List any departments here, separate them with spaces
let myURLString = "https://admin.washcoll.edu/schedules/"+year+semester+"schedules.html" // Create url to grab courses from
let myURL = NSURL(string: myURLString)
var myHTMLString = try String(contentsOf: myURL! as URL) // Create a string with the contents of the URL (page source)


var deptStringArray = deptString.components(separatedBy: " ") // Add department names to array
var indexArray = Array<[String.Index]>() // Create array to store the indexes of where each department name appears
let recommended = myHTMLString.indexes(of: "recommended") // Save the index of the recommended string, where the schedule ends

for x in 0...deptStringArray.count-1 { // Add a space to each department name then append the indexes where the names appear
    deptStringArray[x] = deptStringArray[x] + " "
    indexArray.append(myHTMLString.indexes(of: deptStringArray[x]))
}

// The following function takes an index and size(int) and returns string to print -> returns all useful info about class
private func getClassInfo(at Index: String.Index, size: Int) -> String {
    var string = String() // The string where we want to store our characters following the given index
    
    for var x in 0...size { // For however long we wish to make the string, iterate for each string character
        if myHTMLString.index(Index, offsetBy: x) < recommended[0] { // if current index is before the 'recommended'
            let charAtIndex = myHTMLString[myHTMLString.index(Index, offsetBy: x)] // find character at that index
            
            if charAtIndex == Character("A") { // Avoid adding HTML code like '</A>'
                if myHTMLString[myHTMLString.index(Index, offsetBy: x-1)] != Character("/") {
                    string = string + String(charAtIndex)
                }
            }
            else if charAtIndex == Character("0") && (myHTMLString[myHTMLString.index(Index, offsetBy: x-1)] == Character(" ") || myHTMLString[myHTMLString.index(Index, offsetBy: x-1)] == Character("-")) { // Reformat the way time is displayed
                    string = string + " "
            }
            else if charAtIndex != Character("<") && charAtIndex != Character("/") && charAtIndex != Character(">") && charAtIndex != Character("-") { // Avoid adding special characters
                string = string + String(charAtIndex)
            }
            if string.characters.count == 11 || string.characters.count == 43 { // Add a space here or here if one doesn't exist
                if myHTMLString[myHTMLString.index(Index, offsetBy: x+1)] != Character(" "){
                    string = string + " "
                }
            }
            if string.characters.count == 68 {
                if myHTMLString[myHTMLString.index(Index, offsetBy: x-1)] == Character("M") {
                    string = string + " - "
                }
            }
            if string.characters.count == 2 { // Get rid of strings that start with spaces or 'sp'
                if string == "  " || string == "sp"{
                    string = ""
                    x = size
                }
            }
            if string.characters.count == 5 {  // The string should have the fifth character being a 0,1,2,3,4 if it's a string we desire
                if charAtIndex != Character("0") && charAtIndex != Character("1") && charAtIndex != Character("2") && charAtIndex != Character("3") && charAtIndex != Character("4") {
                    string = ""
                    x = size
                }
            }
        }
    }
    
    if string.indexes(of: "                                 ") != [] || string.indexes(of: "TBA") != []{ // Make sure strings dont have abundant blank space or contain TBA
        string = ""
    }
    
    if string.characters.count > 5 { // Eliminate all small nonsensical strings
        return string
    }
    else{return ""} // If criteria doesn't fit return blank string
}

// Now that we have all the indexes saved and a function that takes an index and returns the string that follows, we can store these strings in an array and print when desired.
var splitStringArray = Array<String>() // Create string array

for x in 0...indexArray.count-1 { // For however many departments we are searching
    if indexArray[x] != [] { // If the department has a class
        let currentIndex : [String.Index] = indexArray[x]
        for x in 0...currentIndex.count-1{ // For as many indexes in current department
            let string = getClassInfo(at: currentIndex[x], size: 93) // Let the string be the first 'size' characters after the given index
            if string != "" { // Only if string isnt empty
                splitStringArray.append(string) // Append string to our string array
            }
        }
    splitStringArray.append("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~") // Divide each departments classes
    }
}


print("") // Schedule Header
print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Schedule  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
print("Dpt Cls Sec Name                            Bld  Rm   Day           Time        Prof")
print("")
// Print our string array

var ArrayMWF = Array<String>()
var ArrayTTH = Array<String>()
var ArrayMW = Array<String>()
var ArrayMF = Array<String>()
var ArrayWF = Array<String>()
var ArrayTH = Array<String>()
var ArrayM = Array<String>()
var ArrayW = Array<String>()
var ArrayF = Array<String>()
var ArrayT = Array<String>()


//for x in 0...splitStringArray.count-1 {
//    if splitStringArray[x].contains(" MWF ") {
//        ArrayMWF.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" TTH ") {
//        ArrayTTH.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" MW ") {
//        ArrayMW.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" MF ") {
//        ArrayMF.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" WF ") {
//        ArrayWF.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" TH ") {
//        ArrayTH.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" M ") {
//        ArrayM.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" W ") {
//        ArrayW.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" F ") {
//        ArrayF.append(splitStringArray[x])
//    }
//    else if splitStringArray[x].contains(" T ") {
//        ArrayT.append(splitStringArray[x])
//    }
//    else {}
//}

for x in 0...splitStringArray.count-1 {print(splitStringArray[x])}