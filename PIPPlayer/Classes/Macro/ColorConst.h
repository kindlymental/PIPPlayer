//
//  ColorConst.h
//  Music
//
//  Created by U on 2018/12/4.
//  Copyright © 2018年 com.lyl.demo. All rights reserved.
//

#ifndef ColorConst_h
#define ColorConst_h

#define ColorRGBA(r, g, b, a)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ColorRGB(r, g, b)                   ColorRGBA((r), (g), (b), 1.0)

#define CGreen ColorRGB(61, 192, 127)

#endif /* ColorConst_h */
