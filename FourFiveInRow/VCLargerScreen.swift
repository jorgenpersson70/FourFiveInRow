//
//  VCLargerScreen.swift
//  FourFiveInRow
//
//  Created by jörgen persson on 2021-12-10.
//

import UIKit

class VCLargerScreen: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var whosTurnText: UILabel!
    @IBOutlet weak var myTableViewLarge: UICollectionView!
    @IBOutlet weak var TurnShowColorLarge: UILabel!
    @IBOutlet weak var andTheWinnerIsLarge: UILabel!
    @IBOutlet weak var theWinningColorLarge: UILabel!
    @IBOutlet weak var fourInRowButtonTextLarge: UIButton!
    @IBOutlet weak var fiveInRowButtonTextLarge: UIButton!
    @IBOutlet weak var putAnywereLarge: UIButton!
    @IBOutlet weak var putFromBottomLarge: UIButton!
    @IBOutlet weak var beginAgainButtonLarge: UIButton!
    
    let reuseIdentifier = "Cell2" // also enter this string as the cell identifier in the storyboard

    var row0 : [Int] = Array(repeating: 0, count: 17)

    var row1Temp = Array(repeating: 0, count: 17)
    var row2Temp = Array(repeating: 0, count: 17)
    var row3Temp = Array(repeating: 0, count: 17)
    var row4Temp = Array(repeating: 0, count: 17)
    var row5Temp = Array(repeating: 0, count: 17)
    var row6Temp = Array(repeating: 0, count: 17)
    var row7Temp = Array(repeating: 0, count: 17)
    var row8Temp = Array(repeating: 0, count: 17)
    
    var colorColumn0 : [Int] = Array(repeating: 0, count: 9)
    var lastDropRed = Array(repeating: 0, count: 9)
    var lastDropGreen = Array(repeating: 0, count: 9)
    
    var column1Temp = Array(repeating: 0, count: 9)
    var column2Temp = Array(repeating: 0, count: 9)
    var column3Temp = Array(repeating: 0, count: 9)
    var column4Temp = Array(repeating: 0, count: 9)
    var column5Temp = Array(repeating: 0, count: 9)
    var column6Temp = Array(repeating: 0, count: 9)
    var column7Temp = Array(repeating: 0, count: 9)
    var column8Temp = Array(repeating: 0, count: 9)
    var checkForNumbers = 4
    var putAnywereFlag = false
    
    var blockRead = false
    var timer = Timer()
    
    var height = 0.0
    var width = 0.0
    
    let edge    : CGFloat = 10.0
    let spacing : CGFloat = 10.0
    var TurnOnAgain = false
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wood2.png")!)
       
        TurnShowColorLarge.backgroundColor = .green
        andTheWinnerIsLarge.backgroundColor = .clear
        player = 1
        
        fourInRowButtonTextLarge.backgroundColor = .systemPurple
        fiveInRowButtonTextLarge.backgroundColor = UIColor(named: "FourFiveButtonLight")
 
        putFromBottomLarge.backgroundColor = .systemPurple
        putAnywereLarge.backgroundColor = UIColor(named: "FourFiveButtonLight")
    
        beginAgainButtonLarge.backgroundColor = .systemPurple
        
        createArrays()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            self.updateCounting()
        })
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/9, height: collectionViewSize/9)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 5, right: 1)
    }
    
    func createArrays(){
        andTheWinnerIsLarge.text = ""
        theWinningColorLarge.isEnabled = false
        theWinningColorLarge.alpha = 0
        
        row0 = Array(repeating: 0, count: 17)
     
        arrayOfRows.append(row0)
        arrayOfRows.append(row0)
        arrayOfRows.append(row0)
        arrayOfRows.append(row0)
        arrayOfRows.append(row0)
        arrayOfRows.append(row0)
        arrayOfRows.append(row0)
        arrayOfRows.append(row0)
        arrayOfRows.append(row0)
               
        colorColumn0 = Array(repeating: 0, count: 9)
    
        arrayOfColumns.append(colorColumn0)
        arrayOfColumns.append(colorColumn0)
        arrayOfColumns.append(colorColumn0)
        arrayOfColumns.append(colorColumn0)
        arrayOfColumns.append(colorColumn0)
        arrayOfColumns.append(colorColumn0)
        arrayOfColumns.append(colorColumn0)
        arrayOfColumns.append(colorColumn0)
        arrayOfColumns.append(colorColumn0)
        
    }
    
    
    @IBAction func putAnyWereLarge(_ sender: Any) {
        putAnywereLarge.backgroundColor = .systemPurple
        putFromBottomLarge.backgroundColor = UIColor(named: "FourFiveButtonLight")
        putAnywereFlag = true
    }
    
    
    @IBAction func putFromBottomLarge(_ sender: Any) {
        putAnywereLarge.backgroundColor = UIColor(named: "FourFiveButtonLight")
        putFromBottomLarge.backgroundColor = .systemPurple
        putAnywereFlag = false
    }
    
    @IBAction func fourInRowButtonLarge(_ sender: Any) {
        fourInRowButtonTextLarge.backgroundColor = .systemPurple
        fiveInRowButtonTextLarge.backgroundColor = UIColor(named: "FourFiveButtonLight")
        checkForNumbers = 4
        print(player)
    }
    
    @IBAction func fiveInRowButtonLarge(_ sender: Any) {
        fiveInRowButtonTextLarge.backgroundColor = .systemPurple
        fourInRowButtonTextLarge.backgroundColor = UIColor(named: "FourFiveButtonLight")
        checkForNumbers = 5
    }
    
    @IBAction func startNewRoundLarge(_ sender: Any) {
   
        arrayOfRows.removeAll()
        arrayOfColumns.removeAll()
        createArrays()
        
        theWinningColorLarge.isEnabled = false
        theWinningColorLarge.alpha = 0
        andTheWinnerIsLarge.backgroundColor = .clear
        
        myTableViewLarge.reloadData()
    }
    
       
       // tell the collection view how many cells to make
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 64
       }
       
       // make a cell for each cell index path
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           // get a reference to our storyboard cell
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell2
           
           cell.myLabelCell.text = ""
           
           let indexnumer = indexPath.row
           
           // första har 0
           print(indexPath.row)
           let rad = (indexPath.row / 8) + 1
           print("rad \(rad)")
           let column = (indexPath.row % 8) + 1
           print("colum \(column)")
 
           if (arrayOfRows[rad][column] == 1)
           {
               cell.backgroundColor = .green
           }
           if (arrayOfRows[rad][column] == 2)
           {
               cell.backgroundColor = .red
           }
           if (arrayOfRows[rad][column] == 0)
           {
               cell.backgroundColor = .white
           }
           if (arrayOfRows[rad][column] == 3)
           {
               let colorStart = UIColor(red:0.1 , green: 0.2, blue: 0.5, alpha: 1.0)
               let colorEnd = UIColor(red:0.90 , green: 0.40, blue: 0.0, alpha: 0.9)
               cell.backgroundColor = .systemGreen
            }
           if (arrayOfRows[rad][column] == 4)
           {
               let colorStart = UIColor(red:0.1 , green: 0.2, blue: 0.5, alpha: 1.0)
               let colorEnd = UIColor(red:0.90 , green: 0.40, blue: 0.0, alpha: 0.9)
               cell.backgroundColor = .orange
          }
         
           cell.layer.borderWidth = 1
           cell.layer.cornerRadius = 8
           
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("You selected cell #\(indexPath.item)!")
 
            if (theWinningColorLarge.isEnabled){
                return
            }
           
           let cell = collectionView.cellForItem(at: indexPath)
           
           let indexnumer = indexPath.row
           
           // första har 0
           print(indexPath.row)
           let rad = (indexPath.row / 8) + 1
           print("rad \(rad)")
           let column = (indexPath.row % 8) + 1
           print("colum \(column)")
           
           if (cell?.backgroundColor == .white)
           {
               var lastDropGreenPos : Int = 9
               var lastDropRedPos : Int = 9
               var OK : Bool = false
               
               if let lastDropGreen = arrayOfColumns[column].firstIndex(of: 1){
                   print("last green \(lastDropGreen)")
                   lastDropGreenPos = lastDropGreen
               }
               
               if let lastDropRed = arrayOfColumns[column].firstIndex(of: 2){
                   print("last red \(lastDropRed)")
                   lastDropRedPos = lastDropRed
               }
               
               if (lastDropRedPos < lastDropGreenPos){
                   lastDropGreenPos = lastDropRedPos
                   print("rad \(rad)")
                   print("last red \(lastDropRedPos)")
               }
               
               if (putAnywereFlag){
                   OK = true
               }else{
                   if ((lastDropGreenPos-1) == rad){
                       print("hej \(lastDropRed)")
                       OK = true
                   }
               }
               
               if (OK){
               
                   if (TurnShowColorLarge.backgroundColor == .green)
                   {
                       cell?.backgroundColor = .green
                       TurnShowColorLarge.backgroundColor = .red
                       arrayOfRows[rad][column] = 1
                       arrayOfColumns[column][rad] = 1
                   }
                   else
                   {
                       cell?.backgroundColor = .red
                       TurnShowColorLarge.backgroundColor = .green
                       arrayOfRows[rad][column] = 2
                       arrayOfColumns[column][rad] = 2
                   }
               }
           }
           print("The row1:", arrayOfRows[1])
           print("The row1:", arrayOfRows[2])
           print("The row1:", arrayOfRows[3])
           print("The row1:", arrayOfRows[4])
           print("The row1:", arrayOfRows[5])
           print("The row1:", arrayOfRows[6])
           print("The row1:", arrayOfRows[7])
           print("The row8:", arrayOfRows[8])
 
           checkRows()
           checkColumns()
           checkDiagonal1()
           checkDiagonal2()
       }
    
    func updateCounting(){
        
        if UIScreen.main.bounds.height < UIScreen.main.bounds.width {
            var test = theWinningColorLarge.isEnabled
            print("Portrait Views")
            whosTurnText.alpha = 0
            myTableViewLarge.alpha = 0
            TurnShowColorLarge.alpha = 0
            if (test){
                TurnOnAgain = true
                andTheWinnerIsLarge.alpha = 0
                theWinningColorLarge.alpha = 0
            }
            
            fourInRowButtonTextLarge.alpha = 0
            fiveInRowButtonTextLarge.alpha = 0
            putAnywereLarge.alpha = 0
            putFromBottomLarge.alpha = 0
            beginAgainButtonLarge.alpha = 0
        }
        else{
            print("correct Views")
            whosTurnText.alpha = 1
            myTableViewLarge.alpha = 1
            TurnShowColorLarge.alpha = 1
            if (TurnOnAgain){
                andTheWinnerIsLarge.alpha = 1
                theWinningColorLarge.alpha = 1
                TurnOnAgain = false
            }
            
            fourInRowButtonTextLarge.alpha = 1
            fiveInRowButtonTextLarge.alpha = 1
            putAnywereLarge.alpha = 1
            putFromBottomLarge.alpha = 1
            beginAgainButtonLarge.alpha = 1
            
        }
    }
    
    func removeInRow(antal:Int, rad:[Int])->[Int]{
        var rad = rad
        for i in 1...antal{
            rad.remove(at: 0)
        }
        return rad
    }
    
    func insertInRow(antal:Int, rad:[Int])->[Int]{
        var rad = rad
        for i in 1...antal{
            rad.insert(0, at: 0)
        }
        return rad
    }
    
    func copyRowToColumn2(i: Int){
        column1Temp[1] = row1Temp[i]
        column1Temp[2] = row2Temp[i]
        column1Temp[3] = row3Temp[i]
        column1Temp[4] = row4Temp[i]
        column1Temp[5] = row5Temp[i]
        column1Temp[6] = row6Temp[i]
        column1Temp[7] = row7Temp[i]
        column1Temp[8] = row8Temp[i]
    }
    
    func copyRowToTemp(){
        row1Temp = arrayOfRows[1]
        row2Temp = arrayOfRows[2]
        row3Temp = arrayOfRows[3]
        row4Temp = arrayOfRows[4]
        row5Temp = arrayOfRows[5]
        row6Temp = arrayOfRows[6]
        row7Temp = arrayOfRows[7]
        row8Temp = arrayOfRows[8]
    }
    
    func checkDiagonal1(){
        var sameColor = 0
        
        copyRowToTemp()
  
        row2Temp = removeInRow(antal: 1, rad: row2Temp)
        row3Temp = removeInRow(antal: 2, rad: row3Temp)
        row4Temp = removeInRow(antal: 3, rad: row4Temp)
        row5Temp = removeInRow(antal: 4, rad: row5Temp)
        row6Temp = removeInRow(antal: 5, rad: row6Temp)
        row7Temp = removeInRow(antal: 6, rad: row7Temp)
        row8Temp = removeInRow(antal: 7, rad: row8Temp)
        
        print(row1Temp)
        print(row2Temp)
        print(row3Temp)
        print(row4Temp)
        print(row5Temp)
        print(row6Temp)
        print(row7Temp)
        print(row8Temp)
        

        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 1, rowOrColumnNumber: i, start : 1)
        }
   
 
        copyRowToTemp()
        
        row1Temp = Array(repeating: 0, count: 17)
  
        row3Temp = removeInRow(antal: 1, rad: row3Temp)
        row4Temp = removeInRow(antal: 2, rad: row4Temp)
        row5Temp = removeInRow(antal: 3, rad: row5Temp)
        row6Temp = removeInRow(antal: 4, rad: row6Temp)
        row7Temp = removeInRow(antal: 5, rad: row7Temp)
        row8Temp = removeInRow(antal: 6, rad: row8Temp)
        
        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 1, rowOrColumnNumber: i, start : 2)
        }
 
   
       
        copyRowToTemp()
       
        row1Temp = Array(repeating: 0, count: 17)
        row2Temp = Array(repeating: 0, count: 17)
        row4Temp = removeInRow(antal: 1, rad: row4Temp)
        row5Temp = removeInRow(antal: 2, rad: row5Temp)
        row6Temp = removeInRow(antal: 3, rad: row6Temp)
        row7Temp = removeInRow(antal: 4, rad: row7Temp)
        row8Temp = removeInRow(antal: 5, rad: row8Temp)
        
        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 1, rowOrColumnNumber: i, start : 3)
        }

        
        copyRowToTemp()
       
        row1Temp = Array(repeating: 0, count: 17)
        row2Temp = Array(repeating: 0, count: 17)
        row3Temp = Array(repeating: 0, count: 17)
        row5Temp = removeInRow(antal: 1, rad: row5Temp)
        row6Temp = removeInRow(antal: 2, rad: row6Temp)
        row7Temp = removeInRow(antal: 3, rad: row7Temp)
        row8Temp = removeInRow(antal: 4, rad: row8Temp)
        
        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 1, rowOrColumnNumber: i, start : 4)
        }


        copyRowToTemp()

        row1Temp = Array(repeating: 0, count: 17)
        row2Temp = Array(repeating: 0, count: 17)
        row3Temp = Array(repeating: 0, count: 17)
        row4Temp = Array(repeating: 0, count: 17)
        row6Temp = removeInRow(antal: 1, rad: row6Temp)
        row7Temp = removeInRow(antal: 2, rad: row7Temp)
        row8Temp = removeInRow(antal: 3, rad: row8Temp)
        
        print(row1Temp)
        print(row2Temp)
        print(row3Temp)
        print(row4Temp)
        print(row5Temp)
        print(row6Temp)
        print(row7Temp)
        print(row8Temp)
        
        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 1, rowOrColumnNumber: i, start : 5)
        }
    }
   
    
    func checkDiagonal2(){
        var sameColor = 0
        
        copyRowToTemp()

        row2Temp = insertInRow(antal: 1, rad: row2Temp)
        row3Temp = insertInRow(antal: 2, rad: row3Temp)
        row4Temp = insertInRow(antal: 3, rad: row4Temp)
        row5Temp = insertInRow(antal: 4, rad: row5Temp)
        row6Temp = insertInRow(antal: 5, rad: row6Temp)
        row7Temp = insertInRow(antal: 6, rad: row7Temp)
        row8Temp = insertInRow(antal: 7, rad: row8Temp)
        
        print(row1Temp)
        print(row2Temp)
        print(row3Temp)
        print(row4Temp)
        print(row5Temp)
        print(row6Temp)
        print(row7Temp)
        print(row8Temp)

        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 2, rowOrColumnNumber: i, start : 1)
        }
  
        copyRowToTemp()

        row1Temp = Array(repeating: 0, count: 17)
        
        row3Temp = insertInRow(antal: 1, rad: row3Temp)
        row4Temp = insertInRow(antal: 2, rad: row4Temp)
        row5Temp = insertInRow(antal: 3, rad: row5Temp)
        row6Temp = insertInRow(antal: 4, rad: row6Temp)
        row7Temp = insertInRow(antal: 5, rad: row7Temp)
        row8Temp = insertInRow(antal: 6, rad: row8Temp)
        
        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 2, rowOrColumnNumber: i, start : 2)
        }
       
        copyRowToTemp()
       
        row1Temp = Array(repeating: 0, count: 17)
        row2Temp = Array(repeating: 0, count: 17)
        
        row4Temp = insertInRow(antal: 1, rad: row4Temp)
        row5Temp = insertInRow(antal: 2, rad: row5Temp)
        row6Temp = insertInRow(antal: 3, rad: row6Temp)
        row7Temp = insertInRow(antal: 4, rad: row7Temp)
        row8Temp = insertInRow(antal: 5, rad: row8Temp)

        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 2, rowOrColumnNumber: i, start : 3)
        }
   
        copyRowToTemp()
       
        row1Temp = Array(repeating: 0, count: 17)
        row2Temp = Array(repeating: 0, count: 17)
        row3Temp = Array(repeating: 0, count: 17)
        
        row5Temp = insertInRow(antal: 1, rad: row5Temp)
        row6Temp = insertInRow(antal: 2, rad: row6Temp)
        row7Temp = insertInRow(antal: 3, rad: row7Temp)
        row8Temp = insertInRow(antal: 4, rad: row8Temp)
        
        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 2, rowOrColumnNumber: i, start : 4)
        }

        copyRowToTemp()
        
        row1Temp = Array(repeating: 0, count: 17)
        row2Temp = Array(repeating: 0, count: 17)
        row3Temp = Array(repeating: 0, count: 17)
        row4Temp = Array(repeating: 0, count: 17)
        row6Temp = insertInRow(antal: 1, rad: row6Temp)
        row7Temp = insertInRow(antal: 2, rad: row7Temp)
        row8Temp = insertInRow(antal: 3, rad: row8Temp)
        
        for i in 1...8{
            testDiagonal(rad: column1Temp, column: i, diagonalOneOrTwo: 2, rowOrColumnNumber: i, start : 5)
        }
    }
                                          
    func checkRows(){
        print("------rows------")
        for i in 1...8{
            test(rad: arrayOfRows[i], column: 0, copyRowToColumn:false, rowOrColumnNumber:i)
        }
    }
    
    func checkColumns()
    {
        print("------columns------")
        for i in 1...8{
            test(rad: arrayOfColumns[i], column: 9, copyRowToColumn:false, rowOrColumnNumber:i)
        }
    }
    
    func testDiagonal(rad: [Int], column: Int, diagonalOneOrTwo: Int, rowOrColumnNumber : Int, start : Int){
        var inRowRed = 0
        var inRowGreen = 0
        var rad2:[Int] = rad
        var firstGreenInColumn = 0
        var firstRedInColumn = 0
        var firstMark = 0
        var Hole = 0
        var Rest = 0
        
        copyRowToColumn2(i: column)
        rad2 = column1Temp
        
        print("här har vi columntemp \(column1Temp)")
  //      print("Rad \(rad2)")
            for i in 1...8{
                if (rad2[i] == 1){
                    firstRedInColumn = 0
                    if (firstGreenInColumn == 0){
                        firstGreenInColumn = i
                    }
                    inRowGreen += 1

                    if (inRowGreen >= checkForNumbers){
                        print("firstGreenInColumn: \(firstGreenInColumn)")
                        print("i: \(i)")
                        
                        winner(color:"Grön", column: column)
                    }
                }
                else{
                    inRowGreen = 0
                }
                if (rad2[i] == 2){
                    firstGreenInColumn = 0
                    if (firstRedInColumn == 0){
                        firstRedInColumn = i
                    }
                    inRowRed += 1
                   // if (inRowRed > 3){
                    if (inRowRed >= checkForNumbers){
                        print("firstRedInColumn: \(firstRedInColumn)")
                        print("i: \(i)")
                        
                        winner(color:"Röd", column: column)
                    }
                }
                else{
                    inRowRed = 0
                }
        }
    }
    
    
    func test(rad: [Int], column: Int, copyRowToColumn: Bool, rowOrColumnNumber : Int){
        var inRowRed = 0
        var inRowGreen = 0
        var rad2:[Int] = rad
        var firstInRow = 0
        
        print("-------test rad-----")
        print(rad)
       
        if (copyRowToColumn == true){
            copyRowToColumn2(i: column)
            rad2 = column1Temp
            for i in 1...8{
                if (rad2[i] == 1){
                    
                    inRowGreen += 1
 
                    if (inRowGreen >= checkForNumbers){
                        winner(color:"Grön", column: column)
                    }
                }
                else{
                    inRowGreen = 0
                }
                if (rad2[i] == 2){
                    
                    inRowRed += 1
 
                    if (inRowRed >= checkForNumbers){
                        winner(color:"Röd", column: column)
                    }
                }
                else{
                    inRowRed = 0
                }
            }
        }else{
        // Check row and check column will enter here
            // When I check rows then Column enters as value 0, when I check column the Column enters as value 9
        for i in 1...8{
            
            if (inRowRed == 1){
                firstInRow = i
            }
            if (inRowGreen == 1){
                firstInRow = i
            }
            
            if (rad[i] == 1){
                
                inRowGreen += 1
 
                if (inRowGreen >= checkForNumbers){
                    print("First \(firstInRow-1)")
                    print("Last \(i)")
 
                    winner(color:"Grön", column: column)
                }
            }
            else{
                inRowGreen = 0
            }
            if (rad[i] == 2){
                
                inRowRed += 1
 
                if (inRowRed >= checkForNumbers){
                    print("First \(firstInRow-1)")
                    print("Last \(i)")
  
                    winner(color:"Röd", column: column)
                }
            }
            else{
                inRowRed = 0
            }
        }
        }
    }
    
    
    
    func winner(color:String, column: Int){
        print("Vinnare är \(color). \(color) har fått fyra i rad")
 
        if (checkForNumbers == 4){
            if (color == "Grön"){
                playSound(fileName: "grönfyra1")
            }
            else{
                playSound(fileName: "rödfyra1")
            }
            andTheWinnerIsLarge.text = "Vinnare är \(color). \(color) har fått fyra i rad."
        }
        else{
            if (color == "Grön"){
                playSound(fileName: "grönfem1")
            }
            else{
                playSound(fileName: "rödfem1")
            }
            andTheWinnerIsLarge.text = "Vinnare är \(color). \(color) har fått fem i rad."
        }
        theWinningColorLarge.isEnabled = true
        theWinningColorLarge.alpha = 1
        
        andTheWinnerIsLarge.backgroundColor = .systemPurple
        
        if (color == "Grön")
        {
            theWinningColorLarge.backgroundColor = .green
        }
        else
        {
            theWinningColorLarge.backgroundColor = .red
        }
    }
}

