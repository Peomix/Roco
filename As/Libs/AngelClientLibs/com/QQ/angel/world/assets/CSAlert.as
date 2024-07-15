package com.QQ.angel.world.assets
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.world.assets.CSAlert")]
   public dynamic class CSAlert extends MovieClip
   {
       
      
      public var okBtn:SimpleButton;
      
      public var msgTxt:TextField;
      
      public var closeBtn:SimpleButton;
      
      public function CSAlert()
      {
         super();
      }
   }
}
