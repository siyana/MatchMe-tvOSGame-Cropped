//
//  TVContentItem+Create.m
//  MatchMe
//
//  Created by Siyana Slavova on 3/11/16.
//  Copyright © 2016 mycompany.MatchMe. All rights reserved.
//

#import "TVContentItem+Create.h"

NSString const * kScheme = @"MatchMePreview";

@implementation TVContentItem (Create)

+ (TVContentItem *)contentItemWithIdentifier:(NSString *)identifier
                                  imageShape:(TVContentItemImageShape)imageShape
                                   imageName:(NSString *)imageName{
    
    NSAssert(identifier != nil, @"Content item identifier cannot be nil.");
    
    TVContentIdentifier *itemID = [[TVContentIdentifier alloc] initWithIdentifier:identifier container:nil];
    TVContentItem *item = [[TVContentItem alloc] initWithContentIdentifier:itemID];
    item.imageShape = imageShape;
    item.imageURL = [self urlForImageWithName:imageName];
    
    NSURL *url = [self fullUrlForLevelIdentifier:identifier];
    item.displayURL = url;
    item.playURL = url;
    
    return item;
}

+ (NSURL *)urlForImageWithName:(NSString *)imageName {
    NSURL *imageUrl = [[NSBundle mainBundle] URLForResource:imageName
                                              withExtension:@"lsr"];
    
    
    return imageUrl;
}

+ (NSURL *)fullUrlForLevelIdentifier:(NSString *)identifier{
    NSArray *components = [identifier componentsSeparatedByString:@"_"];
    NSLog(@"COMPONENTS: %@", components);
    NSString *host = [components firstObject] ?: @"";
    NSString *path = @"";
    if (components.count >= 2) {
        path = components[1];
    }
    NSString *urlString = [NSString stringWithFormat:@"%@://%@/%@",kScheme, host, path];
    return [NSURL URLWithString:urlString];
}

@end
