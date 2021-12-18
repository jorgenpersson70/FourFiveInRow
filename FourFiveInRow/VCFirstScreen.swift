//
//  VCFirstScreen.swift
//  FourFiveInRow
//
//  Created by jörgen persson on 2021-12-10.
//

import UIKit

class VCFirstScreen: UIViewController {
    
    var imageString : String?
    var width = 0.0
    var height = 0.0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
       
        width = UIScreen.main.bounds.size.width
        print(width)
        height = UIScreen.main.bounds.size.height
        print(height)
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        width = UIScreen.main.bounds.size.width
        if (width > 740){
            performSegue(withIdentifier: "ipad", sender: 1)
        }
        else
        {   // it was strange, my iphone 7 said it had 320 in width
            if (width > 320){
                performSegue(withIdentifier: "iphone", sender: 2)
            }
            else{
                print("width")

//                print("Sorry, you cannot play this game on screen size 320*568. It requires at least 375*667")
                performSegue(withIdentifier: "reallysmall", sender: 3)
            }
        }
  
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.updateCounting()
        })
    }
    
    func updateCounting(){
        var width = 0.0
        
        width = UIScreen.main.bounds.size.width
        if (width > 740){
            performSegue(withIdentifier: "ipad", sender: 1)
        }
        else
        {   // it was strange, my iphone 7 said it had 320 in width
            if (width > 320){
                performSegue(withIdentifier: "iphone", sender: 2)
            }
            else{
                print("width")
//                print("Sorry, you cannot play this game on screen size 320*568. It requires at least 375*667")
                performSegue(withIdentifier: "reallysmall", sender: 3)
            }
        }
        timer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "iphone"){
            let dest = segue.destination as! ViewController
        }
        
        if (segue.identifier == "ipad"){
            let dest = segue.destination as! VCLargerScreen
        }
        
        if (segue.identifier == "reallysmall"){
            let dest = segue.destination as! VCReallySmall
        }
    }

}
