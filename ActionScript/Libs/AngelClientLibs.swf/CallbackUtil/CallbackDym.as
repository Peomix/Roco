package CallbackUtil
{
   public class CallbackDym
   {
      
      public static var s_callbackDymFlag:int;
      
      private static var infoArray:Array = [];
      
      public function CallbackDym()
      {
         super();
      }
      
      public static function init() : void
      {
         if(!infoArray)
         {
            infoArray = null;
         }
      }
      
      public static function dispose() : void
      {
         if(infoArray)
         {
            infoArray.length = 0;
            infoArray = null;
         }
      }
      
      public static function getCallbackDymIndex(param1:String) : int
      {
         var _loc2_:int = int(infoArray.indexOf(param1));
         if(_loc2_ == -1)
         {
            infoArray.push(param1);
            return infoArray.length - 1 | s_callbackDymFlag;
         }
         return _loc2_ | s_callbackDymFlag;
      }
   }
}

