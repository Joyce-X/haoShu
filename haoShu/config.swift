//
//  config.swift
//  haoShu
//
//  Created by x on 17/7/12.
//  Copyright © 2017年 cesiumai. All rights reserved.
//

import UIKit


let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCEREEN_HEIGHT = UIScreen.main.bounds.size.height

let MY_FONT = "Bauhaus ITC"

let MAIN_RED = UIColor(colorLiteralRed: 235/255, green: 114/255, blue: 118/255, alpha: 1)

func RGB(r: CGFloat,g: CGFloat,b:CGFloat,a:CGFloat = 1) -> UIColor{

    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    

}
