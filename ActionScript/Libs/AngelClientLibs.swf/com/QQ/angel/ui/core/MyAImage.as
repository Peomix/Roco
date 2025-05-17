package com.QQ.angel.ui.core
{
   import flash.geom.Point;
   
   public class MyAImage extends AImage
   {
      
      public var data:Object;
      
      public var tooltip:String;
      
      public var tooltipPos:Point = new Point(0,0);
      
      public function MyAImage(param1:Number = 0, param2:Number = 0, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
   }
}

