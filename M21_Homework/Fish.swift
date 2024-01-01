//
//  Fish.swift
//  M21_Homework
//
//  Created by Максим Морозов on 02.01.2024.
//

import Foundation
import UIKit


class Fish {
    var fish: UIImageView
    var isFishCathed: Bool
    
    init (fish: UIImageView, isFishCathed: Bool) {
        self.fish = fish
        self.isFishCathed = false
    }
}
