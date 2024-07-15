package com.QQ.angel.res.adapter
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.utils.CFunction;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class SceneRoleResAdapter
   {
       
      
      private var _resLoadTaskManager:IResLoadTaskManager;
      
      public function SceneRoleResAdapter(param1:IResLoadTaskManager)
      {
         super();
         this._resLoadTaskManager = param1;
      }
      
      public function requestMagic(param1:int, param2:CFunction) : void
      {
         var _loc3_:ResLoadTask = new ResLoadTask();
         _loc3_.context = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loc3_.resType = Constants.SMALL_RES;
         _loc3_.completeHandler = param2;
         _loc3_.paths = [DEFINE.PLUGIN_ROOT + "Effect/res/Magic_" + param1 + ".swf"];
         this._resLoadTaskManager.addLoadTask(_loc3_);
      }
      
      public function requestMagicByUrl(param1:String, param2:CFunction) : void
      {
         var _loc3_:ResLoadTask = new ResLoadTask();
         _loc3_.context = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loc3_.resType = Constants.SMALL_RES;
         _loc3_.completeHandler = param2;
         _loc3_.paths = [param1];
         this._resLoadTaskManager.addLoadTask(_loc3_);
      }
   }
}
