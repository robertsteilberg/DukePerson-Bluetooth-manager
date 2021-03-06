//
//  RitwikAnimationViewController.swift
//  ECE564_F17_HOMEWORK
//
//  Created by The Ritler on 9/24/17.
//  Copyright © 2017 ece564. All rights reserved.
//

import UIKit

class RitwikAnimationViewController: UIViewController {
    
    // MARK: Properties
    
    var escapeButton =  UIButton()
    var timeCounter = 0
    var goomba = UIImageView()
    var mushroom = UIImageView()
    var bowser = UIImageView()
    var fireBall = UIImageView()
    let frameLenght = 1.0
    var backgroundColor: UIView!
    var background: MarioBackground!
    var ItemBox = UIImageView()
    var time: Double{
        get {
            let time: Double = Double(timeCounter) * frameLenght
            timeCounter += 1
            return time
        }
        set {
        }
    }
    var mario = UIImageView()
    
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addImage(imageView: mario, x: 110, y: 296, width: 100, height: 128, image: #imageLiteral(resourceName: "Mario"))
        addImage(imageView: ItemBox, x: 110, y: 108, width: 100, height: 89, image: #imageLiteral(resourceName: "MysteryBox"))
        mario.alpha = 1
        ItemBox.alpha = 1
        escapeButton.alpha = 1
        background = MarioBackground(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundColor = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/2 + 115))
        backgroundColor.backgroundColor = .red
        self.view.addSubview(backgroundColor)
        self.view.addSubview(background)
        self.view.bringSubview(toFront: escapeButton)
        addView(view: mario)
        addView(view: ItemBox)
        addEscape()
        playMusic()
        animate()
        
    }
    
    func addEscape(){
        escapeButton.frame = CGRect(x: 270, y: 23, width: 40, height: 40)
        escapeButton.setImage(#imageLiteral(resourceName: "x"), for: .normal)
        escapeButton.addTarget(self, action: #selector(escapeAction), for: .touchUpInside)
        self.view.addSubview(escapeButton)
        self.view.bringSubview(toFront: escapeButton)
    }
    
    @objc func escapeAction(_ sender: Any) {
        playMusic()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func addImage(imageView: UIImageView, x: Int, y: Int, width: Int, height: Int, image: UIImage){
        imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        imageView.image = image
    }
    
    func addView(view: UIView){
        self.view.addSubview(view)
        self.view.bringSubview(toFront: view)
    }
    
    func playMusic() {
        MusicPlayer.sharedHelper.playBackgroundMusic(songName: "Mario")
    }
    
    func goombaAttack() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.goomba.center = CGPoint(x: self.mario.center.x + self.view.frame.maxX/4 , y: self.mario.center.y )
            
        }, completion: nil)
        
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.goomba.center = self.mario.center
            
        }, completion: nil)
    }
    
    func marioShrink() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.goomba.alpha = 0.0
            self.mario.bounds = CGRect(x: self.mario.bounds.minX, y:self.mario.bounds.minY , width: self.mario.bounds.width/1.5
                , height: self.mario.bounds.height/1.5)
            
        }, completion: nil)
    }
    
    func marioJump() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.mario.center = CGPoint.init(x: self.mario.center.x, y: self.mario.center.y - 130)
            
        }, completion: nil)
    }
    
    func marioFall() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.mushroom.alpha = 1.0
            self.mushroom.center = CGPoint.init(x: self.mushroom.center.x, y: self.mushroom.center.y - 100)
            self.mario.center = CGPoint.init(x: self.mario.center.x, y: self.mario.center.y + 130)
            
        }, completion: nil)
    }
    
    func mushroomFall() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.mushroom.center = CGPoint(x: self.mario.center.x , y: self.mario.center.y/1.5 )
        }, completion: nil)
    }
    
    func eatMushroom() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.mario.center = CGPoint.init(x: self.mario.center.x, y: self.mario.center.y - 10)
            self.mushroom.center = CGPoint(x: self.mario.center.x , y: self.mario.center.y )
            self.mushroom.bounds = CGRect(x: self.mushroom.bounds.minX, y:self.mushroom.bounds.minY , width: self.mushroom.bounds.width*0.000000001
                , height: self.mario.bounds.height*0.000000001)
            self.mario.bounds = CGRect(x: self.mario.bounds.minX, y:self.mario.bounds.minY , width: self.mario.bounds.width*1.5
                , height: self.mario.bounds.height*1.5)
            
        }, completion: nil)
    }
    
    func bowserArrives() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.bowser.center = CGPoint(x: self.view.center.x*1.5 , y: self.mario.center.y - 20)
            
            self.fireBall.center = CGPoint(x: self.view.center.x + 10 , y: self.fireBall.center.y)
            
            self.mario.center = CGPoint(x: self.view.center.x/2 , y: self.mario.center.y )
            
        }, completion: nil)
    }
    
    func throwFireBall() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.fireBall.alpha = 1.0
            
            self.fireBall.center = CGPoint(x: self.view.center.x - 50 , y: self.fireBall.center.y)
            
        }, completion: nil)
    }
    
    func marioDies() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {
            
            self.fireBall.bounds = CGRect(x: self.fireBall.bounds.minX, y:self.fireBall.bounds.minY , width: self.fireBall.bounds.width*0.000000001
                , height: self.fireBall.bounds.height*0.000000001)
            
            self.mario.transform = self.mario.transform.rotated(by: CGFloat(-Double.pi))
            
            self.mario.center = CGPoint(x: self.view.center.x/2 , y: self.mario.center.y  + 30)
        }, completion: nil)
    }
    
    func gameOverText() {
        UIView.animate(withDuration: frameLenght, delay: time, options: .curveEaseOut, animations: {}, completion: nil)
    }
    
    func animate() {
        fireBall.contentMode = .scaleAspectFit
        goomba.contentMode = .scaleAspectFill
        mushroom.contentMode = .scaleAspectFill
        bowser.contentMode = .scaleAspectFill
        
        goomba.frame = CGRect(x: self.view.frame.maxX, y: mario.frame.minY , width: mario.frame.width, height: mario.frame.height)
        mushroom.frame = ItemBox.frame
        bowser.frame = CGRect(x: self.view.frame.maxX + 30, y: mario.frame.minY - 50, width: mario.frame.width * 1.5, height: mario.frame.height * 1.5)
        fireBall.frame = CGRect(x: self.view.frame.maxX + 15, y: bowser.frame.minY, width: mario.frame.width , height: mario.frame.height )
        
        self.view.addSubview(mushroom)
        self.view.addSubview(goomba)
        self.view.addSubview(bowser)
        self.view.addSubview(fireBall)
        self.view.bringSubview(toFront: mario)
        self.view.bringSubview(toFront: ItemBox)
        
        bowser.image = #imageLiteral(resourceName: "Bowser")
        goomba.image = #imageLiteral(resourceName: "Goomba")
        mushroom.image = #imageLiteral(resourceName: "Mushroom")
        fireBall.image = #imageLiteral(resourceName: "FireBall")
        
        self.goomba.bounds = CGRect(x: self.goomba.bounds.minX, y:self.goomba.bounds.minY , width: self.goomba.bounds.width/1.5
            , height: self.goomba.bounds.height/1.5)
        mushroom.alpha = 0.0
        fireBall.alpha = 0.0
        goomba.isHidden = false
        goombaAttack()
        marioShrink()
        marioJump()
        marioFall()
        mushroomFall()
        eatMushroom()
        bowserArrives()
        throwFireBall()
        marioDies()
        gameOverText()
    }
    
}
