package com.QQ.angel.world.script.func
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.OpenGameDes;
   import com.QQ.angel.world.script.IInvokeFunc;
   
   public class InvokeGame implements IInvokeFunc
   {
       
      
      protected var handler:Function;
      
      protected var minScore:int = 0;
      
      public function InvokeGame()
      {
         super();
      }
      
      public function onGameOver(param1:Object) : void
      {
         if(param1 != null && param1.score > this.minScore)
         {
            this.handler(1);
         }
         else
         {
            this.handler(0);
         }
      }
      
      public function setGlobal(param1:Object) : void
      {
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         this.handler = param2;
         var _loc3_:OpenGameDes = new OpenGameDes();
         _loc3_.handler = new CFunction(this.onGameOver,this);
         var _loc4_:Array = param1.split("|");
         _loc3_.gameType = int(_loc4_[0]);
         _loc3_.gameName = _loc4_[1];
         _loc3_.gameID = int(_loc4_[2]);
         this.minScore = int(_loc4_[3]);
         _loc3_.gameParms = _loc4_[4];
         __global.openGame(_loc3_);
      }
      
      public function dispose() : void
      {
         this.handler = null;
      }
   }
}
