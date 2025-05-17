package com.QQ.angel.utils
{
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   public class SingleLoader
   {
      
      private var m_pathDic:Dictionary;
      
      private var m_loaderToFunDic:Dictionary;
      
      private var m_completefunToDataDic:Dictionary;
      
      public function SingleLoader()
      {
         super();
         this.m_pathDic = new Dictionary();
         this.m_loaderToFunDic = new Dictionary();
         this.m_completefunToDataDic = new Dictionary();
      }
      
      public function load(param1:String, param2:Function, param3:* = null, param4:LoaderContext = null, param5:int = 5) : void
      {
         var _loc6_:NewLoader = null;
         var _loc7_:Array = null;
         if(this.m_pathDic[param1] == true)
         {
            if(param2.length > 0)
            {
               param2(param3);
            }
            else
            {
               param2();
            }
         }
         else
         {
            _loc6_ = this.m_loaderToFunDic[param1];
            if(_loc6_ == null)
            {
               _loc6_ = new NewLoader();
               if(param4 == null)
               {
                  param4 = new LoaderContext(false,ApplicationDomain.currentDomain);
               }
               _loc6_.load(new URLRequest(param1),param4);
               _loc6_.addEventListener(Event.COMPLETE,this.onLoaderComlete);
            }
            this.m_loaderToFunDic[_loc6_] = this.m_loaderToFunDic[_loc6_] || [];
            _loc7_ = this.m_loaderToFunDic[_loc6_];
            if(_loc7_.indexOf(param2) == -1)
            {
               _loc7_.push(param2);
               this.m_completefunToDataDic[param2] = param3;
            }
         }
      }
      
      protected function onLoaderComlete(param1:Event) : void
      {
         var _loc4_:Function = null;
         var _loc5_:* = undefined;
         var _loc2_:NewLoader = NewLoader(param1.currentTarget);
         var _loc3_:Array = this.m_loaderToFunDic[_loc2_];
         this.m_pathDic[_loc2_.url] = true;
         delete this.m_loaderToFunDic[_loc2_];
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = this.m_completefunToDataDic[_loc4_];
            delete this.m_completefunToDataDic[_loc4_];
            if(_loc4_.length > 0)
            {
               _loc4_(_loc5_);
            }
            else
            {
               _loc4_();
            }
         }
      }
   }
}

