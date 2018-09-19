//
//  ViewController.swift
//  musicserenade
//
//  Created by Isaac Lee on 9/13/18.
//  Copyright © 2018 IsaacLee. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var swipeLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(gestureRecognizer:)))
        swipeLabel.addGestureRecognizer(gesture)
        //lets label get recognized
    }
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let labelPoint = gestureRecognizer.translation(in: view)
        swipeLabel.center = CGPoint(x: view.bounds.width / 2 + labelPoint.x, y: view.bounds.height / 2 + labelPoint.y)
        //moves label around screen
        
        let xFromCenter = view.bounds.width / 2 - swipeLabel.center.x
        
        
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 100)
        
        let scale = min(100 / abs(xFromCenter), 1) //variable created to consistently change size of label when swiped, 1 is used as maximum to prevent problems
        
        var scaledAndRotaded = rotation.scaledBy(x: scale, y: scale) //changes size of scale
        
        swipeLabel.transform = scaledAndRotaded
        
        //rotates when swiping swipelabel
       
        
        if gestureRecognizer.state == .ended {
            if swipeLabel.center.x < (view.bounds.width / 2 - 100) {
                print("Not interested")
            }
            if swipeLabel.center.x > (view.bounds.width / 2 + 100) {
                print("Interested")
            }
            
            rotation = CGAffineTransform(rotationAngle:0)
            
            scaledAndRotaded = rotation.scaledBy(x:1, y:1)
            
            swipeLabel.transform = scaledAndRotaded
            
            swipeLabel.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2)
            //puts label into center
        }
      
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

