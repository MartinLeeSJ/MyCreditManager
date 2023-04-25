//
//  main.swift
//  MyCreditManager
//
//  Created by Martin on 2023/04/24.
//

import Foundation


var creditManager = MyCreditManager()

creditManager.run()

struct MyCreditManager {
    var students = [String]()
    
    var credits = [String:[String:String]]()
    
    enum Credits: String, Identifiable {
        case Aplus = "A+"
        case A = "A"
        case Bplus = "B+"
        case B = "B"
        case Cplus = "C+"
        case C = "C"
        case Dplus = "D+"
        case D = "D"
        case F = "F"
        
        var id: Self { self }
        
        var score: Double {
            switch self {
            case .Aplus: return 4.5
            case .A: return 4.0
            case .Bplus: return 3.5
            case .B: return 3.0
            case .Cplus: return 2.5
            case .C: return 2.0
            case .Dplus: return 1.5
            case .D: return 1.0
            case .F: return 0.0
            }
        }
    }
    
    mutating func run() {
        while true {
            printInstruct()
            
            if let input = readLine() {
                if input == "X" {
                    break
                }
                
                
                switch input {
                case "1": addStudent()
                case "2": deleteStudent()
                case "3": addOrEditCredit()
                case "4": deleteCredit()
                case "5": checkCredits()
                default: printSomethingWrong()
                }
            }
        }
    }
    
    func printInstruct() {
        print("원하는 기능을 입력해주세요\n 1:학생추가, 2:학생삭제, 3:성적추가(변경), 4:성적삭제, 5:평점보기, X:종료")
    }
    
    mutating func addStudent() {
        while true {
            print("추가할 학생의 이름을 입력해주세요, 돌아가려면 q를 입력해주세요.\n")
            
            if let input = readLine() {
                if input == "q" {
                    print("\n메뉴로 돌아갑니다.\n")
                    break
                }
                
                if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    print("\n입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                }
                
                guard !students.contains(input) else {
                    print("\n\(input)은 이미 존재하는 학생입니다. 추가하지 않습니다.\n")
                    continue
                }
                
                
                students.append(input)
                credits[input] = [:]
                    
                print("\n\(input)학생을 추가하였습니다.\n")
            }
        }
    }
    
    mutating func deleteStudent() {
        while true {
            print("삭제할 학생의 이름을 입력해주세요, 돌아가려면 q를 입력해주세요.\n")
            
            if let input = readLine() {
                if input == "q" {
                    print("\n메뉴로 돌아갑니다.\n")
                    break
                }
                
                if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    print("\n입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                }
                
                guard students.contains(input) else {
                    print("\n\(input)학생을 찾지 못했습니다.\n")
                    continue
                }
                
                
                students.removeAll { $0  == input}
                credits.removeValue(forKey: input)
                print("\n\(input)학생을 삭제 하였습니다.\n")
            }
        }
    }
    
    mutating func addOrEditCredit() {
        while true {
            print("""
                    성적을 추가할 학생의 이름, 과목이름, 성적(A+,A,F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
                    입력 예) Mickey Swift A+
                    만약에 학생의 성적 중 해당 과목이 존재하면 기존점수가 갱신됩니다.
                    돌아가려면 q를 입력해주세요.
                  
                  """)
            
            if let input = readLine() {
                if input == "q" {
                    print("\n메뉴로 돌아갑니다.\n")
                    break
                }
                
                let inputArr: [String] = input.split(separator: " ").map { String($0) }
                
                guard inputArr.count == 3 else {
                    print("\n입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                }
                    
                let student = inputArr[0]
                let subject = inputArr[1]
                let credit = inputArr[2]
                
                guard students.contains(student) else {
                    print("\n등록되어 있지 않은 학생입니다. 다시 확인해주세요.\n")
                    continue
                }
                
                guard let identifiedCredit = Credits(rawValue: credit) else {
                    print("\n학점 입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                }
                    
                credits[student]?[subject] = identifiedCredit.rawValue
                        
                print("\n\(student)학생의 \(subject)과목의 학점은 \(identifiedCredit.rawValue) 입니다.\n 점수는 \(identifiedCredit.score)입니다.\n")
            }
        }
    }
    
    
    mutating func deleteCredit() {
        while true {
            print("""
                  성적을 삭제할 학생의 이름, 과목이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
                  입력 예) Mickey Swift
                  돌아가려면 q를 입력해주세요.
                  
                  """)
            
            if let input = readLine() {
                if input == "q" {
                    print("\n메뉴로 돌아갑니다.\n")
                    break
                }
                
                let inputArr: [String] = input.split(separator: " ").map { String($0) }
                
                guard inputArr.count == 2 else {
                    print("\n입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                }
                
                let student = inputArr[0]
                let subject = inputArr[1]
                
                guard students.contains(student) else {
                    print("\n\(student)학생을 찾지 못했습니다.\n")
                    continue
                }
                
                guard credits[student]?[subject] != nil else {
                    print("\n\(student)학생은 \(subject)을 수강하지 않았습니다.\n")
                    continue
                }
                
                credits[student]?.removeValue(forKey: subject)
                print("\n\(student)학생의 \(subject)과목의 성적이 삭제되었습니다.\n")
                
            }
            
        }
    }
    
    
    mutating func checkCredits() {
        while true {
            print("평점을 알고싶은 학생의 이름을 입력해주세요.\n돌아가려면 q를 입력해주세요.\n")
            
            if let input = readLine() {
                
                if input == "q" {
                    print("\n메뉴로 돌아갑니다.\n")
                    break
                }
                
                if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    print("\n입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                }
                
                guard students.contains(input) else {
                    print("\n\(input)학생을 찾지 못했습니다.\n")
                    continue
                }
                
                guard let studentCredits = credits[input] else { break }
                
                var sumOfCredits: Double = 0.0
                
                for (subject, credit) in studentCredits {
                    print("\(subject):\(credit)\n")
                    sumOfCredits += Credits(rawValue: credit)?.score ?? 0.0
                }
                
                print("평점 : \(sumOfCredits / Double(studentCredits.count))\n")
                
            }
        }
    }
    
    
    func printSomethingWrong() {
        print("뭔가 입력이 잘못되었습니다.\n1~5사이의 숫자 혹은 X를 입력해주세요.")
    }
    
    
}



