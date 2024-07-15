package DataInfoCenterUtil.decoder
{
   import flash.display.BitmapData;
   
   public class GIFFrame
   {
       
      
      public var bitmapData:BitmapData;
      
      public var delay:int;
      
      public function GIFFrame(param1:BitmapData, param2:int)
      {
         super();
         this.bitmapData = param1;
         this.delay = param2;
      }
   }
}
