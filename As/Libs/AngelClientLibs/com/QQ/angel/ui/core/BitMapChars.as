package com.QQ.angel.ui.core
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitMapChars extends Bitmap
   {
      
      protected static var DEFAULT_SKIN:BitmapData;
       
      
      protected var val:String;
      
      protected var splitw:int;
      
      protected var numsimg:BitmapData;
      
      protected var bits:int;
      
      protected var chars:Dictionary;
      
      protected var drawRect:Rectangle;
      
      protected var charRect:Rectangle;
      
      protected var despos:Point;
      
      public function BitMapChars(param1:int, param2:int = 22, param3:int = 28, param4:String = "auto", param5:Boolean = false)
      {
         this.drawRect = new Rectangle(0,0,param2 * param1,param3);
         super(new BitmapData(this.drawRect.width,this.drawRect.height,true,0),param4,param5);
         this.splitw = param2;
         this.bits = param1;
         this.charRect = new Rectangle(0,0,param2,param3);
         this.despos = new Point();
      }
      
      protected function drawChars(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = param1.length > this.bits ? this.bits : param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = int(this.chars[param1.charAt(_loc3_)]);
            this.charRect.x = _loc4_ * this.splitw;
            this.despos.x = _loc3_ * this.splitw;
            bitmapData.copyPixels(this.numsimg,this.charRect,this.despos,null,null,true);
            _loc3_++;
         }
      }
      
      public function setSkin(param1:BitmapData = null, param2:String = "0123456789x") : void
      {
         if(param1 != null)
         {
            this.numsimg = param1;
         }
         else
         {
            if(DEFAULT_SKIN == null)
            {
               DEFAULT_SKIN = new DefaultNumSkin();
            }
            this.numsimg = DEFAULT_SKIN;
         }
         this.chars = new Dictionary();
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            this.chars[param2.charAt(_loc3_)] = _loc3_;
            _loc3_++;
         }
      }
      
      public function setVale(param1:String) : void
      {
         if(this.chars == null)
         {
            this.setSkin();
         }
         this.val = param1;
         this.bitmapData.lock();
         this.clear();
         this.drawChars(param1);
         this.bitmapData.unlock();
      }
      
      public function set text(param1:String) : void
      {
         this.setVale(param1);
      }
      
      public function getVal() : String
      {
         return this.val;
      }
      
      public function clear() : void
      {
         bitmapData.fillRect(this.drawRect,0);
      }
      
      public function unload(param1:Boolean = true) : void
      {
         if(param1 && this.numsimg != null && this.numsimg != DEFAULT_SKIN)
         {
            this.numsimg.dispose();
         }
         this.numsimg = null;
         if(bitmapData != null)
         {
            bitmapData.dispose();
         }
         bitmapData = null;
         this.chars = null;
      }
   }
}
