package com.QQ.angel.ui.core
{
   import com.QQ.angel.ui.filters.FilterFactory;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   
   public class BTNHelp
   {
      
      protected static var FILTERS:Array;
      
      protected var btn:InteractiveObject;
      
      public function BTNHelp(param1:InteractiveObject)
      {
         super();
         this.btn = param1;
      }
      
      public static function setDisplayGray(param1:DisplayObject, param2:Boolean = true) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(FILTERS == null)
         {
            FILTERS = [FilterFactory.createGrayFilter()];
         }
         if(param2)
         {
            param1.filters = null;
            param1.cacheAsBitmap = false;
         }
         else
         {
            param1.filters = FILTERS;
         }
      }
      
      public static function setBTNEnabled(param1:InteractiveObject, param2:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(FILTERS == null)
         {
            FILTERS = [FilterFactory.createGrayFilter()];
         }
         if(param2)
         {
            param1.filters = null;
            param1.cacheAsBitmap = false;
            param1.mouseEnabled = true;
         }
         else
         {
            param1.filters = FILTERS;
            param1.mouseEnabled = false;
         }
      }
      
      public static function clear() : void
      {
         FILTERS = null;
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         setBTNEnabled(this.btn,param1);
      }
   }
}

