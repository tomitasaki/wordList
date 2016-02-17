//
//  QuestionViewController.swift
//  wordList
//
//  Created by hmlab book pro on 2016/02/12.
//  Copyright © 2016年 hmlab book pro. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionlabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var isAnswered: Bool = false //回答か次か判断
    var wordArray: [AnyObject] = [] //ユーザーデフォルトからとる配列
    var shuffledWordArray: [AnyObject]= []  //シャッフルされた配列
    var nowNumber: Int = 0 //現在の回答数

    let saveData = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
    }

        // viewがあらわれたらこれ
    override func viewWillAppear(animated: Bool) {
        wordArray = saveData.arrayForKey("WORD")
        //問題シャッフル
        shuffle()
        questionlabel.text = shuffledWordArray[nowNumber]["english"]as? String
    
    }
    
    func shuffle(){
        while wordArray.count > 0{
            let index = Int(rand()) % wordArray.count
            shuffledWordArray.append(wordArray[index])
            wordArray.removeAtIndex(index)
        }
    }
    @IBAction func nextButtonPushed(){
        
        //回答したか
        if isAnswered{
            //次へ
            nowNumber++
            answerLabel.text = ""
            //次の問題提示するか
            if nowNumber < shuffledWordArray.count {
                //次の質問提示
                questionlabel.text = shuffledWordArray[nowNumber]["english"] as? String
                
                isAnswered = false
                
                nextButton.setTitle("答えを表示", forState: UIControlState.Normal)
            }else{
                
                self.performSegueWithIdentifier("toFinishView", sender: nil)
            }
            
        }else{
            answerLabel.text = shuffledWordArray[nowNumber]["japanese"] as? String
            isAnswered = true
            nextButton.setTitle("次へ", forState: UIControlState.Normal)
        }
    }
}