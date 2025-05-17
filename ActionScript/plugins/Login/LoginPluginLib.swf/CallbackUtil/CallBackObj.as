package CallbackUtil
{
   public class CallBackObj
   {
      
      public var obj:Object;
      
      public var func:Function;
      
      public function CallBackObj(param1:Function, param2:Object)
      {
         super();
         this.func = param1;
         this.obj = param2;
      }
      
      public function dispose() : void
      {
         this.func = null;
         this.obj = null;
      }
   }
}

