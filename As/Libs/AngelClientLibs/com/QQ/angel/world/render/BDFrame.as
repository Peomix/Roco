package com.QQ.angel.world.render
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class BDFrame
   {
       
      
      public var offset:Point;
      
      public var times:int = 1;
      
      public var img:BitmapData;
      
      public var script:ScriptVo;
      
      public var label:String = "";
      
      public function BDFrame()
      {
         super();
      }
      
      public function clone(param1:int = -1) : BDFrame
      {
         var _loc2_:BDFrame = new BDFrame();
         _loc2_.offset = this.offset.clone();
         _loc2_.offset.x = -this.offset.x - this.img.width;
         _loc2_.times = this.times;
         _loc2_.label = this.label;
         var _loc3_:BitmapData = new BitmapData(this.img.width,this.img.height,true,0);
         _loc3_.draw(this.img,new Matrix(-1,0,0,1,_loc3_.width));
         _loc2_.img = _loc3_;
         _loc2_.script = this.script;
         return _loc2_;
      }
   }
}
