//
//  ViewController.swift
//  M21_Homework
//
//  Created by Maxim Nikolaev on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {

    var fishes = [Fish]()
    let valueFish = 5
    var valueFishCatched = 0
    
    lazy var labelFish: UILabel = {
       let label = UILabel()
        label.text = " Поймано рыб: \(valueFishCatched)"
        label.textColor = .green
        label.backgroundColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var buttonReset : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 40, y: 780, width: 50, height: 20)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setTitle("reset", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        
        view.addSubview(labelFish)
        view.addSubview(buttonReset)
        
        setFish()
       
    }
    
    func setFish () {
        for _ in 0 ..< valueFish {
            let newFish:Fish = Fish(fish: UIImageView(image: UIImage(named: "fish")!), isFishCathed: false)
            newFish.fish.frame = CGRect( x: Int.random(in: 45 ... 300), y: Int.random(in: 70 ... 700), width: 100, height: 100)
            newFish.fish.alpha = 1.0
            newFish.fish.contentMode = .scaleAspectFit
            fishes.append(newFish)
            view.addSubview(newFish.fish)
            switch Int.random(in: 1...4) {
                case 1: moveLeft(fish: newFish)
                case 2: moveRight(fish: newFish)
                case 3: moveTop(fish: newFish)
                default: moveBottom(fish: newFish)
            }
        }
    }
    
    
    func moveLeft(fish: Fish) {
        if fish.isFishCathed { return }
      
      UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
        let randomX = Int.random(in: 0..<Int(self.view.frame.width))
        let randomY = Int.random(in: 0..<Int(self.view.frame.height))
        fish.fish.center = CGPoint(x: randomX, y: randomY)
      }, completion: { finished in
        print("fish moved left!")
        self.moveRight(fish: fish)
      })
    }
    
    
    func moveRight(fish: Fish) {
        if fish.isFishCathed { return }
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut , .allowUserInteraction],animations: {
            let randomX = Int.random(in: 0..<Int(self.view.frame.width))
            let randomY = Int.random(in: 0..<Int(self.view.frame.height))
            fish.fish.center = CGPoint(x: randomX, y: randomY)
        }, completion: { finished in
            print("fish moved right!")
            self.moveTop(fish: fish)
        })
    }
    
    func moveTop(fish: Fish) {
        if fish.isFishCathed { return }
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            let randomX = Int.random(in: 0..<Int(self.view.frame.width))
            let randomY = Int.random(in: 0..<Int(self.view.frame.height))
            fish.fish.center = CGPoint(x: randomX, y: randomY)
        }, completion: { finished in
            print("fish moved top!")
            self.moveBottom(fish: fish)
        })
    }
    
    func moveBottom(fish: Fish) {
        if fish.isFishCathed { return }
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            let randomX = Int.random(in: 0..<Int(self.view.frame.width))
            let randomY = Int.random(in: 0..<Int(self.view.frame.height))
            fish.fish.center = CGPoint(x: randomX, y: randomY)
        }, completion: { finished in
            print("fish moved bottom!")
            self.moveLeft(fish: fish)
        })
    }
    
    
    
    @objc func resetGame () {
        if valueFishCatched == 5 {
            setFish()
            valueFishCatched = 0
            print("Все рыбы пойманы!")
        } else {
            print("Продалжаем играть!")
        }
    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        for fish in 0..<fishes.count {
            let tapLocation = gesture.location(in: fishes[fish].fish.superview)
            if (fishes[fish].fish.layer.presentation()?.frame.contains(tapLocation))! {
                print("fish tapped!")
                if fishes[fish].isFishCathed { return }
                fishes[fish].isFishCathed = true
                fishCatchedAnimation(fishes[fish].fish)
            }
        }
    }
    
    func fishCatchedAnimation(_ fish: UIImageView) {
        fish.removeFromSuperview()
        self.valueFishCatched += 1
        print("Пойманно рыб: \(self.valueFishCatched)")
        self.labelFish.text = "Поймано рыб: \(self.valueFishCatched)"
    }
}

