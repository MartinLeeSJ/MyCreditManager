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
                case "3": addCredit()
                case "4": addStudent()
                case "5": addStudent()
                default: printSomethingWrong()
                }
            }
        }
    }
    
    func printInstruct() {
        print("원하는 기능을 입력해주세요\n 1:학생추가,2:학생삭제,3:성적추가(변경),4:성적삭제,5:평점보기,X:종료")
    }
    
    mutating func addStudent() {
        while true {
            print("추가할 학생의 이름을 입력해주세요, 돌아가려면 q를 입력해주세요.\n")
            
            if let input = readLine() {
                if input == "q" {
                    print("메뉴로 돌아갑니다.\n")
                    break
                }
                
                if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                }
                
                if !students.contains(input) {
                    students.append(input)
//                    credits[input] = [:]
                    
                    print("\(input)학생을 추가하였습니다.\n")
                    
                    continue
                } else {
                    print("\(input)은 이미 존재하는 학생입니다. 추가하지 않습니다.\n")
                    continue
                }
            }
        }
    }
    
    mutating func deleteStudent() {
        while true {
            print("삭제할 학생의 이름을 입력해주세요, 돌아가려면 q를 입력해주세요.\n")
            
            if let input = readLine() {
                if input == "q" {
                    print("메뉴로 돌아갑니다.\n")
                    break
                }
                
                if input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                }
                
                if students.contains(input) {
                    students.removeAll { $0  == input}
//                    credits.removeValue(forKey: input)
                    print("\(input)학생을 삭제 하였습니다.\n")
                    
                    continue
                } else {
                    print("\(input)학생을 찾지 못했습니다.\n")
                    continue
                }
            }
        }
    }
    
    mutating func addCredit() {
        while true {
            print("""
                    성적을 추가할 학생의 이름, 과목이름, 성적(A+,A,F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
                    입력 예) Mickey Swift A+
                    만약에 학생의 성적 중 해당 과목이 존재하면 기존점수가 갱신됩니다.
                    돌아가려면 q를 입력해주세요.
                  
                  """)
            
            if let input = readLine() {
                if input == "q" {
                    print("메뉴로 돌아갑니다.\n")
                    break
                }
                
                let inputArr: [String] = input.split(separator: " ").map { String($0) }
                
                if inputArr.count != 3 {
                    print("입력이 잘못되었습니다. 다시 확인해주세요.\n")
                    continue
                } else {
                    print("입력이 잘되었습니다.\n")
                    continue
                }
                
                
            }
        }
    }
    
    
    func printSomethingWrong() {
        print("뭔가 입력이 잘못되었습니다.\n1~5사이의 숫자 혹은 X를 입력해주세요.")
    }
    
    
}



