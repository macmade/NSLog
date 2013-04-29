/*******************************************************************************
 * Copyright (c) 2010, Jean-David Gadina - www.xs-labs.com
 * Distributed under the Boost Software License, Version 1.0.
 * 
 * Boost Software License - Version 1.0 - August 17th, 2003
 * 
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ******************************************************************************/

/* $Id$ */

#import "MessageCell.h"
#import "ASLMessage.h"

NSString * const MessageCellID = @"MessageCellID";

@interface MessageCell( Private )

- ( void )updateCellInfos;

@end

@implementation MessageCell( Private )

- ( void )updateCellInfos
{
    NSDateFormatter * formatter;
    
    formatter = [ NSDateFormatter new ];
    
    [ formatter setTimeStyle: NSDateFormatterMediumStyle ];
    [ formatter setDateStyle: NSDateFormatterMediumStyle ];
    
    self.textLabel.text                 = _message.sender;
    self.detailTextLabel.text           = _message.message;
    self.additionalDetailTextLabel.text = [ formatter stringFromDate: _message.time ];
    
    [ formatter release ];
    
    switch( _message.level )
    {
        case ASLMessageLevelAlert:
            
            self.imageView.image = [ UIImage imageNamed: @"level-alert.png" ];
            break;
            
        case ASLMessageLevelCritical:
            
            self.imageView.image = [ UIImage imageNamed: @"level-critical.png" ];
            break;
            
        case ASLMessageLevelDebug:
            
            self.imageView.image = [ UIImage imageNamed: @"level-debug.png" ];
            break;
            
        case ASLMessageLevelEmergency:
            
            self.imageView.image = [ UIImage imageNamed: @"level-emergency.png" ];
            break;
            
        case ASLMessageLevelError:
            
            self.imageView.image = [ UIImage imageNamed: @"level-error.png" ];
            break;
            
        case ASLMessageLevelInfo:
            
            self.imageView.image = [ UIImage imageNamed: @"level-info.png" ];
            break;
            
        case ASLMessageLevelNotice:
            
            self.imageView.image = [ UIImage imageNamed: @"level-notice.png" ];
            break;
            
        case ASLMessageLevelWarning:
            
            self.imageView.image = [ UIImage imageNamed: @"level-warning.png" ];
            break;
            
        default:
            
            self.imageView.image = [ UIImage imageNamed: @"level-unknown.png" ];
            break;
    }
}

@end

@implementation MessageCell

@synthesize additionalDetailTextLabel = _additionalDetailTextLabel;

- ( id )init
{
    UIView * backgroundView;
    
    if( ( self = [ self initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: MessageCellID ] ) )
    {
        backgroundView                      = [ [ UIView alloc ] initWithFrame: CGRectZero ];
        backgroundView.backgroundColor      = [ UIColor whiteColor ];
        self.backgroundView                 = backgroundView;
        self.backgroundView.backgroundColor = [ UIColor colorWithPatternImage: [ UIImage imageNamed: @"cell-background-normal.png" ] ];
        
        [ backgroundView release ];
        
        self.detailTextLabel.font            = [ UIFont boldSystemFontOfSize: [ UIFont smallSystemFontSize ] ];
        self.textLabel.font                  = [ UIFont systemFontOfSize: [ UIFont smallSystemFontSize ] ];
        self.detailTextLabel.textColor       = [ UIColor darkGrayColor ];
        self.textLabel.textColor             = [ UIColor colorWithHue: ( CGFloat )0.575 saturation: ( CGFloat )0.5 brightness: ( CGFloat )0.75 alpha: ( CGFloat )1 ];
        self.detailTextLabel.backgroundColor = [ UIColor clearColor ];
        self.textLabel.backgroundColor       = [ UIColor clearColor ];
        self.accessoryType                   = UITableViewCellAccessoryDisclosureIndicator;
        
        _additionalDetailTextLabel                  = [ [ UILabel alloc ] initWithFrame: CGRectZero ];
        _additionalDetailTextLabel.font             = self.textLabel.font;
        _additionalDetailTextLabel.backgroundColor  = self.textLabel.backgroundColor;
        _additionalDetailTextLabel.textColor        = [ UIColor lightGrayColor ];
        
        [ self.contentView addSubview: _additionalDetailTextLabel ];
        [ _additionalDetailTextLabel release ];
    }
    
    return self;
}

- ( void )dealloc
{
    [ _message release ];
    
    [ super dealloc ];
}

- ( void )layoutSubviews
{
    [ super layoutSubviews ];
    
    self.textLabel.frame = CGRectMake
    (
        self.textLabel.frame.origin.x,
        5,
        self.textLabel.frame.size.width,
        self.textLabel.frame.size.height
    );
    
    self.detailTextLabel.frame = CGRectMake
    (
        self.detailTextLabel.frame.origin.x,
        20,
        self.detailTextLabel.frame.size.width,
        self.detailTextLabel.frame.size.height
    );
    
    self.additionalDetailTextLabel.frame = CGRectMake
    (
        self.detailTextLabel.frame.origin.x,
        35,
        5000,
        self.detailTextLabel.frame.size.height
    );
}

- ( ASLMessage * )message
{
    @synchronized( self )
    {
        return _message;
    }
}

- ( void )setMessage: ( ASLMessage * )message
{
    @synchronized( self )
    {
        [ _message release ];
        
        _message = [ message retain ];
        
        [ self updateCellInfos ];
    }
}

- ( BOOL )alternate
{
    @synchronized( self )
    {
        return _alternate;
    }
}

- ( void )setAlternate: ( BOOL )alternate
{
    @synchronized( self )
    {
        _alternate = alternate;
        
        if( _alternate == YES )
        {
            self.backgroundView.backgroundColor = [ UIColor colorWithPatternImage: [ UIImage imageNamed: @"cell-background-alternate.png" ] ];
        }
        else
        {
            self.backgroundView.backgroundColor = [ UIColor colorWithPatternImage: [ UIImage imageNamed: @"cell-background-normal.png" ] ];
        }
    }
}

@end
