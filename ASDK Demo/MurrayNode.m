//
//  MurrayNode.m
//  ASDK Demo
//
//  Created by Kai Schaller on 1/27/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

#import "MurrayNode.h"
#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

static const CGFloat kImageSize = 80;
static const CGFloat kOuterPadding = 16;
static const CGFloat kInnerPadding = 10;

@interface MurrayNode ()

@property (nonatomic) CGSize murraySize;
@property (strong, nonatomic) ASNetworkImageNode *imageNode;
@property (strong, nonatomic) ASTextNode *textNode;
@property (strong, nonatomic) ASDisplayNode *divider;

@end

@implementation MurrayNode

+ (NSArray *)placeholders {
    static NSArray *placeholders = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        placeholders = @[
                         @"Minions ipsum tatata bala tu hana dul sae tatata bala tu butt.",
                         @"Baboiii tulaliloo hahaha bananaaaa bappleees poulet tikka masala tulaliloo la bodaaa potatoooo baboiii tank yuuu! Hahaha uuuhhh gelatooo pepete potatoooo.",
                         @"Gelatooo bananaaaa tank yuuu! Ti aamoo! Me want bananaaa!",
                         @"Tatata bala tu bananaaaa. Butt butt butt uuuhhh bappleees bappleees jeje poopayee me want bananaaa!",
                         @"Ti aamoo! Baboiii. Poopayee po kass po kass daa poulet tikka masala wiiiii butt wiiiii potatoooo po kass.",
                         @"Baboiii underweaaar po kass poopayee la bodaaa para tú. Ti aamoo!",
                         @"underweaaar tank yuuu! Hana dul sae. Poulet tikka masala me want bananaaa! Butt belloo! Bee do bee do bee do uuuhhh jeje. Uuuhhh tank yuuu!",
                         @"Baboiii bee do bee do bee do tulaliloo underweaaar po kass jeje para tú chasy aaaaaah.",
                         @"Jeje tank yuuu! Me want bananaaa! Tulaliloo aaaaaah poopayee para tú gelatooo uuuhhh hana dul sae tank yuuu! Chasy baboiii para tú hahaha baboiii tank yuuu! Hana dul sae chasy jeje potatoooo bee do bee do bee do. Hana dul sae underweaaar uuuhhh tulaliloo.",
                         @"Jeje bee do bee do bee do baboiii poopayee para tú po kass butt para tú la bodaaa.",
                         @"Underweaaar la bodaaa wiiiii aaaaaah jiji tank yuuu! Jiji tulaliloo para tú.",
                         @"Aaaaaah pepete po kass hahaha butt uuuhhh aaaaaah tank yuuu! Jeje wiiiii para tú. Tank yuuu! tatata bala tu daa aaaaaah jiji butt.",
                         @"Potatoooo hana dul sae gelatooo poopayee. Baboiii hahaha ti aamoo!",
                         @"Belloo! Wiiiii me want bananaaa!",
                         @"Para tú. Poopayee me want bananaaa! Tank yuuu! Po kass bee do bee do bee do belloo! Pepete. Jeje underweaaar bappleees tulaliloo hana dul sae. Gelatooo ti aamoo! Wiiiii belloo! Gelatooo chasy poulet tikka masala. Poopayee ti aamoo!",
                         @"Wiiiii jeje tatata bala tu bappleees. Jiji daa belloo! Tulaliloo.",
                         @"Aaaaaah me want bananaaa! Uuuhhh jeje. Tatata bala tu la bodaaa jiji chasy para tú la bodaaa baboiii underweaaar.",
                         @"Butt poopayee me want bananaaa!",
                         @"Para tú gelatooo hana dul sae chasy belloo! Tatata bala tu potatoooo aaaaaah me want bananaaa!",
                         @"Hahaha chasy. Aaaaaah pepete jeje potatoooo. Baboiii tatata bala tu para tú gelatooo hana dul sae gelatooo poopayee baboiii bananaaaa tatata bala tu."
                         ];
    });
    
    return placeholders;
}

- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize {
    CGSize imageSize = CGSizeMake(kImageSize, kImageSize);
    CGSize textSize = [_textNode measure:CGSizeMake(constrainedSize.width - kImageSize - 2 * kOuterPadding - kInnerPadding, constrainedSize.height)];
    
    // Ensure there's room for text.
    CGFloat requiredHeight = MAX(textSize.height, imageSize.height);

    return CGSizeMake(constrainedSize.width, requiredHeight + 2 * kOuterPadding);
}

- (instancetype)initWithMurrayOfSize:(CGSize)size {
    if (!(self = [super init])) {
        return nil;
    }
    
    _murraySize = size;
    
    // Images courtesy of FillMurray.com, with a background color serving as a placholder.
    _imageNode = [[ASNetworkImageNode alloc] init];
    _imageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
    _imageNode.URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.fillmurray.com/%zd/%zd", (NSInteger)roundl(_murraySize.width), (NSInteger)roundl(_murraySize.height)]];
    [self addSubnode:_imageNode];
    
    // Lorem text, courtesy of minionsipsum.com.
    _textNode = [[ASTextNode alloc] init];
    _textNode.attributedString =  [[NSAttributedString alloc] initWithString:[self minionsIpsum] attributes:[self textStyle]];
    [self addSubnode:_textNode];
    
    // Cell divider.
    _divider = [[ASDisplayNode alloc] init];
    _divider.backgroundColor = [UIColor lightGrayColor];
    [self addSubnode:_divider];
    
    return self;
}

- (void)layout {
    CGFloat pixelHeight = 1.0 / [[UIScreen mainScreen] scale];
    _divider.frame = CGRectMake(0, 0, self.calculatedSize.width, pixelHeight);
    _imageNode.frame = CGRectMake(kOuterPadding, kOuterPadding, kImageSize, kImageSize);
    CGSize textSize = _textNode.calculatedSize;
    _textNode.frame = CGRectMake(kOuterPadding + kImageSize + kInnerPadding, kOuterPadding, textSize.width, textSize.height);
}

- (NSString *)minionsIpsum {
    NSArray *placeholders = [MurrayNode placeholders];
    u_int32_t ipsumCount = (u_int32_t)[placeholders count];
    u_int32_t location = arc4random_uniform(ipsumCount);
    u_int32_t length = arc4random_uniform(ipsumCount - location);
    
    NSMutableString *string = [placeholders[location] mutableCopy];
    for (u_int32_t i = location + 1; i < location + length; i++) {
        [string appendString:(i % 2 == 0) ? @"\n" : @" "];
        [string appendString:placeholders[i]];
    }
    
    return string;
}

- (NSDictionary *)textStyle {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.paragraphSpacing = 0.5 * font.lineHeight;
    style.hyphenationFactor = 1;
    
    return @{ NSFontAttributeName: font,
              NSParagraphStyleAttributeName: style };
}

@end
