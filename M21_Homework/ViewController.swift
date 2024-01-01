//
//  ViewController.swift
//  M21_Homework
//
//  Created by Maxim Nikolaev on 15.02.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var fishes = [Fish]()
    private let valueFish = 5
    private var valueFishCatched = 0
    
    private lazy var labelFish: UILabel = {
       let label = UILabel()
        label.text = "Поймано рыб: \(valueFishCatched)"
        label.textColor = .black
        return label
    }()
    
    private lazy var buttonReset : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Сброс", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstaints()
        setFish()
       
    }
    
    private func setupConstaints() {
        labelFish.snp.makeConstraints { make in
            make.right.equalTo(view.snp.rightMargin).offset(-20)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-20)
            make.left.equalTo(view.snp.centerX)
            make.height.equalTo(40)
        }
        buttonReset.snp.makeConstraints { make in
            make.left.equalTo(view.snp.leftMargin).offset(20)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-20)
            make.right.equalTo(view.snp.centerX)
            make.height.equalTo(40)
        }
    }
    
    private func setupViews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        
        view.addSubview(labelFish)
        view.addSubview(buttonReset)
    }
    
    
    private func setFish () {
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
    
    
    private func moveLeft(fish: Fish) {
        if fish.isFishCathed { return }
          UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
            let randomX = Int.random(in: 0..<Int(self.view.frame.width))
            let randomY = Int.random(in: 0..<Int(self.view.frame.height))
            fish.fish.center = CGPoint(x: randomX, y: randomY)
          }, completion: { finished in
            self.moveRight(fish: fish)
          })
    }
    
    
    private func moveRight(fish: Fish) {
        if fish.isFishCathed { return }
            UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut , .allowUserInteraction],animations: {
                let randomX = Int.random(in: 0..<Int(self.view.frame.width))
                let randomY = Int.random(in: 0..<Int(self.view.frame.height))
                fish.fish.center = CGPoint(x: randomX, y: randomY)
            }, completion: { finished in
                self.moveTop(fish: fish)
            })
    }
    
    private func moveTop(fish: Fish) {
        if fish.isFishCathed { return }
            UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
                let randomX = Int.random(in: 0..<Int(self.view.frame.width))
                let randomY = Int.random(in: 0..<Int(self.view.frame.height))
                fish.fish.center = CGPoint(x: randomX, y: randomY)
            }, completion: { finished in
                self.moveBottom(fish: fish)
            })
    }
    
    private func moveBottom(fish: Fish) {
        if fish.isFishCathed { return }
            UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveEaseInOut , .allowUserInteraction], animations: {
                let randomX = Int.random(in: 0..<Int(self.view.frame.width))
                let randomY = Int.random(in: 0..<Int(self.view.frame.height))
                fish.fish.center = CGPoint(x: randomX, y: randomY)
            }, completion: { finished in
                self.moveLeft(fish: fish)
            })
    }
    
    
    
    @objc private func resetGame () {
        if valueFishCatched == 5 {
            setFish()
            valueFishCatched = 0
            labelFish.text = "Поймано рыб: \(valueFishCatched)"
            print("Все рыбы пойманы!")
        } else {
            print("Не все рыбы пойманы!")
        }
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        for fish in 0..<fishes.count {
            let tapLocation = gesture.location(in: fishes[fish].fish.superview)
            if (fishes[fish].fish.layer.presentation()?.frame.contains(tapLocation))! {
                if fishes[fish].isFishCathed { return }
                fishes[fish].isFishCathed = true
                fishCatchedAnimation(fishes[fish].fish)
            }
        }
    }
    
    private func fishCatchedAnimation(_ fish: UIImageView) {
        fish.removeFromSuperview()
        self.valueFishCatched += 1
        print("Пойманно рыб: \(self.valueFishCatched)")
        self.labelFish.text = "Поймано рыб: \(self.valueFishCatched)"
    }
}

