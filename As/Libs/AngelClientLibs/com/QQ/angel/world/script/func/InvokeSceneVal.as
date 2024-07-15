package com.QQ.angel.world.script.func
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.world.scene.ISceneAdapter;
   import com.QQ.angel.world.scene.ISceneData;
   import com.QQ.angel.world.script.IInvokeFunc;
   
   public class InvokeSceneVal implements IInvokeFunc
   {
       
      
      public function InvokeSceneVal()
      {
         super();
      }
      
      public function setGlobal(param1:Object) : void
      {
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         var _loc3_:ISceneAdapter = __global.SysAPI.getWorldAPI().getSceneAPI() as ISceneAdapter;
         if(_loc3_ == null)
         {
            param2(0);
            return;
         }
         var _loc4_:ISceneData;
         if((_loc4_ = _loc3_.getSceneData()) == null)
         {
            param2(0);
            return;
         }
         var _loc5_:Array = param1.split("|");
         var _loc6_:int = int(_loc5_[0]);
         switch(_loc6_)
         {
            case 0:
               param2(_loc4_.getSceneCache(_loc5_[1]) as int);
               break;
            case 1:
               param2(_loc4_.getGlobalCache(_loc5_[1]) as int);
               break;
            case 2:
               param2(_loc4_.getDailyValue(_loc5_[1]) as int);
               break;
            case 3:
               param2(_loc4_.getRemoteValue(_loc5_[1]));
               break;
            case 4:
               param2(_loc4_.getLocalValue(_loc5_[1]) as int);
               break;
            case 5:
               param2(_loc4_.getLocalValue(_loc5_[1],true) as int);
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
