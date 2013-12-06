//
//  define.h
//  ScrollMe
//
//  Created by Nicolas on 05/12/2013.
//  Copyright (c) 2013 Nicolas. All rights reserved.
//

#ifndef ScrollMe_define_h
#define ScrollMe_define_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define COLOR_GREEN UIColorFromRGB(0x77cc33)
#define COLOR_ORANGE UIColorFromRGB(0xF26847)

#endif
