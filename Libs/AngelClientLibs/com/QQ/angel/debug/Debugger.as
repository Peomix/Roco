package com.QQ.angel.debug
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class Debugger
   {
      
      private static var ms_container:DisplayObjectContainer;
       
      
      public function Debugger()
      {
         super();
      }
      
      public static function get container() : DisplayObjectContainer
      {
         return ms_container;
      }
      
      public static function initialize(param1:DisplayObjectContainer, param2:Boolean = false) : void
      {
         var _loc3_:Sprite = null;
         var _loc4_:TextField = null;
         if(DEFINE.IS_DEBUG)
         {
            if(param2)
            {
               _loc3_ = new Sprite();
               _loc3_.graphics.beginFill(16711680,0.3);
               _loc3_.graphics.drawRoundRect(0,0,45,18,3,3);
               _loc3_.graphics.endFill();
               (_loc4_ = new TextField()).text = "Debuger";
               _loc4_.textColor = 16777215;
               _loc4_.autoSize = TextFieldAutoSize.LEFT;
               _loc3_.addChild(_loc4_);
               _loc3_.mouseChildren = false;
               _loc3_.cacheAsBitmap = true;
               param1.addChild(_loc3_);
            }
            ms_container = param1;
            UnitTester.initialize();
            CmdCenter.initialize();
         }
      }
      
      public static function showTips(param1:String) : void
      {
      }
      
      public static function showLog(param1:String) : void
      {
      }
   }
}
