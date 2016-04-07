//
//  TVContentItem+Create.h
//  MatchMe
//
//  Created by Siyana Slavova on 3/11/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import <TVServices/TVServices.h>

@interface TVContentItem (Create)

+ (TVContentItem *)contentItemWithIdentifier:(NSString *)identifier
                                  imageShape:(TVContentItemImageShape)imageShape
                                   imageName:(NSString *)imageName;

@end
